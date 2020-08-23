;*******************************************************************************
;KVS.au3 by Steven Kleist <kleist.steven@gmail.com>
;Created with ISN AutoIt Studio v. 1.11
;*******************************************************************************
#include <Array.au3>
#include <StringConstants.au3>

#include "vendor\_autoload.au3"

#include "KVS\_utils.au3"
#include "KVS\Init.au3"
#include "KVS\Commands.au3"
#include "KVS\Sys_Commands.au3"
#include "KVS\Database.au3"
#include "KVS\Message.au3"
#include "KVS\Parse.au3"
#include "KVS\Server.au3"
#include "KVS\COM.au3"


Global $g__KVS_Servername      = "KVS"
Global $g__KVS_Version         = "0.0.1"

Global $g__KVS_Storage         = Null
Global $g__KVS_StartupComplete = False

Global $g__KVS_Config          = __LoadConfig()

Global $g__KVS_ValidCommands   = [ _
	"get", _
	"set", _
	"del", _
	"incr", _
	"decr" _
]


_KVS_Startup()
While 1
	Sleep(100)
Wend
