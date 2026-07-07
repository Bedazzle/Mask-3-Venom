; --- animate_water_lava: copy the current animation frame for the water/lava sprites (SPRITE_E400/E630) (@done)
animate_water_lava:
	cp $01
	jp nz, .other
	ld a, (TILE_ANIM1)
	rrca
	rrca
	rrca
	ld l, a
	ld h, $00
	ld de, SPRITE_E400
	add hl, de
	ld de, SPRITE_E288
	ld a, e
	ld bc, $0010
	ldir
	ld e, a
	inc d
	ld bc, $0010
	ldir
	ld a, (TILE_ANIM2)
	rrca
	rrca
	rrca

	ld l, a
	ld h, $00
	ld de, SPRITE_E630
	add hl, de
	ld de, SPRITE_E600
	ld bc, $0010
	ld a, e
	ldir
	ld e, a
	inc d
	ld bc, $0010
	ldir
	ld a, (ANIM_TOGGLE)
	and a
	jr nz, .swap
	ld a, (TILE_ANIM2)
	cp $05
	jp nz, toggle_anim_tiles
	call generate_random
	and $07
	jp nz, toggle_anim_tiles

.swap:
	ld a, (TILE_ANIM2)
	ld (ANIM_TOGGLE), a
	ld l, a
	ld h, $00
	ld de, ANIM_BOUNCE7
	add hl, de
	ld a, (hl)
	add a, a
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld de, SPRITE_E788
	add hl, de
	ld de, SPRITE_E508
	ld bc, $0010
	ldir
	jp toggle_anim_tiles
.other:
	cp $02
	jr nz, .third

	ld a, (TILE_ANIM2)
	ld l, a
	ld h, $00
	ld de, ANIM_BOUNCE6
	add hl, de
	ld a, (hl)
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld de, SPRITE_E3A0
	add hl, de
	ld de, SPRITE_E360
	ld bc, $0008
	ldir
	jp toggle_anim_tiles

.third:
	ld a, (TILE_ANIM3)
	;mult
	ld l, a
	ld h, $00
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8
	add hl, hl	; x16
	add hl, hl	; x32
	ld de, spriteset_1
	add hl, de
	;mult HL=spriteset_1 + A*32
	ld de, SPRITE_E700
	ld bc, $0020
	ldir
	jp toggle_anim_tiles



diagonal_clear:
	ld sp,STACK
	ei
	call setup_main_menu		; main menu loop
	call new_game	; draw room

.loop:
	call is_fire_pressed	 	; ? inkey
	call update_player		; show player
	call move_bullet	 	; process fire
	call tick_hazards		; ? drowning
	call hit_alien
	call fire_weapon		; ? use weapon
	call select_weapon_slot		; ? switch weapon
	call print_score

	ld a, (DROWNING)

	IFNDEF WATERPROOF
		and a
	ELSE
		xor a
	ENDIF

	jp nz, lose_life

	ld a, (ENERGY)
	and a
	jr nz, .refresh

	ld a, (PLAYER)

	cp $09
	jr z, .refresh

	ld a, $09
	ld (PLAYER), a
	ld a, $32
	ld (PLAYER_FRAME_COUNT), a
	ld a, $01
	ld (DISSOLVE), a
	ld (INPUT_LOCK), a
.refresh:
	call draw_energy
	call show_weapon_slot
	call animate_playfield
	call draw_all_actors			; draw energy and loot
	ld hl, SLOT.BLINK
	inc (hl)
	ld hl, FRAME_PARITY
	ld a, (hl)
	add a, $01
	daa
	ld (hl), a
	jp .loop
