; --- COLORS_PLAYER (foreground colour palette) ---------------
; A 256-entry PIXEL-BYTE -> ZX-ATTRIBUTE table, NOT a per-frame player table.
; When draw_sprite renders a foreground cell it does  ld e,(hl) ; e = the cell's
; pixel byte, then  a = COLORS_PLAYER[e]  = that pattern's attribute (falling back to
; ALIEN.color if the entry is 0). A colour-plane bit in the sprite data picks this table
; vs COLORS_BACKGR ($EF00, the same-shaped background twin). Used for the PLAYER *and*
; all alien actors (draw_all_actors -> draw_sprite), and by playfield_to_screen / draw_boxes.
; Per-theme: swap_spritesheet swaps it, startup seeds BANK1_COLORS from it.
; MUST stay page-aligned ($EE00) - indexing sets only the high byte $EE.
; Attribute byte = FLASH(b7).BRIGHT(b6).PAPER(b5-3).INK(b2-0); colours 0=blk 1=blu 2=red
; 3=mag 4=grn 5=cyn 6=yel 7=wht (e.g. $47=bright wht/blk, $C3=flash+bright mag/blk).
; 16 entries per row; the ; $NN comment = the pixel-byte index of the first entry in the row.
COLORS_PLAYER:
	DB $47,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3	; $00
	DB $C3,$C3,$C3,$C3,$47,$47,$C4,$C4,$C3,$C3,$C3,$C3,$45,$43,$C5,$C3	; $10
	DB $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$45,$45,$47,$45,$45,$46,$45,$C7	; $20
	DB $C3,$C3,$C3,$C7,$47,$C5,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3	; $30
	DB $47,$C3,$C3,$C7,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$43,$43,$43,$C7	; $40
	DB $C3,$47,$47,$C7,$C7,$C6,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3	; $50
	DB $45,$45,$45,$45,$45,$45,$C3,$C3,$C3,$C3,$C3,$C3,$43,$43,$43,$C5	; $60
	DB $C6,$47,$47,$C6,$C5,$C6,$C4,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3	; $70
	DB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47	; $80
	DB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47	; $90
	DB $46,$46,$46,$46,$46,$46,$46,$46,$46,$47,$47,$46,$45,$45,$45,$45	; $A0
	DB $45,$45,$45,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$43	; $B0
	DB $47,$47,$C3,$43,$C3,$C5,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47	; $C0
	DB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$45,$45	; $D0
	DB $47,$47,$42,$42,$42,$42,$42,$42,$42,$42,$C2,$43,$43,$43,$43,$43	; $E0
	DB $43,$46,$46,$46,$46,$46,$46,$46,$46,$46,$C5,$C2,$43,$43,$43,$43	; $F0
