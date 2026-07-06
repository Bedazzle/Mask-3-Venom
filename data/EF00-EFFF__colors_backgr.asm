; --- COLORS_BACKGR (background colour palette) ---------------
; A 256-entry PIXEL-BYTE -> ZX-ATTRIBUTE table - the background twin of COLORS_PLAYER
; ($EE00). draw_sprite defaults to this table (ld d,high COLORS_BACKGR ; $EF) and only
; switches to COLORS_PLAYER when a cell's colour-plane bit is set; it looks up
; a = COLORS_BACKGR[pixel_byte] for each background cell. playfield_to_screen /
; draw_boxes use it too. Per-theme: it is the table swap_spritesheet swaps in/out with
; the live sprite bank (SPRITE_E000).
; MUST stay page-aligned ($EF00) - indexing sets only the high byte $EF.
; Attribute byte = FLASH(b7).BRIGHT(b6).PAPER(b5-3).INK(b2-0); colours 0=blk 1=blu 2=red
; 3=mag 4=grn 5=cyn 6=yel 7=wht (e.g. $47=bright wht/blk, $C4=flash+bright grn/blk).
; 16 entries per row; the ; $NN comment = the pixel-byte index of the first entry in the row.
COLORS_BACKGR:
	DB $47,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4,$C4	; $00
	DB $45,$45,$45,$45,$47,$47,$46,$45,$45,$41,$C3,$C3,$C3,$C3,$47,$47	; $10
	DB $45,$C6,$C6,$C6,$C6,$C6,$C6,$C6,$C6,$44,$44,$44,$47,$47,$47,$C5	; $20
	DB $C5,$C5,$C5,$C3,$C3,$42,$42,$42,$42,$42,$42,$45,$45,$45,$45,$C4	; $30
	DB $C4,$C4,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46	; $40
	DB $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$41,$45,$45,$45,$47,$47	; $50
	DB $45,$45,$45,$45,$43,$47,$47,$43,$43,$C5,$45,$C5,$45,$47,$47,$47	; $60
	DB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47	; $70
	DB $C4,$C4,$43,$43,$43,$43,$43,$43,$43,$43,$C4,$C4,$45,$45,$45,$45	; $80
	DB $45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$47,$47,$47,$47	; $90
	DB $43,$43,$43,$43,$43,$43,$43,$45,$43,$43,$43,$43,$45,$45,$45,$45	; $A0
	DB $45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$47,$47,$47,$47	; $B0
	DB $45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45	; $C0
	DB $45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45	; $D0
	DB $45,$47,$41,$41,$41,$41,$41,$41,$41,$41,$C1,$46,$46,$46,$46,$42	; $E0
	DB $42,$42,$42,$42,$42,$46,$47,$47,$46,$47,$47,$46,$46,$45,$44,$45	; $F0
