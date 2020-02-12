using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Microsoft.Azure.EventHubs;
using Newtonsoft.Json;
using ThroughPutController;

namespace MessageBlaster
{
    class Program
    {
        private static EventHubClient eventHubClient;
        private static Random _random = new Random();
        private static readonly SliderControl form = new SliderControl();

        #region SQL Connection Info
        private const string instance = ".database.windows.net";
        private const string user = "";
        private const string pass = "";
        private const string db = "";
        #endregion

        static void Main(string[] args)
        {
            Task task1 = Task.Factory.StartNew(() => SendMessages());
            Task task2 = Task.Factory.StartNew(() => StartController());

            Task.WaitAll(task1, task2);           
        }

        static void StartController()
        { 
            System.Windows.Forms.Application.Run(form);
        }

        static void SendMessages()
        { 
            int x = 1;
            while(x==1)
            {
                //Console.ForegroundColor = GetRandomConsoleColor();

                ConnectionStrings[] connections = GetEHConnectionString();
                SalesDetailLine[] orderLine = GetOrderLine();
                
                Console.WriteLine("----------------Sending Data To All Provided Connections----------------");
                
                for (var i = 0; i < connections.Length; i++)
                {
                    string infoLine = "Sending data to " + connections[i].Owner + "'s event hub.";

                    Console.WriteLine(infoLine);
   
                    var message = JsonConvert.SerializeObject(orderLine);

                    EventHubWrapper(connections[i].ConnectionString, connections[i].HubName, message).GetAwaiter().GetResult();   
                }

                Console.WriteLine("------------------------------------------------------------------------");

                //Console.WriteLine(form.Seconds.ToString());

                System.Threading.Thread.Sleep(form.Seconds * 1000);

                Console.WriteLine("");
                Console.WriteLine("");

                Console.ResetColor();
            }
           
        }

        private static async Task EventHubWrapper(string connectionString, string hubName, string message)
        {
            var connectionStringBuilder = new EventHubsConnectionStringBuilder(connectionString)
            {
                EntityPath = hubName
            };

            eventHubClient = EventHubClient.CreateFromConnectionString(connectionStringBuilder.ToString());

            await SendMessageToEventHub(message);

            await eventHubClient.CloseAsync();
        }

        private static async Task SendMessageToEventHub(string message)
        {
            await eventHubClient.SendAsync(new EventData(Encoding.UTF8.GetBytes(message)));
        }

        private static ConnectionStrings[] GetEHConnectionString()
        {
            ConnectionStrings[] allRecords = null;

            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                builder.DataSource = instance;
                builder.UserID = user;
                builder.Password = pass;
                builder.InitialCatalog = db;

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {

                    connection.Open();

                    String sql = "SELECT * FROM [dbo].[EHConnections]";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            var list = new List<ConnectionStrings>();

                            while (reader.Read())
                            {
                                list.Add(new ConnectionStrings { Owner = reader.GetString(0), ConnectionString = reader.GetString(1), HubName = reader.GetString(2)});

                                allRecords = list.ToArray();
                            }
                        }
                    }
                }

                return allRecords;
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());

                return allRecords;
            }
        }

        private static SalesDetailLine[] GetOrderLine()
        {
            SalesDetailLine[] detailLine = null;

            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                builder.DataSource = instance;
                builder.UserID = user;
                builder.Password = pass;
                builder.InitialCatalog = db;

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {

                    connection.Open();

                    String sql = "SELECT TOP 1 CAST([SalesOrderID] AS VARCHAR) AS [SalesOrderID], CAST([SalesOrderDetailID] AS VARCHAR) AS [SalesOrderDetailID],	CAST([OrderQty] AS VARCHAR) AS [OrderQty],	CAST([ProductID] AS VARCHAR) AS [ProductID],	CAST([UnitPrice] AS VARCHAR) AS [UnitPrice],	CAST([UnitPriceDiscount] AS VARCHAR) AS [UnitPriceDiscount],	CAST([LineTotal] AS VARCHAR) AS [LineTotal] FROM 	[SalesLT].[SalesOrderDetail] ORDER BY NEWID()";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            var list = new List<SalesDetailLine>();

                            while (reader.Read())
                            {
                                list.Add(new SalesDetailLine
                                {
                                    SalesOrderID = reader.GetString(0),
                                    SalesOrderDetailID = reader.GetString(1),
                                    OrderQty = reader.GetString(2),
                                    ProductID = reader.GetString(3),
                                    UnitPrice = reader.GetString(4),
                                    UnitPriceDiscount = reader.GetString(5),
                                    LineTotal = reader.GetString(6)
                                }
                                );

                                detailLine = list.ToArray();
                            }
                        }
                    }
                }
                return detailLine;
            }

            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());

                return detailLine;
            }
        }
        
        private static ConsoleColor GetRandomConsoleColor()
        {
            var consoleColors = Enum.GetValues(typeof(ConsoleColor));
            return (ConsoleColor)consoleColors.GetValue(_random.Next(consoleColors.Length));
        }


    }
}
