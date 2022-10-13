do_cannon:
	ld a, (LC0D6)
	and a
	ret nz

	ld a, $12
	call LABFD
	ret z

	ld ix, ALIEN.1
loop_cannon:
	ld (ix+$03),B
	ld a, c
	sub $02
	ld a, c
	ld (ix+$04), a
	ld (ix+$00), $04
	ld (ix+$1C), $00
	exx
	ld (ix+$11), l
	ld (ix+$12), h
	exx
	
	ld hl, TEMPLATE_CANNON

	call copy_alien_template

	ld (ix+$26), $40

	call LAC2F
	ret z

	ld ix, ALIEN.3

	jr loop_cannon
