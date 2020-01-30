using System;
using System.IO;
using System.Text;
using System.Linq;
using System.Configuration;

using Microsoft.Azure;
using Microsoft.Azure.Management.DataFactories.Models;
using Microsoft.Azure.Management.DataFactories.Runtime;

using Microsoft.Rest;
using Microsoft.Rest.Azure.Authentication;
using Microsoft.Azure.Management.DataLake.Store;

using System.Collections.Generic;
using System.Threading;
using Microsoft.IdentityModel.Clients.ActiveDirectory;

using CustomActivityClasses.Properties;
using Microsoft.Azure.Management.DataLake.Store.Models;

namespace CustomActivityClasses
{
    public class EncodingHelper : IDotNetActivity
    {
        //Get AAD credentials for app
        string domainName = Settings.Default.AADDomain;
        string appId = Settings.Default.AppId;
        string appName = Settings.Default.AppName;
        string appSecret = Settings.Default.AppSecret;

        /* MSDN
        string domainName = Settings.Default.AADDomainMSDN;
        string appId = Settings.Default.AppIdMSDN;
        string appName = Settings.Default.AppNameMSDN;
        string appSecret = Settings.Default.AppSecretMSDN;
        */

        private static DataLakeStoreFileSystemManagementClient adlsFileSystemClient;

        public IDictionary<string, string> Execute(
            IEnumerable<LinkedService> linkedServices,
            IEnumerable<Dataset> datasets,
            Activity activity,
            IActivityLogger logger)
        {
            logger.Write("Starting App: " + appName);

            //Get linked service details
            Dataset inputDataset = datasets.Single(dataset => dataset.Name == activity.Inputs.Single().Name);
            Dataset outputDataset = datasets.Single(dataset => dataset.Name == activity.Outputs.Single().Name);

            AzureDataLakeStoreLinkedService inputLinkedService;
            AzureDataLakeStoreLinkedService outputLinkedService;

            inputLinkedService = linkedServices.First(
                linkedService =>
                linkedService.Name ==
                inputDataset.Properties.LinkedServiceName).Properties.TypeProperties
                as AzureDataLakeStoreLinkedService;

            outputLinkedService = linkedServices.First(
                linkedService =>
                linkedService.Name ==
                outputDataset.Properties.LinkedServiceName).Properties.TypeProperties
                as AzureDataLakeStoreLinkedService;

            //Get account name for data lake and create credentials for app
            var creds = AuthenticateAzure(domainName, appId, appSecret);
            string accountName = inputLinkedService.AccountName;

            adlsFileSystemClient = new DataLakeStoreFileSystemManagementClient(creds);

            //Get input folder and file 
            string inputFolderPath = GetFolderPath(inputDataset);
            string inputFileName = GetFileName(inputDataset);
            string completeInputPath = inputFolderPath + "/" + inputFileName;

            //Get output folder and file 
            string outputFolderPath = GetFolderPath(outputDataset);
            string ouputFileName = GetFileName(outputDataset);
            string completeOuputPath = outputFolderPath + "/" + ouputFileName;

            logger.Write(completeInputPath);
            logger.Write(completeOuputPath);
            logger.Write(accountName);

            //Perform data flow transform

            using (StreamReader vReader = new StreamReader(adlsFileSystemClient.FileSystem.Open(accountName, completeInputPath)))
            {
                var outputStream = new MemoryStream();

                using (StreamWriter vWriter = new StreamWriter(outputStream))
                {
                    string vLine = vReader.ReadLine().Trim();

                    while (!vReader.EndOfStream)
                    {
                        vLine = vReader.ReadLine().Trim();

                        string cleanLine = Encoding.ASCII.GetString(
                            Encoding.Convert(
                                Encoding.UTF8,
                                Encoding.GetEncoding(
                                    Encoding.ASCII.EncodingName,
                                    new EncoderReplacementFallback(string.Empty),
                                    new DecoderExceptionFallback()
                                    ),
                                Encoding.UTF8.GetBytes(vLine)
                            )
                        );

                        vWriter.WriteLine(cleanLine);
                    }

                    logger.Write("Completed stream cleaning iterations.");

                    vWriter.Flush();
                    outputStream.Flush();

                    outputStream.Position = 0;

                    adlsFileSystemClient.FileSystem.Create(accountName, completeOuputPath, outputStream, true);

                    logger.Write("Completed stream output writing.");

                    vWriter.Close();
                }
                outputStream.Close();
            }

            logger.Write("Finished App: " + appName);
            
            return new Dictionary<string, string>();
        }

        //
        //Class support methods
        //
        public static ServiceClientCredentials AuthenticateAzure(string domainName, string clientID, string clientSecret)
        {
            SynchronizationContext.SetSynchronizationContext(new SynchronizationContext());

            var clientCredential = new ClientCredential(clientID, clientSecret);
            return ApplicationTokenProvider.LoginSilentAsync(domainName, clientCredential).Result;
        }

        private static string GetFolderPath(Dataset dataArtifact)
        {
            if (dataArtifact == null || dataArtifact.Properties == null)
            {
                return null;
            }

            AzureDataLakeStoreDataset lakeBlobDataset = dataArtifact.Properties.TypeProperties as AzureDataLakeStoreDataset;
            if (lakeBlobDataset == null)
            {
                return null;
            }

            return lakeBlobDataset.FolderPath;
        }

        private static string GetFileName(Dataset dataArtifact)
        {
            if (dataArtifact == null || dataArtifact.Properties == null)
            {
                return null;
            }

            AzureDataLakeStoreDataset lakeBlobDataset = dataArtifact.Properties.TypeProperties as AzureDataLakeStoreDataset;
            if (lakeBlobDataset == null)
            {
                return null;
            }

            return lakeBlobDataset.FileName;
        }
    }
}
