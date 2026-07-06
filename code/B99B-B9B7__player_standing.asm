; --- player_standing -----------------------------------------
; @done
; Player standing action (dispatched from action_by_accum, slot 6):
; if a direction key is held, switch to the walking state (1);
; otherwise run the idle check. In: ix = player
player_standing:
	ld a, (KEY_FIRE_CURRENT)
	and $0F
	jr nz, .walk

	ld iy, .on_ground
	jp update_player_7

.on_ground:
	call check_ground

	and a
	jp z, start_fall

	ret

.walk:
	ld (ix+ALIEN.state), $01

	jp update_player_1
