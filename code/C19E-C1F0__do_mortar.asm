; --- do_mortar -------------------------------------------------
; @done
; Spawn the mortar (state $0E): clear the arena, find the ground
; column via is_solid, place it there; re-arms via arm_alien.
; In: ix = alien slot
do_mortar:
	ld a, (ix+ALIEN.spawn)
	and a
	jp nz, arm_alien

	push ix

	call kill_all_aliens

	ld ix, ALIEN.1
	ld (ix+ALIEN.state), $80
	ld (ix+ALIEN.width), $02
	ld (ix+ALIEN.height), $02
	ld (ix+ALIEN.x), $01

	ld ix, ALIEN.2
	ld (ix+ALIEN.x), $A4
	ld hl, MAP_MORTAR
	ld c,$00
	ld de, $20

.find_ground:
	call is_solid

	jr c, .place

	add hl, de
	inc c
	jr .find_ground

.place:
	ld a, c
	add a, a
	add a, a
	add a, a
	sub $20
	ld (ix+ALIEN.y), a
	ld (ix+ALIEN.state), $0E
	ld (ix+ALIEN.spawn), $FF

	ld hl, TEMPLATE_MORTAR

	call copy_alien_template

	pop ix

	ret
