;Data.au3

#include-once

#Region KVS Data Functions
Func _KVS_Get($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return SetError(1, 0, False)
EndFunc


Func _KVS_Set($sKey, $sValue)
	$g__KVS_Storage.Item($sKey) = $sValue
	If @error Then Return SetError(1, 1, False)
	Return True
EndFunc


Func _KVS_Del($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		$g__KVS_Storage.Remove($sKey)
		Return True
	EndIf
	Return SetError(1, 1, False)
EndFunc
#EndRegion KVS Data Functions