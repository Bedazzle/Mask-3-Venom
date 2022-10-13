new_game:
	di
	pop hl
	ld sp,STACK
	push hl
	ei

	call generate_tables

	xor a
	ld (LEVEL_NUMBER), a
	ld (ROOM_NUMBER), a		; set initial room
	or $FF
	ld (ENERGY), a			; energy
	ld (CURRENT_LEVEL), a
	ld (PLAYER_FACING), a
	ld (L_A45E), a

	ld a, $48				; x coord
	ld (PLAYER_X_COORD), a

	ld a, $28				; y coord
	ld (PLAYER_Y_COORD), a

	ld a, $04				; player sprite width
	ld (PLAYER_WIDTH), a

	ld hl, PLAYER_SPRITE
	ld (PLAYER_SPRITEADR), hl

	ld a, $0B
	ld (LA43F), a

	ld a, $01				; facing 0-127 right, 128-255 left
	ld (PLAYER_FACING), a

	ld hl, BOXES
	ld de, $0004
loop_init_box:
	ld a, (hl)

	cp $FF
	jr z, init_slots

	res 7, (hl)
	add hl, de
	jr loop_init_box

init_slots:
	ld ix, SLOT.1
	ld de, $0004			; slot size in bytes
	ld b, $04				; number of slots
	xor a

loop_reset_slots:
	ld (ix + SLOT.WEAPON), a
	ld (ix + SLOT.LOAD), a
	add ix, de
	djnz loop_reset_slots

	ld hl, SLOT.1
	ld (ACTIVE_SLOT), hl

	call slot_blinking

	ld a, $01
	ld (CURRENT_WEAPON), a


	ld hl, ROOMS_LANDSCAPE
	ld bc, $0F00
loop_room_reset:
	ld a, (hl)

	cp CANNON_KILL		; $2B				; small cannon is destroyed
	jp nz, room_check_47

	ld (hl), CANNON_OK	;$12		; small cannon is working
	jr reset_next

room_check_47:
	cp ROTATOR_KILL		;$47		; rotator is destroyed
	jp nz, reset_next

	ld (hl), ROTATOR_OK	;$1B		; rotator is working
reset_next:
	inc hl
	dec bc
	ld a, b
	or c
	jp nz, loop_room_reset


	xor a
	ld (LC0D6), a
	ld (LB2F8), a
	ld (LA2D0-1), a
	ld (LBAA7), a
	ld (LB3EA), a

	ld hl, SCORE_BUFFER
	ld b, $04

loop_score_zero:
	ld (hl), a
	inc hl
	djnz loop_score_zero

	call LA89D

	jp check_teleports
