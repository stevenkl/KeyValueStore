;Hash_Commands.au3

#include-once


#Region KVS Hash Command Functions
Func _KVS_Command_HGet($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $sField = $aCmdArgs[1]
	
	If $g__KVS_Storage.Exists($sKey) Then
		local $oHash = $g__KVS_Storage.Item($sKey)
		If $oHash.Exists($sField) Then
			Local $sValue = $oHash.Item($sField)
			Return StringFormat("$%d\r\n%s", StringLen($sValue), $sValue)
		EndIf
	EndIf
	Return "$-1"
EndFunc


Func _KVS_Command_HSet($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $aPairs = _ArrayExtract($aCmdArgs, 1)
	
	If Not $g__KVS_Storage.Exists($sKey) Then
		$g__KVS_Storage.Item($sKey) = __Dict()
	EndIf
	
	
	Local $oHash = $g__KVS_Storage.Item($sKey)
	For $i = 0 To UBound($aPairs) - 1 Step 2
		$oHash.Item($aPairs[$i]) = $aPairs[$i+1]
	Next
	$g__KVS_Storage.Item($sKey) = $oHash
	
	Return "+OK"
	
EndFunc


Func _KVS_Command_HDel($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $aFields = _ArrayExtract($aCmdArgs, 1)
	
	Local $iDelCount = 0
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		For $i = 0 To UBound($aFields) - 1
			If $oHash.Exists($aFields[$i]) Then
				$oHash.Remove($aFields[$i])
				$iDelCount += 1
			EndIf
		Next
	EndIf
	
	Return StringFormat(":%d", $iDelCount)
EndFunc


Func _KVS_Command_HExists($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $sField = $aCmdArgs[1]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		If $oHash.Exists($sField) Then
			Return ":1"
		EndIf
	EndIf
	
	Return ":0"
EndFunc


Func _KVS_Command_HKeys($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
;~ 	Local $sField = $aCmdArgs[1]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		Local $aFields = $oHash.Keys
		Return _JSON_Generate($aFields, "", "", "", "", "", "")
	EndIf
	
	Return _JSON_Generate(__Array(), "", "", "", "", "", "")
EndFunc


Func _KVS_Command_HVals($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $aHashValues = __Array()
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		Local $aFields = $oHash.Keys
		For $i = 0 To UBound($aFields) - 1
			_ArrayAdd($aHashValues, $oHash.Item($aFields[$i]))
		Next
	EndIf
	
	Return _JSON_Generate($aHashValues, "", "", "", "", "", "")
EndFunc


Func _KVS_Command_HLen($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $iCount = 0
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		Local $aFields = $oHash.Keys
		$iCount = UBound($aFields)
	EndIf
	
	Return StringFormat(":%d", $iCount)
EndFunc


Func _KVS_Command_HStrlen($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $sField = $aCmdArgs[1]
	Local $iCount = 0
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $oHash = $g__KVS_Storage.Item($sKey)
		If $oHash.Exists($sField) Then
			Local $sValue = $oHash.Item($sField)
			$iCount = StringLen($sValue)
		EndIf
	EndIf
	
	Return StringFormat(":%d", $iCount)
EndFunc
#EndRegion KVS Hash Command Functions