;String_Commands.au3

#include-once


#Region KVS String Command Functions
;~ Func _KVS_Command_Get($sKey)
Func _KVS_Command_Get($oCmd)
	local $sKey = ($oCmd("arguments"))[0]
	If $g__KVS_Storage.Exists($sKey) Then
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return SetError(1, 0, False)
EndFunc


;~ Func _KVS_Command_Set($sKey, $sValue)
Func _KVS_Command_Set($oCmd)
	local $sKey = ($oCmd("arguments"))[0]
	local $sValue = ($oCmd("arguments"))[1]
	$g__KVS_Storage.Item($sKey) = $sValue
	If @error Then Return SetError(1, 1, False)
	Return "+OK"
EndFunc


;~ Func _KVS_Command_Del($sKey)
Func _KVS_Command_Del($oCmd)
	local $sKey = ($oCmd("arguments"))[0]
	If $g__KVS_Storage.Exists($sKey) Then
		$g__KVS_Storage.Remove($sKey)
		Return "+OK"
	EndIf
	Return SetError(1, 1, False)
EndFunc


;~ Func _KVS_Command_Incr($sKey, $iValue = 1)
Func _KVS_Command_Incr($oCmd)
	local $aCmdArgs = ($oCmd("arguments"))
	local $sKey = $aCmdArgs[0]
	Local $iValue = 1
	If UBound($aCmdArgs) >= 2 Then
		$iValue = Number($aCmdArgs[1])
	EndIf
	
	If $g__KVS_Storage.Exists($sKey) Then
		local $item = Number($g__KVS_Storage.Item($sKey))
		$item += $iValue
		
		$g__KVS_Storage.Item($sKey) = $item
		
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return False
EndFunc


;~ Func _KVS_Command_Decr($sKey, $iValue = 1)
Func _KVS_Command_Decr($oCmd)
	local $aCmdArgs = ($oCmd("arguments"))
	local $sKey = $aCmdArgs[0]
	Local $iValue = 1
	If UBound($aCmdArgs) >= 2 Then
		$iValue = Number($aCmdArgs[1])
	EndIf
	
	If $g__KVS_Storage.Exists($sKey) Then
		local $item = Number($g__KVS_Storage.Item($sKey))
		$item -= $iValue
		
		$g__KVS_Storage.Item($sKey) = $item
		
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return False
EndFunc


Func _KVS_Command_Exists($oCmd)
	Local $sKey = ($oCmd("arguments"))[0]
	If $g__KVS_Storage.Exists($sKey) Then Return True
	Return False
EndFunc


Func _KVS_Command_Keys($oCmd)
	Local $sPattern = ($oCmd("arguments"))[0]
	Local $aKeys = $g__KVS_Storage.Keys()
	Local $aMatches = __Array()
	
	For $i = 0 To UBound($aKeys) - 1
		If StringRegExp($aKeys[$i], $sPattern) Then
			_ArrayAdd($aMatches, $aKeys[$i])
		EndIf
	Next
	
	Return _JSON_Generate($aMatches)
EndFunc


Func _KVS_Command_Rename($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sOldName = $aCmdArgs[0]
	Local $sNewName = $aCmdArgs[1]
	
	If $g__KVS_Storage.Exists($sNewName) Then
		Return StringFormat("-Error: Key '%s' already exists.", $sNewName)
	EndIf
	
	If not $g__KVS_Storage.Exists($sOldName) Then
		Return StringFormat("-Error: Key '%s' doesn't exists.", $sOldName)
	EndIf
	
	Local $oValue = $g__KVS_Storage.Item($sOldName)
	$g__KVS_Storage.Item($sNewName) = $oValue
	$g__KVS_Storage.Remove($sOldName)
	
	Return "+OK"
	
EndFunc


Func _KVS_Command_Append($oCmd)
	Local $sKey   = ($oCmd("arguments"))[0]
	Local $sValue = ($oCmd("arguments"))[1]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $sOldValue = $g__KVS_Storage.Item($sKey)
		$sOldValue &= $sValue
		$g__KVS_Storage.Item($sKey) = $sOldValue
		
		Return "+OK"
	EndIf
	
	Return _KVS_Command_Set($oCmd)
EndFunc


Func _KVS_Command_Strlen($oCmd)
	local $sKey = ($oCmd("arguments"))[0]
	If $g__KVS_Storage.Exists($sKey) Then
		Return StringFormat(":%d", StringLen($g__KVS_Storage.Item($sKey)))
	EndIf
	
	Return False
EndFunc
#EndRegion KVS String Command Functions