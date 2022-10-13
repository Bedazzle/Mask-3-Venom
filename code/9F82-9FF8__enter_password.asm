enter_password:
	call L9E10

	ld hl, WORD_ENTER_PASS + 2
	ld de, $0809
	call print_string

	ld hl, WORD_DOTS
	ld de, $0A08
	call print_string

	call find_bmp_addr

	ex de, hl
	ld hl, PASS_BUFFER
	ld c, $00

loop_pass:
	call LA0E5

	cp $40
	jr z, loop_pass

	cp $0D
	jr z, pass_enter

	call print_char

	ex af, af'
	ld (hl), a
	inc hl
	inc c
	bit 4, c
	jr z, loop_pass

pass_enter:
	ld (hl), $00
	jr match_pass_1		; optimize by remove

match_pass_1:
	ld hl, PASS_1
	call match_buffer
	jr nz, match_pass_2

	ld a, $FF
	ld (TELEPORT_1), a

match_pass_2:
	ld hl, PASS_2
	call match_buffer
	jr nz, match_pass_3

	ld a, $FF
	ld (TELEPORT_2), a
match_pass_3:
	ld hl, PASS_3
	call match_buffer
	jr nz, match_pass_4

	ld a, $FF
	ld (TELEPORT_3), a

match_pass_4:
	ld hl, PASS_4
	call match_buffer
	jr nz, match_end

	ld hl, TELEPORT_1
	ld a, (hl)
	inc hl
	and (hl)
	inc hl
	and (hl)
	inc hl
	ld (hl), a

match_end:
	call L9E10

	jp main_menu_loop
