LB33D:
	ld a, (LB3EA)
	and a
	ret nz

	ld ix, LACDA
	ld b, $04
	ld de, $0004
	ld a, (PLAYER_X_COORD)
	ld l, a
	ld a, (PLAYER_Y_COORD)
	ld h, a
LB33D_0:
	ld a, l
	add a, $0A
	sub (ix+$00)
	jr c, LB33D_1

	cp $0E
	jr nc, LB33D_1

	ld a, h
	add a, $14
	sub (ix+$01)
	jr c, LB33D_1
	jr LB33D_2

LB33D_1:
	add ix, de
	djnz LB33D_0

	ret

LB33D_2:
	ld a, (ix+$01)
	add a, $08
	and $F8
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+$00)
	sub $40
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, LF0C0
	add hl, de
	xor a
	ld (hl), a
	inc l
	ld (hl), a
	ld de, $001F
	add hl, de
	ld (hl), a
	inc l
	ld (hl), a
	ld l, (ix+$02)
	ld h, (ix+$03)
	ld (hl), ROTATOR_KILL	;$47
	ld iy, ALIEN.1
	ld de, $0026
	ld b, $06
LB33D_3:
	ld a, (iy+$00)
	and $7F
	jr z, LB33D_4

	add iy, de
	djnz LB33D_3

	jr LB33D_5

LB33D_4:
	ld a, (ix+$00)
	ld (ix+$00), $00
	ld (iy+$03), a
	ld a, (ix+$01)
	add a, $08
	ld (iy+$04), a
	push iy
	pop ix

	ld hl, LBF07	; rotator disappearing by collision
	call LC26F

	ld (ix+$1B), $00
	ld (ix+$1C), $FE
LB33D_5:
	ld a, (ENERGY)
	IFNDEF SAFEROTATOR
		sub $19
	ELSE
		nop
		nop
	ENDIF
	ld (ENERGY), a
	ret nc
	
	xor a
	ld (ENERGY), a

	ret
