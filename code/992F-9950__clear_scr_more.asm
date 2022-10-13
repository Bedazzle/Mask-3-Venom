clear_scr_more:		; clear screen for gremlin logo
	ld hl, SCREEN
	ld de, SCREEN+1
	ld bc, LEN_SCR	;$1800
	ld (hl), $00
	ldir

	ld hl, ATTRIB
	ld de, ATTRIB+1
	ld bc, $02C0  ; 704
	ld (hl), $00
	ldir

	ld (hl), PAPER.GREEN + COLOR.BLACK
	ld bc, $003F  ; 63
	ldir

	ret
