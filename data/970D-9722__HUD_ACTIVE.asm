; menu/HUD state flags: HUD_ACTIVE = in-game HUD active; IN_MENU = in main menu;
; PANEL_DRAWN = panel-drawn-once flag.
HUD_ACTIVE:
	DB $00
IN_MENU:
	DB $00,$01
PANEL_DRAWN:
	DB $FF
; colour-cycle sequence (0-7 then 7-0) for the pulsing menu-item highlight.
MENU_COLOR_BLINK:
	DB $00,$01,$02,$03,$04,$05,$06,$07
	DB $07,$06,$05,$04,$03,$02,$01,$00
    
COLOR_BLINKER:
    DB $00,$00
