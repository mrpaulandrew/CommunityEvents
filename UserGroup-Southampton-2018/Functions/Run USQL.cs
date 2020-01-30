using System;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Azure.Management.DataLake.Analytics;
using Microsoft.Azure.Management.DataLake.Analytics.Models;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Rest;
using Microsoft.Rest.Azure.Authentication;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using System.Threading;

namespace FunctionsCodeGenerator
{
    //deserialize the post data
    public class RunUSQLJobBody
    {
        public string dataflowname { get; set; }
        public string usql { get; set; }
        
        public virtual bool IsValid()
        {
            if (string.IsNullOrEmpty(usql)
                || string.IsNullOrEmpty(dataflowname)
            ) return false;
            return true;
        }
    }
    public static class RunUSQLJob
    {
        [FunctionName("RunUSQLJob")]
        public static async Task<HttpResponseMessage> Run([HttpTrigger(AuthorizationLevel.Function, "Post", Route = "")]HttpRequestMessage req, TraceWriter log)
        {
            log.Info("Run USQL Job Azure Function Called.");

            var requestBody = new RunUSQLJobBody();

            try
            {
                requestBody = await req.Content.ReadAsAsync<RunUSQLJobBody>();
                if (!requestBody.IsValid())
                    throw new ArgumentException("Supplied body contains parameter which is null or empty string.");

                log.Info("usqlScript:" + requestBody.usql);

                string adlaAccountName = ConfigurationManager.AppSettings.Get("adlaAccountName");
                string tenantName = ConfigurationManager.AppSettings.Get("tenantName");
                string appId = ConfigurationManager.AppSettings.Get("appId");
                string appSecret = ConfigurationManager.AppSettings.Get("appSecret");

                log.Info("Tenant: " + tenantName);
                log.Info("AppId: " + appId);

                //authenticate against adla account
                var adlCreds = AuthenticateAzure(tenantName, appId, appSecret);
                var adlaJobClient = new DataLakeAnalyticsJobManagementClient(adlCreds);

                //create usql job frame
                var jobId = Guid.NewGuid();
                var adlaJobProperties = new USqlJobProperties(requestBody.usql);
                var adlaJobParameters = new JobInformation("Auto Procedure Creator - " + requestBody.dataflowname, JobType.USql, adlaJobProperties, priority: 1, degreeOfParallelism: 1, jobId: jobId);

                //create job
                var jobCreator = adlaJobClient.Job.Create(adlaAccountName, jobId, adlaJobParameters);

                return req.CreateResponse(HttpStatusCode.OK, "ADLA job submitted. Id: " + jobId.ToString());
            }
            catch (Exception ex)
            {
                return req.CreateResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        private static ServiceClientCredentials AuthenticateAzure(string domainName, string clientID, string clientSecret)
        {
            SynchronizationContext.SetSynchronizationContext(new SynchronizationContext());

            var clientCredential = new ClientCredential(clientID, clientSecret);
            return ApplicationTokenProvider.LoginSilentAsync(domainName, clientCredential).Result;
        }
    }
}
