; --- do_volcano ------------------------------------------------
; @done
; Spawn a volcano projectile (state $0C) from a VOLCANO_1/VOLCANO_2
; vent, with random launch velocity and facing.
; In: ix = alien slot
do_volcano:
	ld de, (VOLCANO_1)
	ld hl, (VOLCANO_2)
	ld a, d
	or e
	ret z

	ld a, h
	or l
	jr z, .spawn

	call generate_random

	rrca
	jr c, .spawn

	ex de, hl

.spawn:
	ld (ix+ALIEN.state), $0C

	ld hl, TEMPLATE_VOLCANO

	call copy_alien_template

	ld a, e
	add a, $0A
	ld (ix+ALIEN.y), a

	call generate_random

	and $07
	add a, d
	ld (ix+ALIEN.x), a
	sub d
	sub $04
	ld (ix+ALIEN.xvel), a

	call generate_random

	and $07
	add a, $05
	neg
	ld (ix+ALIEN.yvel), a

	call generate_random

	rrca
	ld (ix+ALIEN.facing), a
	ld a, $01
	jr c, .set_facing

	ld a, $FF

.set_facing:
	ld (ix+ALIEN.param1), a

	ret
