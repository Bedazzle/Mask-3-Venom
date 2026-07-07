; --- death_explosion -----------------------------------------
; @done
; Player death: play the death sounds, whiten the screen, then
; scatter ~200 particles (PARTICLES, 5 bytes each: active, x, y,
; xvel, yvel) from the player and animate them for 150 halt-synced
; frames, XOR-plotting each with plot_particle.
death_explosion:
	ld a, $10
	call play_sfx

	ld a, $11
	call play_sfx

	call playfield_to_screen
	call playfield_to_screen

	ld hl, $5800
	ld b, $03
	ld c, $3F

.whiten:
	ld a, (hl)
	and c
	jr nz, .whiten_next

	ld (hl), $47
.whiten_next:
	inc l
	jr nz, .whiten

	inc h
	djnz .whiten

	ld a, (PLAYER_X_COORD)
	sub $40
	add a, a
	add a, $10
	ld l, a
	ld a, (PLAYER_Y_COORD)
	add a, $10
	ld h, a
	ld ix, PARTICLES
	ld de, PARTICLE_LEN
	ld b, $C8

.spawn:
	ld (ix+PARTICLE.ACTIVE), $FF

	call generate_random

	and $1F
	sub $10
	add a, l
	ld (ix+PARTICLE.X), a
	ld e, a

	call generate_random

	ld c, a
	and $07
	inc a
	bit 7, c
	jr z, .set_xvel

	neg
.set_xvel:
	ld (ix+PARTICLE.XVEL), a

	call generate_random

	and $1F
	sub $10
	add a, H
	ld (ix+PARTICLE.Y), a
	ld d, a

	call generate_random

	ld c, a
	and $07
	inc a
	bit 7, c
	jr z, .set_yvel

	neg
.set_yvel:
	ld (ix+PARTICLE.YVEL), a

	call plot_particle

	ld de, PARTICLE_LEN
	add ix, de
	djnz .spawn

	ld b, $96
.frame:
	push bc
	halt
	ld b, $C8
	ld ix, PARTICLES
.update:
	ld a, (ix+PARTICLE.ACTIVE)
	and a
	jr z, .next

	ld e, (ix+PARTICLE.X)
	ld d, (ix+PARTICLE.Y)

	call plot_particle

	ld a, d
	add a, (ix+PARTICLE.YVEL)
	ld d, a
	ld a, e
	add a, (ix+PARTICLE.XVEL)
	ld e, a
	ld a, d
	xor (ix+PARTICLE.Y)
	jp p, .check_x

	ld a, d
	add a, $10

	cp $21
	jr nc, .check_x

	ld (ix+PARTICLE.ACTIVE), $00
	jr .next

.check_x:
	ld a, e
	xor (ix+PARTICLE.X)
	jp p, .move

	ld a, e
	add a, $10

	cp $21
	jr nc, .move

	ld (ix+PARTICLE.ACTIVE), $00
	jr .next

.move:
	ld (ix+PARTICLE.Y), d
	ld (ix+PARTICLE.X), e

	call plot_particle

.next:
	ld de, PARTICLE_LEN
	add ix, de
	djnz .update

	pop bc
	djnz .frame

	ret
