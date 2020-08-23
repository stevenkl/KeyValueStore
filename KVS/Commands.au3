;Commands.au3

#include-once

#Region KVS Command Functions
Func _KVS_ExecuteCommand($oCmd, $iSocket, $sIP, $sPar)
	local $sFuncName = StringFormat("_KVS_Command_%s", $oCmd("command"))
	local $aCallArgs = __Array()
	
	_ArrayAdd($aCallArgs, "CallArgArray")
	$iResult = _ArrayConcatenate($aCallArgs, ($oCmd("arguments")) )
	
	$sCommandResult = Call($sFuncName, $aCallArgs)
	if @error then
		if @error = 0xDEAD And @extended = 0xBEEF Then
			ConsoleWrite(StringFormat("Function %s doesn't exist or number of arguments are incorrect.", $sFuncName) & @CRLF)
		EndIf
	EndIf
	
	Return $sCommandResult
EndFunc


Func _KVS_Command_Get($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return SetError(1, 0, False)
EndFunc


Func _KVS_Command_Set($sKey, $sValue)
	$g__KVS_Storage.Item($sKey) = $sValue
	If @error Then Return SetError(1, 1, False)
	Return True
EndFunc


Func _KVS_Command_Del($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		$g__KVS_Storage.Remove($sKey)
		Return True
	EndIf
	Return SetError(1, 1, False)
EndFunc


Func _KVS_Command_Incr($sKey, $iValue = 1)
	If $g__KVS_Storage.Exists($sKey) Then
		local $item = Number($g__KVS_Storage.Item($sKey))
		$item += $iValue
		
		$g__KVS_Storage.Item($sKey) = $item
		
		Return True
	EndIf
	
	Return False
EndFunc


Func _KVS_Command_Decr($sKey, $iValue = 1)
	If $g__KVS_Storage.Exists($sKey) Then
		local $item = Number($g__KVS_Storage.Item($sKey))
		$item -= $iValue
		
		$g__KVS_Storage.Item($sKey) = $item
		
		Return True
	EndIf
	
	Return False
EndFunc
#EndRegion KVS Command Functions