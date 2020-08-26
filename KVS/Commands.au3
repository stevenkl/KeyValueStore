;Commands.au3

#include-once

#Region KVS Command Functions
Func _KVS_ExecuteCommand($oCmd)
	local $sFuncName = StringFormat("_KVS_Command_%s", $oCmd("command"))
	
	$sCommandResult = Call($sFuncName, $oCmd)
	if @error then
		if @error = 0xDEAD And @extended = 0xBEEF Then
			ConsoleWrite(StringFormat("Function %s doesn't exist or number of arguments are incorrect.", $sFuncName) & @CRLF)
		EndIf
	EndIf
	
	Return $sCommandResult
EndFunc


Func _KVS_Command_Type($oCmd)
	local $sKey = ($oCmd("arguments"))[0]
	
	If $g__KVS_Storage.Exists($sKey) Then
		local $item = $g__KVS_Storage.Item($sKey)
		Return VarGetType($item)
	EndIf
	
	Return False
EndFunc


Func _KVS_Command_Ping($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	If UBound($aCmdArgs) > 0 Then
		Return StringFormat("+%s", $aCmdArgs[0])
	EndIf
	Return "+PONG"
EndFunc
#EndRegion KVS Command Functions