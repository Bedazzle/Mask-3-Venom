LC78A:
	ld a, (ix+$22)
	and a
	jr z, LC78A_0

	inc (ix+$11)
	ld a, (ix+$11)

	cp $0A
	jp z, LC6B8

LC78A_0:
	ld a, (ix+$21)
	and a
	jr z, LC78A_1

	call move_bomb

	call LC2D9
	ret nz

	call decrease_energy

LC78A_1:
	call LC2C1

	ld a, (ix+$03)
	sub $04
	ld (ix+$03), a
	ld a, (ix+$04)
	add a, $04
	ld (ix+$04), a

	ld hl, LBF13		; bomb disappearing 1
	call LC26F

	ld (ix+$10), $08
	ld a, (ix+$23)

	cp $06
	ret z

	ld a, (ix+$26)
	and $3F
	ret nz

	ld a, (ix+$03)
	add a, $0C
	ld (ix+$29), a
	ld a, (ix+$04)
	add a, $04
	ld (ix+$2A), a
	ld de, $0026
	add ix, de

	ld hl, LBF1F		; bomb disappearing 2
	call LC26F

	ld (ix+$10), $0C

	ret
