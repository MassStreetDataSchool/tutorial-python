USE [msdb]
GO


EXEC msdb.dbo.sp_delete_proxy @proxy_name=N'PythonProxy'
GO


EXEC msdb.dbo.sp_add_proxy @proxy_name=N'PythonProxy',@credential_name=N'PythonProxy', 
		@enabled=1
GO

EXEC msdb.dbo.sp_grant_proxy_to_subsystem @proxy_name=N'PythonProxy', @subsystem_id=3
GO

EXEC msdb.dbo.sp_grant_proxy_to_subsystem @proxy_name=N'PythonProxy', @subsystem_id=12
GO


