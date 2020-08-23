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
	
		Local $result = _KVS_ExecuteCommand($oCmd, $iSocket, $sIP, $sPar)
		
		
		_TCPServer_Send($iSocket, $result & @CRLF)
		
	EndIf
	
	
	
;~ 	If $sData <> "" Then
;~ 		local $oData = _JSON_Parse($sData)
;~ 		
;~ 		If Not $oData.Exists("cmd") Then
;~ 			_TCPServer_Send($iSocket, _KVS_MessageError("command.format", "Malformed command format.") & @CRLF)
;~ 			Return
;~ 		EndIf
;~ 		
;~ 		local $cmd = $oData.Item("cmd")
;~ 		
;~ 		If _ArraySearch($g__KVS_ValidCommands, $cmd) = -1 Then
;~ 			_TCPServer_Send($iSocket, _KVS_MessageError("command.notallowed", "The given command is not allowed.") & @CRLF)
;~ 			Return
;~ 		EndIf
;~ 		
;~ 		
;~ 		; Going throw available commands
;~ 		
;~ 		Switch $cmd
;~ 			
;~ 			Case "get"
;~ 				Local $args = $oData.Item("args")
;~ 				Local $result = _KVS_Get($args[0])
;~ 				_TCPServer_Send($iSocket, _KVS_MessageData($result) & @CRLF)
;~ 				Return True
;~ 				
;~ 			Case "set"
;~ 				Local $args = $oData.Item("args")
;~ 				Local $result = _KVS_Set($args[0], $args[1])
;~ 				If @error Then
;~ 					_TCPServer_Send($iSocket, _KVS_MessageError("command.set", StringFormat("%d:%d", @error, @extended)) & @CRLF)
;~ 				Else
;~ 					_TCPServer_Send($iSocket, _KVS_MessageOK() & @CRLF)
;~ 					Return True
;~ 				EndIf
;~ 				
;~ 			Case "del"
;~ 				Local $args = $oData.Item("args")
;~ 				Local $result = _KVS_Del($args[0])
;~ 				If @error Then
;~ 					_TCPServer_Send($iSocket, _KVS_MessageError("command.del", StringFormat("%d:%d", @error, @extended)) & @CRLF)
;~ 				Else
;~ 					_TCPServer_Send($iSocket, _KVS_MessageOK() & @CRLF)
;~ 					Return True
;~ 				EndIf
;~ 
;~ 		EndSwitch
;~ 		
;~ 	EndIf
EndFunc
#EndRegion KVS Server Functions