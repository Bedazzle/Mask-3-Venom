LBB78:
	ld a, $10
	call L93DC

	ld a, $11
	call L93DC

	call playfield_to_screen
	call playfield_to_screen

	ld hl, $5800
	ld b, $03
	ld c, $3F

LBB78_0:
	ld a, (hl)
	and c
	jr nz, LBB78_1

	ld (hl), $47
LBB78_1:
	inc l
	jr nz, LBB78_0

	inc h
	djnz LBB78_0

	ld a, (PLAYER_X_COORD)
	sub $40
	add a, a
	add a, $10
	ld l, a
	ld a, (PLAYER_Y_COORD)
	add a, $10
	ld h, a
	ld ix, LE800
	ld de, $0005
	ld b, $C8

LBB78_2:
	ld (ix+$00), $FF

	call generate_random

	and $1F
	sub $10
	add a, l
	ld (ix+$01), a
	ld e, a

	call generate_random

	ld c, a
	and $07
	inc a
	bit 7, c
	jr z, LBB78_3

	neg
LBB78_3:
	ld (ix+$03), a

	call generate_random

	and $1F
	sub $10
	add a, H
	ld (ix+$02), a
	ld d, a

	call generate_random

	ld c, a
	and $07
	inc a
	bit 7, c
	jr z, LBB78_4

	neg
LBB78_4:
	ld (ix+$04), a

	call LBC58

	ld de, $0005
	add ix, de
	djnz LBB78_2

	ld b, $96
LBB78_5:
	push bc
	halt
	ld b, $C8
	ld ix, LE800
LBB78_6:
	ld a, (ix+$00)
	and a
	jr z, LBB78_9

	ld e, (ix+$01)
	ld d, (ix+$02)

	call LBC58

	ld a, d
	add a, (ix+$04)
	ld d, a
	ld a, e
	add a, (ix+$03)
	ld e, a
	ld a, d
	xor (ix+$02)
	jp p, LBB78_7

	ld a, d
	add a, $10

	cp $21
	jr nc, LBB78_7

	ld (ix+$00), $00
	jr LBB78_9

LBB78_7:
	ld a, e
	xor (ix+$01)
	jp p, LBB78_8

	ld a, e
	add a, $10

	cp $21
	jr nc, LBB78_8

	ld (ix+$00), $00
	jr LBB78_9

LBB78_8:
	ld (ix+$02), d
	ld (ix+$01), e

	call LBC58

LBB78_9:
	ld de, $0005
	add ix, de
	djnz LBB78_6

	pop bc
	djnz LBB78_5

	ret

; Routine at BC58
LBC58:
	ld a, d

	cp $90
	ret nc

	push hl
	ld hl, PARTICLE_TRACES
	ld a, e
	and $07
	add a, l
	ld l, a
	jr nc, LBC58_0

	inc h
LBC58_0:
	ld a, (hl)
	ld (LBC88+1), a		; set SMC
	ld a, e
	rrca
	rrca
	rrca
	and $1F
	ld l, a
	ld a, d
	rlca
	rlca
	and $E0
	or l
	ld l, a
	ld a, d
	and $07
	ld h, a
	ld a, d
	rrca
	rrca
	rrca
	and $18
	or h
	or $40
	ld h, a

LBC88:
	ld a, $00		; !!! SMC

	xor (hl)
	ld (hl), a
	pop hl

	ret


PARTICLE_TRACES:
	defb $80,$40,$20,$10,$08,$04,$02,$01
