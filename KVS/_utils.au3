;_utils.
#include-once

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


Func __LoadConfig($sConfigFile = "config.ini")
	local $d = __Dict()
	local $aSections = IniReadSectionNames($sConfigFile)
	If @error Then
		ConsoleWrite(StringFormat("[IniReadSectionNames] @error: %d, @extended: %d", @error, @extended) & @CRLF)
		Exit
	EndIf
	
	For $j = 1 To $aSections[0]
		$dd = __Dict()
		local $aSection = IniReadSection($sConfigFile, $aSections[$j])
		If @error Then
			ConsoleWrite(StringFormat("[IniReadSection] @error: %d, @extended: %d", @error, @extended) & @CRLF)
			Exit
		EndIf
	
		For $i = 1 To $aSection[0][0]
			$dd.Add($aSection[$i][0], $aSection[$i][1])
		Next
		$d.Add($aSections[$j], $dd)
	Next
	Return $d
EndFunc
#EndRegion Helper Functions