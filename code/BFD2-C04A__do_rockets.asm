; --- do_rockets ------------------------------------------------
; @done
; Spawn rockets. Also holds copy_alien_template (stamp a template
; into an actor record) and generate_color (random alien colour).
; In: ix = alien slot
do_rockets:
	ld a, (PLAYER_X_COORD)
	cp $91
	ret nc

	ld (ix+ALIEN.state), $02
	ld (ix+ALIEN.x), $C8

	call generate_random

	and $3F			; 63
	;ld a,1

	ld (ix+ALIEN.y), a

	call generate_random

	and $1F			; 31
	sub $0C			; 12
	ld (ix+ALIEN.param1), a
	
	ld hl, TEMPLATE_ROCKET

copy_alien_template:
	ld a, (hl)
	ld (ix+ALIEN.score_lo), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.score_hi), a

	inc hl
	ld a, (hl)
; copy_from_base_lo / _base_hi / _damage are alternate ENTRY POINTS into this
; routine: calling one copies the template tail starting from that field into
; ix's record (hl = source, ix = dest). The interrupt's 48K path calls them to
; re-stamp a subset of an actor/channel record; base_hi_op's operand byte is
; also read from outside (see the interrupt).
copy_from_base_lo:
	ld (ix+ALIEN.base_lo), a

copy_from_base_hi:
	inc hl
	ld a, (hl)

base_hi_op:
	ld (ix+ALIEN.base_hi), a		; checked from outside !

	inc hl
	ld a, (hl)

copy_from_damage:
	ld (ix+ALIEN.damage), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.anim), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.anim_mask), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.width), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.height), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.mode), a

	inc hl
	ld a, (hl)
	ld (ix+ALIEN.hp), a

	inc hl
	ld a, (hl)
	and a
	jp p, set_alien_color

generate_color:
	call generate_random

	and $07
	jr z, generate_color

set_alien_color:
	or $40					; bright, black paper
	ld (ix+ALIEN.color), a

	xor a
	ld (ix+ALIEN.noclip), a
	ld (ix+ALIEN.facing), a
	ld (ix+ALIEN.xvel), a
	ld (ix+ALIEN.yvel), a

	ret
