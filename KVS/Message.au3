;Message.au3

#include-once

#Region KVS Message Functions
Func _KVS_MessageError($sType, $sMsg)
	local $d = __Dict()
	$d.Add("status", "error")
	$d.Add("type", $sType)
	$d.Add("msg", $sMsg)
	Return _JSON_Generate($d, "", "", "", "", "", "", 0)
EndFunc


Func _KVS_MessageOK()
	local $d = __Dict()
	$d.Add("status", "ok")
	Return _JSON_Generate($d, "", "", "", "", "", "", 0)
EndFunc


Func _KVS_MessageData($oData, $sStatus = "ok")
	local $d = __Dict()
	$d.Add("status", $sStatus)
	$d.Add("data", $oData)
	Return _JSON_Generate($d, "", "", "", "", "", "", 0)
EndFunc
#EndRegion KVS Message Functions