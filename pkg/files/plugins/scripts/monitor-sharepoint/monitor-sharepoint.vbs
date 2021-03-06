Set objWSH =  CreateObject("WScript.Shell")
Set WshSysEnv = objWSH.Environment("Process") 
strComputer = WshSysEnv("UPTIME_HOSTNAME")
strUser = WshSysEnv("UPTIME_USERNAME")
strPassword = WshSysEnv("UPTIME_PASSWORD")


Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20

Set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")
Set objSWbemServices = objSWbemLocator.ConnectServer(strComputer, "\root\CIMV2", strUser, strPassword, "MS_409")
objSWbemServices.Security_.ImpersonationLevel = 3
	

	
Set colItems = objSWbemServices.ExecQuery("SELECT * FROM Win32_PerfFormattedData_OSSArpi_OfficeServerSearchArchivalPlugin", "WQL", wbemFlagReturnImmediately)
IF colItems.Count <> 0 THEN
	For Each objItem In colItems
		WScript.Echo "Totaldocsinfirstqueue " & objItem.Totaldocsinfirstqueue
		WScript.Echo "Totaldocsinsecondqueue " & objItem.Totaldocsinsecondqueue		
	Next
END IF


Set colItems = objSWbemServices.ExecQuery("SELECT * FROM Win32_PerfFormattedData_OSSGTHRSVC_OfficeServerSearchGatherer", "WQL", wbemFlagReturnImmediately)
IF colItems.Count <> 0 THEN
	For Each objItem In colItems
		WScript.Echo "IdleThreads " & objItem.IdleThreads
		WScript.Echo "ThreadsAccessingNetwork " & objItem.ThreadsAccessingNetwork
		WScript.Echo "FilteringThreads " & objItem.FilteringThreads
		WScript.Echo "ThreadsInPlugins " & objItem.ThreadsInPlugins		
	NEXT
END IF 


Set colItems = objSWbemServices.ExecQuery("SELECT * FROM Win32_PerfFormattedData_OSSGatherer_OfficeServerSearchGathererProjects", "WQL", wbemFlagReturnImmediately)
IF colItems.Count <> 0 THEN
	For Each objItem In colItems
      WScript.Echo "Crawlsinprogress " & objItem.Crawlsinprogress
	NEXT
END IF
