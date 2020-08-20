;Parse.au3

#include-once

#Region KVS Command Parsing Functions
Func _KVS_ParseJsonObject($sdata)
	local $oData = _JSON_Parse($sData)
	
	; Prepare command object
	local $cmd = __Dict()
	$cmd.Add("command", $oData("cmd"))
	$cmd.Add("arguments", $oData("args"))
	
	Return $cmd
	
EndFunc


Func _KVS_ParseJsonList($sData)
	local $oData = _JSON_Parse($sData)
	
	; Prepare command object
	local $cmd = __Dict()
	$cmd.Add("command", $oData[0])
	
	local $args = _Array()
	For $i = 1 To UBound($oData) - 1
		_ArrayAdd($args, $oData[$i])
	Next
	$cmd.Add("arguments", $args)
	
	Return $cmd
	
EndFunc


Func _KVS_ParseDotCommand($sData)
	local $aArgs = StringSplit($sData, " ", $STR_NOCOUNT)
	local $sCmd = $aArgs[0]
EndFunc


Func _KVS_ParseStringCommand($sData)
	local $aArgs = StringSplit($sData, " ", $STR_NOCOUNT)
EndFunc


Func _KVS_ExecuteCommand($oCmd, $sPar)
	
EndFunc
#EndRegion KVS Command Parsing Functions