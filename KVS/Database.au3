;Data.au3

#include-once

#include <FileConstants.au3>

#Region KVS Data Functions
Func _KVS_LoadDatabase()
	local $sfilePath = StringFormat( _
		"%s\kvsdump.json", _
		$g__KVS_Config("storage").Item("location") _
	)
	
	If FileExists($sFilePath) Then
		local $hDB = FileOpen($sfilePath)
		
		local $sContent = FileRead($hDB)
		$g__KVS_Storage = _JSON_Parse($sContent)
		
		FileClose($hDB)
		Return True
	EndIf
	Return False
EndFunc


Func _KVS_SaveDatabase()
	local $sfilePath = StringFormat( _
		"%s\kvsdump.json", _
		$g__KVS_Config("storage").Item("location") _
	)
	
	local $hDB = FileOpen($sfilePath, $FO_OVERWRITE + $FO_CREATEPATH)
		
	local $iResult = FileWrite( _
		$hDB, _
		_JSON_Generate($g__KVS_Storage, "", "", "", "", "", "", 0) _
	)
	If $iResult <> 1 Then
		ConsoleWrite(StringFormat("Error: Can't dump file '%s' to disk.", $sFilePath) & @CRLF)
		Return False
	EndIf
	
	FileClose($hDB)
	Return True
EndFunc
#EndRegion KVS Data Functions