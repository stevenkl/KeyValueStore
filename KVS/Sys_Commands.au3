;Sys_Commands.au3

#include-once

#Region KVS System Command Functions
Func _KVS_Command_Sys_Info($aArgs = __Array())
	$oResult = __Dict()
	$oResult.Add("server_name", @ComputerName)
	$oResult.Add("software_name", $g__KVS_Servername)
	$oResult.Add("software_version", $g__KVS_Version)
	$oResult.Add("configuration", $g__KVS_Config)
	
	return _JSON_Generate($oResult, "", "", "", "", "", "", 0)
EndFunc


Func _KVS_Command_Sys_Commands()
	Return _JSON_Generate($g__KVS_ValidCommands, "", "", "", "", "", "", 0)
EndFunc
#EndRegion KVS System Command Functions