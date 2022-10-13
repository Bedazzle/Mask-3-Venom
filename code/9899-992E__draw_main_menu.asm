draw_main_menu:
	call draw_multi_logo
	call copy_F2F0_buff

	ld a, $07
	ld hl, LF0C0
	ld de, $580B
loop_draw_main:
	ex af, af'
	ld bc, $000A
	ldir
	ld bc, $0046
	add hl, bc
	ex de, hl
	ld bc, $0016
	add hl, bc
	ex de, hl
	ex af, af'
	dec a
	jr nz, loop_draw_main

	ld bc, $01CC
	ld a, (LFFFE)
	and a
	jr z, loop_blink_pause

	ld bc, $01AF
loop_blink_pause:
	dec bc
	ld a, b
	or c
	jr nz, loop_blink_pause

	; -----
	ld a, (COLOR_BLINKER)
	inc a
	ld (COLOR_BLINKER), a

	ld hl, MENU_COLOR_BLINK
	and $0F
	ld e, a
	ld d, $00
	add hl, de
	ld c, (hl)		; C=color

	ld a, (KEMPSTON_YES)
	ld l, a
	add a, a	; x2
	add a, l	; x3
	ld l, a
	ld h, $00
	ld de, MAINMENU_ICONS
	add hl, de

	ld d, (hl)		; D=y
	inc hl
	ld e, (hl)		; E=x
	ld a, c			; A=color

	call col_row_to_attr	; put top left

	inc e

	call col_row_to_attr	; put top right

	inc d

	call col_row_to_attr	; put bottom right

	dec e

	call col_row_to_attr	; put bottom left
	; -----


	; draw Gremlin flag on border
	ld a, COLOR.GREEN		; upper strip
	out ($FE), a
	
	ld bc, $0057
wait_upper:
	dec bc
	ld a, b
	or c
	jr nz, wait_upper

	xor a			; middle CL_BLK
	out ($FE), a

	ld bc, $0007
wait_middle:
	dec bc
	ld a, b
	or c
	jr nz, wait_middle

	nop
	nop
	nop
	nop
	nop
	nop

	ld a, COLOR.GREEN	; lower strip
	out ($FE), a

	ld bc, $002A
wait_lower:
	dec bc
	ld a, b
	or c
	jr nz, wait_lower

	nop
	nop
	nop

	xor a			; black bottom
	out ($FE), a

	jp prepare_multicolor
