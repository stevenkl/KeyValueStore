;*******************************************************************************
;KVS.au3 by Steven Kleist <kleist.steven@gmail.com>
;Created with ISN AutoIt Studio v. 1.11
;*******************************************************************************
#include "vendor\TCPServer.au3"
#include "vendor\JSON.au3"


Global $g__KVS_Storage = Null
Global $g__KVS_StartupComplete = False

#Region KVS Functions
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


Func _KVS_Get($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		Return $g__KVS_Storage.Item($sKey)
	EndIf
	
	Return SetError(1, 0)
EndFunc


Func _KVS_Set($sKey, $sValue)
	$g__KVS_Storage.Item($sKey) = $sValue
	Return True
EndFunc


Func _KVS_Del($sKey)
	If $g__KVS_Storage.Exists($sKey) Then
		$g__KVS_Storage.Remove($sKey)
		Return True
	EndIf
	Return False
EndFunc
#EndRegion


#Region KVS Server Functions
Func _KVS_ServerOnConnect($iSocket, $sIP)
	
EndFunc


Func _KVS_ServerOnDisconnect($iSocket, $sIP)
	
EndFunc


Func _KVS_ServerReceive($iSocket, $sIP, $sData, $sPar)
	
EndFunc
#EndRegion KVS Server Functions


