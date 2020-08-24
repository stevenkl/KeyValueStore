;test.au3

Func _Dict()
	local $d = ObjCreate("Scripting.Dictionary")
	$d.CompareMode = 1
	return $d
EndFunc

Global $oDotCommands = _Dict()



Local $cmd = _Dict()
Func _KVS_Command_Sys_Help()
	ConsoleWrite("Some help here" & @CRLF)
EndFunc
$cmd.Add("fn", _KVS_Command_Sys_Help)
$cmd.Add("help", "Some help text here")


$oDotCommands.Add(".help", $cmd)


For $name in $oDotCommands.Keys
	ConsoleWrite(StringFormat("%s\t\t%s", $name, $oDotCommands($name).Item("help")) & @CRLF)
	($oDotCommands($name).Item("fn"))()
Next