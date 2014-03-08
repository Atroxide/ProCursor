/*
	RotMG ProCursor

	Optional Settings:
*/

	; Set this to the key you want to use to temporarily disable the cursor.
	; The avaliable options (and avaliable modifiers) are located at http://www.autohotkey.com/docs/KeyList.htm
	hotkey_to_disable = F1 

	; Set this for which cursor you would like to use.
	; Avaliable options:
	; 	thin_rainbow, 	classic_rainbow, 
	;	square_red,		circle_red,		 classic_red, 
	;	square_blue,	circle_blue,	 classic_blue
	cursor_style = thin_rainbow

/* -----Do not edit below this line-----
*/


#SingleInstance Force

Hotkey, %hotkey_to_disable%, ManualDisableHotkey, On

; Window Group to target any window identified as RotMG
GroupAdd, groupRotMG, Realm of the Mad God,		 ; Official Site and Steam
GroupAdd, groupRotMG, Adobe Flash Player,		 ; Flash Projector
GroupAdd, groupRotMG, Play Realm of the Mad God, ; Kongregate

manualDisabled := false
cursorSet := false

TrayTip, ,ProCursor Enabled

Loop {
	if(!manualDisabled) {
		IfWinActive, ahk_group groupRotMG,
		{
			if (!cursorSet) {
				cursorSet := true
				SetSystemCursor()
			}
		} else {
			if (cursorSet) {
				cursorSet := false
				RestoreCursors()
			}
		}
	}
	Sleep, 1000
}

ManualDisableHotkey:
	if (!manualDisabled) {
		TrayTip, ,ProCursor Disabled. Press %hotkey_to_disable% to re-enable.
		if (cursorSet) {
			cursorSet := false
			RestoreCursors()
		}
	} else {
		TrayTip, ,ProCursor Enabled. Press %hotkey_to_disable% to disable.
	}
	manualDisabled := !manualDisabled
return

SetSystemCursor() {
	global cursor_style
	Cursor = %A_ScriptDir%\cursors\%cursor_style%.cur
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
	Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
	Loop, Parse, Cursors, `, 
	{
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
	}
}

RestoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
}
