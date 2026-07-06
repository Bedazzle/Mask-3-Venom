; --- pick_actor_sprite ---------------------------------------
; @done
; Select the current animation frame's graphics pointer (ALIEN.spr)
; for an actor. mode 0 = leave as-is; mode 1 = player (pick sprite
; by state, else a walk frame from x + facing); mode > 1 = alien
; (anim & anim_mask via SMC dispatch). While DISSOLVE is active it
; overlays the teleport materialise effect (dissolve_sprite).
; In: ix = actor
pick_actor_sprite:
	ld a, (ix+ALIEN.mode)
	and a
	ret z

	cp $01
	jp nz, pick_alien_frame

	ld hl, SPRITE_PLAYER_D160
	ld a, (ix+ALIEN.state)

	cp $08
	jr z, .store
    
	cp $0A
	jr z, .store
    
	cp $0C
	jr z, .store
    
	ld hl, SPRITE_PLAYER_D1E0

	cp $04
	jr z, .store
    
	ld hl, SPRITE_PLAYER_CDE0

	cp $07
	jr z, .store
    
	ld a, (ix+ALIEN.x)
	bit 7, (ix+ALIEN.facing)
	jr z, .walk_frame
    
	neg
.walk_frame:
	srl a
	srl a
	and $07
	ld h, a
	ld l, $00
	srl h
	rr l
	ld de, PLAYER_SPRITE
	add hl, de

.store:
	ld (ix+ALIEN.spr_lo), l
	ld (ix+ALIEN.spr_hi), h
	ld a, (DISSOLVE)
	and a
	ret z

.dissolve_loop:
	dec a
	jp z, dissolve_sprite

	push af
	call dissolve_sprite
	pop af

	jr .dissolve_loop

dissolve_sprite:
	ld l, (ix+ALIEN.spr_lo)
	ld h, (ix+ALIEN.spr_hi)
	ld de, SPRITE_DF80
	ld (ix+ALIEN.spr_lo), e
	ld (ix+ALIEN.spr_hi), d

	ld b, $20
	call generate_random

	ld r, a
	call generate_random

	ld c, a
.scatter:

	DUP 2
		ld a, r
		add a, c
		ld c, a
		and (hl)
		inc l
		ld (de), a
		inc e
	EDUP

	ld a, r
	add a, c
	ld c, a
	and (hl)
	inc l
	ld (de), a
	inc de

	ld a, r
	add a, c
	ld c, a
	and (hl)
	inc hl
	ld (de), a
	inc de

	djnz .scatter

	ret

pick_alien_frame:
	add a, a
	ld (.smc + 1), a     ; set SMC
	ld a, (ix+ALIEN.anim)
	and (ix+ALIEN.anim_mask)

.smc:
	jr .smc		; !!! SMC
