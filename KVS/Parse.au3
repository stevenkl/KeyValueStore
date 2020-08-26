;Parse.au3

#include-once

#include <WinAPIShPath.au3>

#Region KVS Command Parsing Functions
Func _KVS_ParseJsonObject($sdata)
	local $oData = _JSON_Parse($sData)
	
	; Prepare command object
	local $cmd = __Dict()
	$cmd.Add("command", $oData("cmd"))
	$cmd.Add("arguments", $oData("args"))
	
	$cmd.Add("type", "jsoncommand")
	
	Return $cmd
	
EndFunc


Func _KVS_ParseJsonList($sData)
	local $oData = _JSON_Parse($sData)
	
	; Prepare command object
	local $cmd = __Dict()
	$cmd.Add("command", $oData[0])
	
	local $args = __Array()
	For $i = 1 To UBound($oData) - 1
		_ArrayAdd($args, $oData[$i])
	Next
	$cmd.Add("arguments", $args)
	
	$cmd.Add("type", "jsoncommand")
	
	Return $cmd
	
EndFunc


Func _KVS_ParseDotCommand($sData)
;~ 	local $aArgs = StringSplit($sData, " ")
	local $aArgs = _WinAPI_CommandLineToArgv($sData)
	local $sCmd = $aArgs[1]
	local $cmd = __Dict()
	
	$cmd.Add("command", StringReplace($sCmd, ".", "sys_") )
	
	If $aArgs[0] < 2 Then
		$cmd.Add("arguments", __Array())
	Else
		$cmd.Add("arguments", _ArrayExtract($aArgs, 2, $aArgs[0]) )
	EndIf
	
	$cmd.Add("type", "dotcommand")
	
	Return $cmd
EndFunc


Func _KVS_ParseStringCommand($sData)
;~ 	local $aArgs = StringSplit($sData, " ")
	local $aArgs = _WinAPI_CommandLineToArgv($sData)
	local $sCmd = $aArgs[1]
	local $cmd = __Dict()
	
	$cmd.Add(	"command", 		$sCmd								)
	$cmd.Add(	"arguments", 	_ArrayExtract($aArgs, 2, $aArgs[0])	)
	
	$cmd.Add("type", "stringcommand")
	
	Return $cmd
EndFunc
#EndRegion KVS Command Parsing Functions