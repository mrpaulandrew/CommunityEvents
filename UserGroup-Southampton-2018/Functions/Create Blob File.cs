using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Configuration;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;


namespace FunctionsCodeGenerator
{
    //deserialize the post data
    public class CreateBlobStoreFileBody
    {
        public string fileName { get; set; }
        public string fileExtention { get; set; }
        public string fileContents { get; set; }

        public virtual bool IsValid()
        {
            if (string.IsNullOrEmpty(fileName)
                || string.IsNullOrEmpty(fileExtention)
                || string.IsNullOrEmpty(fileContents)
            ) return false;
            return true;
        }
    }

    public static class CreateBlobStoreFile
    {
        [FunctionName("CreateBlobStoreFile")]
        public static async Task<HttpResponseMessage> Run([HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)]HttpRequestMessage req, TraceWriter log)
        {
            log.Info("Create Blob Storage File Azure Function Called.");

            var requestBody = new CreateBlobStoreFileBody();

            CloudStorageAccount storageAccount = null;

            string sourceFile = null;
            string destinationFile = null;
            string accountConnectionString = ConfigurationManager.AppSettings.Get("blobConnectionString");
            string containerName = ConfigurationManager.AppSettings.Get("scriptPath");

            if (CloudStorageAccount.TryParse(accountConnectionString, out storageAccount))
            {
                try
                {
                    requestBody = await req.Content.ReadAsAsync<CreateBlobStoreFileBody>();
                    if (!requestBody.IsValid())
                        throw new ArgumentException("Supplied body contains parameter which is null or empty string.");

                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                    CloudBlobContainer blobContainer = blobClient.GetContainerReference(containerName);

                    sourceFile = Path.GetTempPath() + requestBody.fileName + "." + requestBody.fileExtention;
                    destinationFile = requestBody.fileName + "." + requestBody.fileExtention;

                    log.Info(sourceFile);
                    log.Info(destinationFile);

                    File.WriteAllText(sourceFile, requestBody.fileContents);

                    CloudBlockBlob cloudBlockBlob = blobContainer.GetBlockBlobReference(destinationFile);
                    await cloudBlockBlob.UploadFromFileAsync(sourceFile);

                    //return req.CreateResponse(HttpStatusCode.OK, "File created successfully.");
                }
                catch (StorageException ex)
                {
                    return req.CreateResponse(HttpStatusCode.BadRequest, ex);
                }
                catch (Exception ex)
                {
                    return req.CreateResponse(HttpStatusCode.BadRequest, ex);
                }
                finally
                {
                    File.Delete(sourceFile);
                }
            }
            else
            {
                log.Error("Invalid connection string provided.");
            }
            return req.CreateResponse(HttpStatusCode.OK, "File created successfully.");
        }
    }
}
