LC64E:
	ld a, (ix+$21)
	and a
	jr z, LC6AC

	ld hl, (LC0D7)
	dec hl
	ld (LC0D7), hl
	bit $07, h
	jr nz, LC6AF

	ex de, hl
	ld a, (ROOM_NUMBER)
	ld l, a
	ld h, $00
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8
	add hl, hl	; x16
	ex de, hl
	sbc hl, de
	ld de, $40
	add hl, de
	ld a, h
	and a
	jr z, LC67E

	ld a, $FF
	ld (L946D), a
	ld l, $00
	jr LC683


LC67E:
	ld a, $0F

	call L93DC

LC683:
	ld (ix+$03), l
	ld a, (LB3EA)
	and a
	jr z, LC691

	ld a, $10
	ld (LBE0D), a

LC691:
	ld a, (PLAYER_Y_COORD)

	cp (ix+$04)
	jr z, LC6A2

	ld a, (ix+$04)
	jr nc, LC6A1

	dec a
	jr LC6A2


LC6A1:
	inc a

LC6A2:
	ld (ix+$04), a

	call LC2D9
	ret nz

	call decrease_energy

LC6AC:
	call LC2C1

LC6AF:
	ld a, $FF
	ld (L946D), a

	jp LC8FD
