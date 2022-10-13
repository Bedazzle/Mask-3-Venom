do_rockets:
	ld a, (PLAYER_X_COORD)
	cp $91
	ret nc

	ld (ix+$00), $02
	ld (ix+$03), $C8

	call generate_random

	and $3F			; 63
	;ld a,1

	ld (ix+$04), a

	call generate_random

	and $1F			; 31
	sub $0C			; 12
	ld (ix+$11), a
	
	ld hl, TEMPLATE_ROCKET

copy_alien_template:
	ld a, (hl)
	ld (ix+$14), a

	inc hl
	ld a, (hl)
	ld (ix+$15), a

	inc hl
	ld a, (hl)
LBFD2_1:
	ld (ix+$16), a

LBFD2_2:
	inc hl
	ld a, (hl)

LC005:
	ld (ix+$17), a		; checked from outside !

	inc hl
	ld a, (hl)

LBFD2_3:
	ld (ix+$1E), a

	inc hl
	ld a, (hl)
	ld (ix+$18), a

	inc hl
	ld a, (hl)
	ld (ix+$1A), a

	inc hl
	ld a, (hl)
	ld (ix+$05), a

	inc hl
	ld a, (hl)
	ld (ix+$06), a

	inc hl
	ld a, (hl)
	ld (ix+$19), a

	inc hl
	ld a, (hl)
	ld (ix+$21), a

	inc hl
	ld a, (hl)
	and a
	jp p, LBFD2_5

generate_color:
	call generate_random

	and $07
	jr z, generate_color

LBFD2_5:
	or $40					; bright, black paper
	ld (ix + ALIEN.COLOR), a

	xor a
	ld (ix+$1D), a
	ld (ix+$02), a
	ld (ix+$1B), a
	ld (ix+$1C), a

	ret
