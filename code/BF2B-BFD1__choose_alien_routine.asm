choose_alien_routine:
	ld a, (ix+$00)
	and $7F
	ret nz

	ld a, (LBFB0)

	cp $05
	jr z, LBF2B_0
    
	cp $06
	jr z, LBF2B_0
    
	cp $08
	jr z, LBF2B_0
    
	cp $09
	jr z, LBF2B_0
    
	cp $0A
	jr z, LBF2B_0
    
	call generate_random

	and $2E
	jr nz, LBF2B_1

LBF2B_0:
	ld a, (LC0D6)
	and a
	jp nz, LBF2B_1
    
	ld a, (LBFB0)
	;mult
	ld l, a
	add a, a	; x2
	add a, l	; x3	jp NNNN = 3 bytes
	ld l, a
	ld h, $00
	ld de, alien_routines
	add hl, de
	; mult HL = A*3 + alien_routines
	jp (hl)

; This entry point is used by the routine at LC167.
LBF2B_1:
	ld a, (ALIEN.1)

	cp $08
	ret z
	
	ld (ix+$03), $01
	ld (ix+$04), $00
	ld (ix+$05), $02
	ld (ix+$06), $02
	ld (ix+$00), $80

	ret

; Routine at BF7F
LBF7F:
	ld ix, ALIEN.1
	ld b, $06
	ld de, $0026
	ld a, $00
loop_check_aliens:
	or (ix+$00)
	add ix, de
	djnz loop_check_aliens

	and a
	ret nz

	ld ix, ALIEN.1
	ld (ix+$00), $80
	ld (ix+$05), $04
	ld (ix+$06), $05
	ld (ix+$04), $00
	ld (ix+$03), $01
	ld (ix+$19), $06

	ret


LBFB0:
	defb $00


alien_routines:
	ret
	defb $00,$00

	jp do_rockets
	jp do_spheres
	jp do_jumpers
	jp do_mushrooms
	jp do_harrier
	jp do_bomber
	jp do_volcano
	jp do_bomb
	jp do_mortar
	jp do_snake
