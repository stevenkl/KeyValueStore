;*******************************************************************************
;KVS.au3 by Steven Kleist <kleist.steven@gmail.com>
;Created with ISN AutoIt Studio v. 1.11
;*******************************************************************************
#include <Array.au3>
#include <StringConstants.au3>

#include "vendor\TCPServer.au3"
#include "vendor\JSON.au3"


Global $g__KVS_Servername      = "KVS"
Global $g__KVS_Version         = "0.0.1"

Global $g__KVS_Storage         = Null
Global $g__KVS_StartupComplete = False

Global $g__KVS_ValidCommands   = [ _
	"get", _
	"set", _
	"del" _
]



#Region Helper Functions
Func __Array()
	local $arr = []
	_ArrayDelete($arr, 0)
	Return $arr
EndFunc


Func __Dict()
	Local $dict = ObjCreate("Scripting.Dictionary")
	$dict.CompareMode = 1
	Return $dict
EndFunc
#EndRegion Helper Functions



#Region KVS Startup/Shutdown Functions
Func _KVS_Startup()
	If $g__KVS_StartupComplete = False Then
		$g__KVS_Storage = ObjCreate("Scripting.Dictionary")
		$g__KVS_Storage.CompareMode = 1
		
		_TCPServer_OnConnect("_KVS_ServerOnConnect")
		_TCPServer_OnDisconnect("_KVS_ServerOnDisconnect")
		_TCPServer_OnReceive("_KVS_ServerOnReceive")
		_TCPServer_SetMaxClients(10)
		
		_TCPServer_Start(9736, "127.0.0.1")
		
		$g__KVS_StartupComplete = True
	EndIf
EndFunc


Func _KVS_Shutdown()
	
EndFunc
#EndRegion KVS Startup/Shutdown Functions



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
#EndRegion



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
EndFunc


Func _KVS_ServerOnReceive($iSocket, $sIP, $sData, $sPar)
	If $sData <> "" Then
		local $oData = _JSON_Parse($sData)
		
		If Not $oData.Exists("cmd") Then
			_TCPServer_Send($iSocket, _KVS_MessageError("command.format", "Malformed command format.") & @CRLF)
			Return
		EndIf
		
		local $cmd = $oData.Item("cmd")
		
		If _ArraySearch($g__KVS_ValidCommands, $cmd) = -1 Then
			_TCPServer_Send($iSocket, _KVS_MessageError("command.notallowed", "The given command is not allowed.") & @CRLF)
			Return
		EndIf
		
		
		; Going throw available commands
		
		Switch $cmd
			
			Case "get"
				Local $args = $oData.Item("args")
				Local $result = _KVS_Get($args[0])
				_TCPServer_Send($iSocket, _KVS_MessageData($result) & @CRLF)
				Return True
				
			Case "set"
				Local $args = $oData.Item("args")
				Local $result = _KVS_Set($args[0], $args[1])
				If @error Then
					_TCPServer_Send($iSocket, _KVS_MessageError("command.set", StringFormat("%d:%d", @error, @extended)) & @CRLF)
				Else
					_TCPServer_Send($iSocket, _KVS_MessageOK() & @CRLF)
					Return True
				EndIf
				
			Case "del"
				Local $args = $oData.Item("args")
				Local $result = _KVS_Del($args[0])
				If @error Then
					_TCPServer_Send($iSocket, _KVS_MessageError("command.del", StringFormat("%d:%d", @error, @extended)) & @CRLF)
				Else
					_TCPServer_Send($iSocket, _KVS_MessageOK() & @CRLF)
					Return True
				EndIf

		EndSwitch
		
	EndIf
EndFunc
#EndRegion KVS Server Functions



#Region KVS COM Functions

#EndRegion KVS COM Functions

