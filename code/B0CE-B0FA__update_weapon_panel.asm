; --- update_weapon_panel -------------------------------------
; @done
; If the active weapon changed, load its name into the scrolling
; weapon panel (WEAPONS text, 11 chars per entry). In: a = weapon id
update_weapon_panel:
	ld hl, CURRENT_WEAPON

	cp (hl)
	ret z

	ld (CURRENT_WEAPON), a

	; muliplication
	ld h, $00
	ld l, a
	ld d, h
	ld e, l
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, de	; x5
	add hl, hl	; x10
	add hl, de	; x11
	; HL = A*11		11 is a weapon text length

	ld de, WEAPONS
	add hl, de		; HL=weapon text addr

	xor a
	ld (WEAPON_PANEL_FLAG), a
	ld a, $0C

start_text_scroll:
	ld (WEAPON_TEXT), hl
	ld (WEAPON_TEXT_LEN), a
	ld a, (LETTER_SCROLLER)
	and a
	ret nz

	ld a, $01
	ld (LETTER_SCROLLER), a
	
	ret
