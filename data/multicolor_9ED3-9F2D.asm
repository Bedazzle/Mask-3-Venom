CURRENT_MULTIADDR:
	defw CURRENT_COLOR
CURRENT_COLOR:
	defb $FF

MULTICOLORS:
	defw L9EE6
	defw L9EEF
	defw L9EF8
	defw L9F01
	defw L9F0A
	defw L9F13
	defw L9F1C
	defw L9F25

L9EE6:
	defb $01,$03,$04,$06,$07,$02,$03,$01,$FF
L9EEF:
	defb $05,$04,$03,$01,$02,$03,$05,$06,$FF
L9EF8:
	defb $01,$02,$03,$07,$06,$04,$05,$06,$FF
L9F01:
	defb $07,$06,$05,$04,$01,$02,$03,$01,$FF
L9F0A:
	defb $04,$06,$03,$01,$01,$03,$06,$04,$FF
L9F13:
	defb $04,$05,$01,$03,$02,$07,$05,$01,$FF
L9F1C:
	defb $03,$02,$01,$04,$05,$03,$01,$02,$FF
L9F25:
	defb $02,$07,$05,$04,$01,$03,$02,$01,$FF
