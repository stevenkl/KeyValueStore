;Sys_Commands.au3

#include-once

#Region KVS System Command Functions
Func _KVS_Command_Sys_Info($aArgs = __Array(), $oCmd = Default)
	$oResult = __Dict()
	$oResult.Add("server_name", @ComputerName)
	$oResult.Add("software_name", $g__KVS_Servername)
	$oResult.Add("software_version", $g__KVS_Version)
	$oResult.Add("configuration", $g__KVS_Config)

	return _JSON_Generate($oResult, "", "", "", "", "", "", 0)
EndFunc


Func _KVS_Command_Sys_Commands($oCmd = Default)
	Return _JSON_Generate($g__KVS_ValidCommands, "", "", "", "", "", "", 0)
EndFunc


Func _KVS_Command_Sys_Save($oCmd = Default)
	Return _KVS_SaveDatabase()
EndFunc


Func _KVS_Command_Sys_Help($sSection = "all", $oCmd = Default)
	local $sHelpMsg = ""
	$sHelpMsg &= "Help message for all commands comes here." & @CRLF
		
	return $sHelpMsg
EndFunc

Func _KVS_Command_Sys_Exit($oCmd = Default)
	_TCPServer_Close($oCmd("socket"))
	return True
EndFunc
#EndRegion KVS System Command Functions