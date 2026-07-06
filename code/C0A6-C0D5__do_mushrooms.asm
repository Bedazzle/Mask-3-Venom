; --- do_mushrooms ----------------------------------------------
; @done
; Spawn a mushroom once (state 7, TEMPLATE_MUSHROOM), guarded by
; the slot's spawn flag.
; In: ix = alien slot
do_mushrooms:
	ld a, (ix+ALIEN.spawn)
	and a
	ret nz

	ld (ix+ALIEN.spawn), $FF
	ld (ix+ALIEN.state), $07

	ld hl, TEMPLATE_MUSHROOM

	call copy_alien_template

	ld (ix+ALIEN.x), $C6
	ld a, (GROUND_ROW)
	sub $0F
	ld (ix+ALIEN.y), a
	ld (ix+ALIEN.xvel), $FE
	ld (ix+ALIEN.yvel), $14
	ld (ix+ALIEN.param1), $00
	ld (ix+ALIEN.param2), $01

	ret
