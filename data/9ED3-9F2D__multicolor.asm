; multicolour rendering setup: CURRENT_MULTIADDR / CURRENT_COLOR = working vars;
; MULTICOLORS = the multicolour attribute pattern applied by prepare_multicolor.
CURRENT_MULTIADDR:
	DW CURRENT_COLOR
CURRENT_COLOR:
	DB $FF

; MULTICOLORS = table of 8 pointers to the 8 multicolour ink patterns below
; (MULTICOLOR_0..7). Each is 8 ink colours (1-7) + $FF terminator; prepare_multicolor
; cycles through them to paint the animated multicolour logo.
MULTICOLORS:
	DW MULTICOLOR_0
	DW MULTICOLOR_1
	DW MULTICOLOR_2
	DW MULTICOLOR_3
	DW MULTICOLOR_4
	DW MULTICOLOR_5
	DW MULTICOLOR_6
	DW MULTICOLOR_7

MULTICOLOR_0:
	DB $01,$03,$04,$06,$07,$02,$03,$01,$FF
MULTICOLOR_1:
	DB $05,$04,$03,$01,$02,$03,$05,$06,$FF
MULTICOLOR_2:
	DB $01,$02,$03,$07,$06,$04,$05,$06,$FF
MULTICOLOR_3:
	DB $07,$06,$05,$04,$01,$02,$03,$01,$FF
MULTICOLOR_4:
	DB $04,$06,$03,$01,$01,$03,$06,$04,$FF
MULTICOLOR_5:
	DB $04,$05,$01,$03,$02,$07,$05,$01,$FF
MULTICOLOR_6:
	DB $03,$02,$01,$04,$05,$03,$01,$02,$FF
MULTICOLOR_7:
	DB $02,$07,$05,$04,$01,$03,$02,$01,$FF
