Declare @execution_id bigint;  

EXEC [SSISDB].[catalog].[create_execution] 
	@package_name=N'SampleCSVMove.dtsx', 
	@execution_id=@execution_id OUTPUT,
	@folder_name=N'DemoPackages',
	@project_name=N'AzureSSIS',
	@use32bitruntime=False; 
	
EXEC [SSISDB].[catalog].[start_execution] 
	@execution_id;