; --- clear_alien_vectors -------------------------------------
; @done
; Per-frame (from interrupt). For each looping-sound alien flag
; (RESET_JUMPER_SND/RESET_VOLCANO_SND/RESET_SNAKE_SND, matching alien-state vectors 6/12/18 =
; jumper/volcano/snake), if the flag is set, zero the high byte of
; that ALIEN_STATE_TABLE entry (vec_jumper/vec_volcano/vec_snake_head +2) to deactivate
; the vector, clear the flag, and silence the object sound.
; Note: RESET_SNAKE_SND is never set -> its branch is dead.
clear_alien_vectors:
	ld a, (RESET_JUMPER_SND)
	and a
	jr z, .chk_volcano

	xor a
	ld (vec_jumper+2), a
	ld (RESET_JUMPER_SND), a
	ld (SOUND_STATE), a

.chk_volcano:
	ld a, (RESET_VOLCANO_SND)
	and a
	jr z, .chk_snake

	xor a
	ld (vec_volcano+2), a
	ld (RESET_VOLCANO_SND), a
	ld (SOUND_STATE), a

.chk_snake:
	ld a, (RESET_SNAKE_SND)
	and a
	ret nz

	xor a
	ld (vec_snake_head+2), a
	ld (RESET_SNAKE_SND), a
	ld (SOUND_STATE), a

	ret
