TEMPLATE_SPHERE:
	defb $33,$00,$60,$D2,$0A,$00,$03,$02,$02,$04,$01,$FF
	
TEMPLATE_ROCKET:
	defb $00,$02,$E0,$D2,$32,$00,$03,$03,$02,$02,$01,$FF

TEMPLATE_CANNON:
	defb $00,$05,$A0,$D7,$64,$03,$03,$03,$02,$02,$05,$05

TEMPLATE_ROUND:
	;    14  15  16  17  1E  18  1A  05  06  19  21
	defb $10,$00,$60,$D8,$0A,$00,$07,$01,$01,$05,$01,$FF

TEMPLATE_JUMPER:
	defb $50,$01,$A0,$D8,$32,$00,$07,$02,$02,$04,$01,$FF

TEMPLATE_MUSHROOM:
	defb $00,$01,$60,$D9,$03,$00,$07,$02,$02,$04,$0A,$04

TEMPLATE_HARRIER:
	defb $00,$50,$E0,$D9,$FF,$00,$00,$08,$03,$06,$1E,$02

LBE8F:
	defb $00,$05,$A0,$DA,$32,$00,$03,$02,$03,$02,$01,$FF

TEMPLATE_VOLCANO:	
	defb $00,$01,$60,$D2,$14,$00,$03,$02,$02,$04,$01,$FF

TEMPLATE_BOMB:
	;    14  15  16  17  1E  18  1A  05  06  19  21
	defb $00,$10,$C0,$DB,$64,$00,$00,$04,$04,$06,$0A,$04

TEMPLATE_MORTAR:
	defb $00,$10,$E0,$DE,$FF,$00,$00,$04,$04,$06,$0A,$05

LBEBF:
	defb $50,$00,$60,$DF,$1E,$00,$00,$02,$02,$06,$02,$05

TEMPLATE_BOMBER:
	defb $00,$80,$60,$DB,$FF,$00,$00,$04,$03,$06,$05,$07

TEMPLATE_SNAKE1:
	defb $00,$10,$80,$DE,$3C,$00,$00,$02,$02,$06,$FF,$07
TEMPLATE_SNAKE2:
	defb $00,$02,$A0,$DE,$28,$00,$00,$02,$02,$06,$FF,$07
TEMPLATE_SNAKE3:
	defb $00,$05,$C0,$DE,$3C,$00,$00,$02,$02,$06,$FF,$07

LBEFB:	
	defb $00,$00,$40,$D4,$00,$00,$03,$02,$02,$04,$00,$FF

LBF07:
	defb $00,$00,$C0,$D4,$00,$00,$03,$03,$02,$02,$00,$FF

; bomber bomb disappearing
LBF13:	
	defb $00,$00,$40,$DC,$00,$00,$03,$03,$03,$07,$00,$FF
; bomber bomb disappearing
LBF1F:
	defb $00,$00,$60,$DD,$00,$00,$03,$03,$03,$07,$00,$FF
