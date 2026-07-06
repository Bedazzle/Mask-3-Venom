; --- teleport_to_level ----------------------------------------
; @done
; Teleporter update: once its countdown (ix+ALIEN.timer) expires, warp
; the player to the destination level. The teleporter index (0-3)
; is derived from its x-position (ix+ALIEN.x) and looked up in
; TELEPORT_LEVELS. Resets ROOM_NUMBER, repositions the sprite,
; and for the 4th teleporter also awards a bonus weapon.
; In:  ix = teleporter object
; Note: falls through into draw_room (redraw room)
teleport_to_level:
	ld a, (ix+ALIEN.timer)
	and $0F
	jr nz, .tick

	ld hl, DISSOLVE
	inc (hl)
.tick:
	dec (ix+ALIEN.timer)
	ret nz

	ld a, (ix+ALIEN.x)
	sub $40
	rlca
	rlca
	rlca
	and $03
	ld e, a
	ld d, $00
	ld hl, TELEPORT_LEVELS
	add hl, de
	ld a, (hl)
	ld (LEVEL_NUMBER), a
	xor a
	ld (ROOM_NUMBER), a		; teleported
	ld (ix+ALIEN.x), $42
	ld a, (ix+ALIEN.y)
	add a, $08
	ld (ix+ALIEN.y), a
	ld (ix+ALIEN.state), $08
	xor a
	ld (DISSOLVE), a
	ld a, e

	cp $03
	call z, give_bonus_weapon

	jp draw_room


TELEPORT_LEVELS:
	DB $0B,$03,$07,$07
