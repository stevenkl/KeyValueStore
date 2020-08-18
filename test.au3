;test.au3

#include "KVS.au3"

_KVS_Startup()

_KVS_Set('name', 'Steven')

ConsoleWrite(StringFormat("Hello, %s!", _KVS_Get('name')) & @CRLF)

While 1
	Sleep(100)
Wend