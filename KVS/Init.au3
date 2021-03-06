;Init.au3

#include-once

#Region KVS Startup/Shutdown Functions
Func _KVS_Startup()
	If $g__KVS_StartupComplete = False Then
		
		
		If $g__KVS_Config("server").Item("enable") = True Then
			_TCPServer_OnConnect("_KVS_ServerOnConnect")
			_TCPServer_OnDisconnect("_KVS_ServerOnDisconnect")
			_TCPServer_OnReceive("_KVS_ServerOnReceive")
			_TCPServer_SetMaxClients($g__KVS_Config("server").Item("max_conn"))
			
			_TCPServer_Start( _
				$g__KVS_Config("server").Item("port"), _
				$g__KVS_Config("server").Item("host")  _
			)
		EndIf
		
		
		If $g__KVS_Config("com").Item("enable") = True Then
			; Creating AutoItObject Class and register in ROT
			
		EndIf
		
		
		$g__KVS_Storage = ObjCreate("Scripting.Dictionary")
		$g__KVS_Storage.CompareMode = 1
		
		_KVS_LoadDatabase()
		
		If $g__KVS_Config("storage").Item("interval") <> 0 Then
			AdlibRegister("_KVS_SaveDatabase", $g__KVS_Config("storage").Item("interval"))
		EndIf
		
		OnAutoItExitRegister("_KVS_Shutdown")
		$g__KVS_StartupComplete = True
	EndIf
EndFunc


Func _KVS_Shutdown()
	_TCPServer_Stop()
	_KVS_SaveDatabase()
EndFunc
#EndRegion KVS Startup/Shutdown Functions