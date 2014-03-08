;#########################################################################################
;Realm Of The Mad God
;Cursor Change 21.05.2012 Skraluk
;SetSystemCursor() And RestoreCursors() Functions Made By Kyodan (http://forums.wildshadow.com/user/25740)
;Cursor Made by McFarvo (http://forums.wildshadow.com/user/2139)

#SingleInstance Force

state_cursor_temp_disable=0
state_cursor_alrdy_set=0
state_cursor_alrdy_dis=0

Loop {
	IfWinActive, Realm of the Mad God,
    {
		if(state_cursor_temp_disable = 0)
		{
			if (state_cursor_alrdy_set = 0)
			{
				state_cursor_alrdy_set:=1
				state_cursor_alrdy_dis:=0
				SetSystemCursor()
			}
			
		}
		else
		{
			state_cursor_alrdy_set:=0
			state_cursor_alrdy_dis:=1
			RestoreCursors()
		}
    }
	else
	{
	  if(state_cursor_alrdy_dis = 0 )
	  {
		state_cursor_alrdy_set:=0
		state_cursor_alrdy_dis:=1
		RestoreCursors()
	  }
	}
    Sleep, 1000
}

;#############################################
;Hotkey to temporarily Disable Cursor (easier Looting)
F1::
{
  state_cursor_temp_disable:=!state_cursor_temp_disable
}


;#############################################

SetSystemCursor()
{
Cursor = %A_ScriptDir%\cursor.cur
CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
Loop, Parse, Cursors, `,
{
DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
}
}

RestoreCursors()
{
SPI_SETCURSORS := 0x57
DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
}
