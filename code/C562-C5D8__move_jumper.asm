; --- move_jumper (alien state, vector 6) ---------------------
; @done
; Jumper: follow the fixed vertical jump arc in JUMPER_ARC
; (param1 indexes it) while creeping left.
; In: ix = alien
move_jumper:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	inc (ix+ALIEN.param1)
	ld e, (ix+ALIEN.param1)
	ld a, e

	cp $11
	jr nz, .arc_step

	ld (ix+ALIEN.param1), $FF
.arc_step:
	ld d, $00
	ld hl, JUMPER_ARC
	add hl, de
	ld a, (GROUND_ROW)
	sub (hl)
	ld (ix+ALIEN.y), a
	ld de, $0012
	add hl, de
	ld a, (hl)
	ld (ix+ALIEN.anim), a
	and a
	ld a, $06

	call z, play_sfx

	ld a, (ix+ALIEN.x)
	sub $02
	ld (ix+ALIEN.x), a

	cp $40
	jr c, .vanish

	call alien_hits_player
	ret nz

	call decrease_energy

.dead:
	call award_alien_score

.vanish:
	ld hl, VANISH_SMALL

	jp start_vanish


; jumper motion table: bytes 0-17 = jump height above GROUND_ROW (a parabola,
; peak $32 at step 9); bytes 18-35 = the sprite anim frame for each step.
; move_jumper indexes both by param1 (the step counter).
JUMPER_ARC:
	DB $0D,$14,$1A,$1F,$24,$29,$2C,$2F
	DB $31,$32,$31,$2F,$2C,$29,$24,$1F
	DB $1A,$14,$00,$05,$05,$05,$05,$04
	DB $04,$04,$03,$03,$03,$02,$02,$02
	DB $01,$01,$01,$01
