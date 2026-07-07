; --- weapon-panel state: slot blink, current weapon, scroller text/state, box saves, 4 weapon slots (SLOT.1..4), ammo/colour tables, ACTIVE_SLOT
SLOT.BLINK:
	DB $00,$00
	
CURRENT_WEAPON:
	DB $00
	
WEAPON_TEXT_LEN:
	DB $00

WEAPON_TEXT:
	DB $00,$00
LETTER_SCROLLER:
	DB $00,$00
SCROLLER_STATE:
	DB $00

BUFFER_AF15:
	DB $00,$00,$00,$00,$00,$00
	
BOX.1:
	DB $00,$00,$00,$00,$00,$00,$00,$00

BOX.2:
	DB $00,$00,$00,$00,$00,$00,$00,$00

SLOT.1:		; AF2B
	DB $61,$00,$00,$00
SLOT.2:		; AF2F
	DB $64,$00,$00,$00
SLOT.3:		; AF33
	DB $67,$00,$00,$00
SLOT.4:		; AF37
	DB $6A,$00,$00,$00

X_BUFFER:
	DB $00	; 0  empty
	DB $00	; 1  penetrator
	DB $00	; 2  ultra flash
	DB $00	; 3  mirage
	DB $00	; 4  healer
	DB $01	; 5  jackrabbit
	DB $01	; 6  lifter
	DB $03	; 7  blaster
	DB $02	; 8  backlash
	DB $06	; 9  lava shot
	DB $01	; 10 streamer

BOX.COLORS:
	DB COLOR.BLACK	; 0  empty
	DB COLOR.GREEN	; 1  penetrator
	DB COLOR.RED      ; 2  ultra flash
	DB COLOR.MAGENTA  ; 3  mirage
	DB COLOR.GREEN    ; 4  healer
	DB COLOR.SKYBLUE  ; 5  jackrabbit
	DB COLOR.YELLOW   ; 6  lifter
	DB COLOR.WHITE    ; 7  blaster
	DB COLOR.WHITE    ; 8  backlash
	DB COLOR.RED      ; 9  lava shot
	DB COLOR.MAGENTA  ; 10 streamer
	
ACTIVE_SLOT: 
	DB $00,$00
