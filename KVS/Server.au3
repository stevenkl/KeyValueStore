;Server.au3

#include-once

#Region KVS Server Functions
Func _KVS_ServerOnConnect($iSocket, $sIP)
	ConsoleWrite(StringFormat("Client %s connected.", $sIP) & @CRLF)
	local $d = __Dict()
	$d.Add("version", $g__KVS_Version)
	$d.Add("servername", $g__KVS_Servername)
	_TCPServer_Send($iSocket, _KVS_MessageData($d) & @CRLF)
	
EndFunc


Func _KVS_ServerOnDisconnect($iSocket, $sIP)
	ConsoleWrite(StringFormat("Client %s disconnected.", $sIP) & @CRLF)
	
	; CLearing session etc. for $iSocket
EndFunc


Func _KVS_ServerOnReceive($iSocket, $sIP, $sData, $sPar)
	; Check incomming data
	Local $oCmd = Null
	If $sData <> "" Then
		Switch StringLeft($sData, 1)
			
			Case "{"
				$oCmd = _KVS_ParseJsonObject($sData)
			
			Case "["
				$oCmd = _KVS_ParseJsonList($sData)
				
			Case "."
				$oCmd = _KVS_ParseDotCommand($sData)
				
			Case Else
				$oCmd = _KVS_ParseStringCommand($sData)
				
		EndSwitch
	
		$oCmd.Add("socket", $iSocket)
		$oCmd.Add("ip", $sIP)
		$oCmd.Add("params", $sPar)
		Local $result = _KVS_ExecuteCommand($oCmd)
		
		
		_TCPServer_Send($iSocket, $result & @CRLF)
		
	EndIf
	
EndFunc
#EndRegion KVS Server Functions