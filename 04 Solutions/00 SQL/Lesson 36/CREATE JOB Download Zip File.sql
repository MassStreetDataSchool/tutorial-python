-- =============================================
-- Author: Bob Wakefield
-- Create date: 26Oct20
-- Description: Creates the Download Zip File Job.
-- =============================================

USE [msdb]
GO

DECLARE @job_id_var NVARCHAR(100)

SELECT @job_id_var = job_id FROM msdb.dbo.sysjobs WHERE name = 'Download Zip File'

/****** Object:  Job [Download Zip File]    Script Date: 10/26/2020 21:41:55 ******/
EXEC msdb.dbo.sp_delete_job @job_id= @job_id_var, @delete_unused_schedule=1
GO

/****** Object:  Job [Download Zip File]    Script Date: 10/26/2020 21:41:55 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/26/2020 21:41:55 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Download Zip File', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Execute Script]    Script Date: 10/26/2020 21:41:55 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Execute Script', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'python C:\Opt\DownloadZipFile\lesson-36-ex-1.py

SET EXITCODE = %ERRORLEVEL% 
IF %EXITCODE% EQ 0 ( 
   REM Script Ran Sucessfully
   EXIT 0
)
IF %EXITCODE% EQ 1 (
    REM Script Error
    EXIT 1
)', 
		@flags=0, 
		@proxy_name=N'PythonProxy'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


