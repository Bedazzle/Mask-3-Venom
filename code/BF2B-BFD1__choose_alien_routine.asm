; --- choose_alien_routine --------------------------------------
; @done
; For each idle alien slot, spawn the room's next enemy by
; dispatching to the do_* routine named in ROOM_ALIEN_SET.
; In: ix = alien slot
choose_alien_routine:
	ld a, (ix+ALIEN.state)
	and $7F
	ret nz

	ld a, (ROOM_ALIEN_SET)

	cp $05
	jr z, .spawn_now
    
	cp $06
	jr z, .spawn_now
    
	cp $08
	jr z, .spawn_now
    
	cp $09
	jr z, .spawn_now
    
	cp $0A
	jr z, .spawn_now
    
	call generate_random

	and $2E
	jr nz, arm_alien

.spawn_now:
	ld a, (BOSS_ACTIVE)
	and a
	jp nz, arm_alien
    
	ld a, (ROOM_ALIEN_SET)
	;mult
	ld l, a
	add a, a	; x2
	add a, l	; x3	jp NNNN = 3 bytes
	ld l, a
	ld h, $00
	ld de, alien_routines
	add hl, de
	; mult HL = A*3 + alien_routines
	jp (hl)

; entry point used by do_bomb.
arm_alien:
	ld a, (ALIEN.1)

	cp $08
	ret z
	
	ld (ix+ALIEN.x), $01
	ld (ix+ALIEN.y), $00
	ld (ix+ALIEN.width), $02
	ld (ix+ALIEN.height), $02
	ld (ix+ALIEN.state), $80

	ret

spawn_boss:
	ld ix, ALIEN.1
	ld b, $06
	ld de, ALIEN_LEN
	ld a, $00
loop_check_aliens:
	or (ix+ALIEN.state)
	add ix, de
	djnz loop_check_aliens

	and a
	ret nz

	ld ix, ALIEN.1
	ld (ix+ALIEN.state), $80
	ld (ix+ALIEN.width), $04
	ld (ix+ALIEN.height), $05
	ld (ix+ALIEN.y), $00
	ld (ix+ALIEN.x), $01
	ld (ix+ALIEN.mode), $06

	ret


ROOM_ALIEN_SET:
	DB $00


alien_routines:
	ret
	DB $00,$00

	jp do_rockets
	jp do_spheres
	jp do_jumpers
	jp do_mushrooms
	jp do_harrier
	jp do_bomber
	jp do_volcano
	jp do_bomb
	jp do_mortar
	jp do_snake
