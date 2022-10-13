hit_alien:
	;display "here: hit_alien", $
	ld ix, ALIEN.1

	;ret
	;nop
	;nop
	;nop


	ld b, $06

loop_next_hit:
	push bc
	push ix

	call choose_alien_routine

	ld (ix+$22), $00

	call LBC96

	jr nz, LC284_2

	dec (ix+$21)

LC284_1:
	ld iy, LA465
	dec (iy+$21)
	jr nz, LC284_3

	ld (iy+$00), $00
	jr LC284_3

LC284_2:
	ld a, (ix+$22)
	and a
	jr nz, LC284_1

LC284_3:
	call alien_vectors

	pop ix
	pop bc
	ld de, $0026
	add ix, de
	djnz loop_next_hit

	jp LBF7F
