;test.au3
#include <Array.au3>

Func _Dict()
	local $d = ObjCreate("Scripting.Dictionary")
	$d.CompareMode = 1
	return $d
EndFunc

Func _Array()
	local $a = []
	_ArrayDelete($a, 0)
	Return $a
EndFunc


Global $string = "test"
ConsoleWrite(StringFormat("VarGetType($string) = %s", VarGetType($string)) & @CRLF)

Global $integer = 123
ConsoleWrite(StringFormat("VarGetType($integer) = %s", VarGetType($integer)) & @CRLF)

Global $float = 123.24
ConsoleWrite(StringFormat("VarGetType($float) = %s", VarGetType($float)) & @CRLF)

Global $array = _Array()
ConsoleWrite(StringFormat("VarGetType($array) = %s", VarGetType($array)) & @CRLF)

Global $dict = _Dict()
ConsoleWrite(StringFormat("VarGetType($dict) = %s", VarGetType($dict)) & @CRLF)
If IsObj($dict) Then ConsoleWrite(StringFormat("ObjName($dict) = %s", ObjName($dict)) & @CRLF)