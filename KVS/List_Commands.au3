;List_Commands.au3

#include-once

#include "_utils.au3"


#Region KVS List Command Functions
Func _KVS_Command_RPush($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	local $sKey = $aCmdArgs[0]
	
	Local $arr = __Array()
	If $g__KVS_Storage.Exists($sKey) Then
		$arr = $g__KVS_Storage.Item($sKey)
	EndIf
	
	Local $aItemsToAdd = _ArrayExtract($aCmdArgs, 1, UBound($aCmdArgs) - 1)
	For $i = 0 To UBound($aItemsToAdd) - 1
		_ArrayAdd($arr, $aItemsToAdd[$i])
	Next
	
	$g__KVS_Storage.Item($sKey) = $arr
	Return True
	
EndFunc


Func _KVS_Command_RPop($oCmd)
	Local $sKey = ($oCmd("arguments"))[0]
	
	If $g__KVS_Storage.Exists($sKey) Then
		local $list = $g__KVS_Storage.Item($sKey)
		local $lastIndex = UBound($list)-1
		local $value = $list[$lastIndex]
		_ArrayDelete($list, $lastIndex)
		$g__KVS_Storage.Item($sKey) = $list
		Return $value
	EndIf
	Return False
EndFunc


Func _KVS_Command_LPop($oCmd)
	Local $sKey = ($oCmd("arguments"))[0]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $arr = $g__KVS_Storage.Item($sKey)
		Local $val = $arr[0]
		_ArrayDelete($arr, 0)
		$g__KVS_Storage.Item($sKey) = $arr
		Return $val
	EndIf
	Return False
EndFunc


Func _KVS_Command_LPush($oCmd)
	Local $aCmdArgs = $oCmd("arguments")
	Local $sKey = $aCmdArgs[0]
	Local $aValues = _ArrayExtract($aCmdArgs, 1)
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $aOldValues = $g__KVS_Storage.Item($sKey)
		_ArrayConcatenate($aValues, $aOldValues)
		$g__KVS_Storage.Item($sKey) = $aValues
		Return StringFormat(":%d", UBound($aValues))
	EndIf
	Return False
EndFunc


Func _KVS_Command_LLen($oCmd)
	Local $sKey = ($oCmd("arguments"))[0]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $item = $g__KVS_Storage.Item($sKey)
		If VarGetType($item) = "Array" Then
			Return UBound($item)
		EndIf
		
		Return False
	EndIf
	
	Return False
EndFunc


Func _KVS_Command_LIndex($oCmd)
	Local $sKey = ($oCmd("arguments"))[0]
	Local $iIndex = ($oCmd("arguments"))[1]
	
	If $g__KVS_Storage.Exists($sKey) Then
		Local $item = $g__KVS_Storage.Item($sKey)
		
		If UBound($item)-1 >= $iIndex Then
			If $iIndex < 0 Then Return "-Error: Negative List Index is not allowd."
			Return $item[$iIndex]
		EndIf
		
		Return False
	EndIf
	
	Return False
EndFunc
#EndRegion KVS List Command Functions