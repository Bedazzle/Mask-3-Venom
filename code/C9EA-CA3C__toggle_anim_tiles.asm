; --- toggle_anim_tiles: cycle the animated-tile bytes (water/lava) via the ANIM_TILE_SEQ sequence (@done)
toggle_anim_tiles:
	ld hl, SPRITE_E710
	ld a, (SPRITESET)
	cp $03
	jr nz, .have_bank
	ld hl, SPRITE_E728
.have_bank:
	ld de, ANIM_TILE_SEQ
	ld b, $00
	ld a, $08
.step:
	ld (.count+1), a		; set SMC
	push hl
	ld a, (de)
	bit 7, a
	jr nz, .step_off
	and $07
	dec a
	ld c, a
	add hl, bc
	ld (hl), $FF
	and a
	jr z, .on
	ld (de), a
	jr .next
.on:
	ld a, $80
	ld (de), a
	jr .next
.step_off:
	and $07
	ld c, a
	add hl, bc
	ld (hl), $00
	inc a
	cp $07
	jr z, .off
	or $80
	ld (de), a
	jr .next
.off:
	ld (de), a
.next:
	pop hl
	ld c, $08
	add hl, bc
	inc de
.count:
	ld a, $00		; !!! SMC
	dec a
	jr nz, .step
	ret


ANIM_TILE_SEQ:
	DB $80,$81,$82,$83,$84,$85,$86,$07
