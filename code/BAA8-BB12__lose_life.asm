; --- lose_life: player death sequence - death sound, freeze, decrement life (@done)
lose_life:
	ld a, $08
	call play_sfx
	ld a, $FF
	ld (INPUT_LOCK), a
	xor a
	ld (DISSOLVE), a
	ld b, $20
lose_life_0:
	push bc
	ld hl, PLAYER_Y_COORD
	inc (hl)
	call animate_playfield
	call draw_all_actors
	pop bc
	djnz lose_life_0

	call playfield_to_screen
	call playfield_to_screen

; This entry point is used by the routines at player_dying and use_weapon.
lose_life_1:
	ld a, (IS_128K)
	ld (RESET_JUMPER_SND), a
	ld a, $02
	ld (SND_TRIG_1), a

	ld de, $0407
	ld hl, MISS_TERM

	call term_print

	ld hl, HISCORE
	ld de, SCORE_BUFFER
	ld b, $04
loop_hiscore:
	ld a, (de)
	cp (hl)
	jp c, diagonal_clear
	jr nz, lose_life_3

	inc hl
	inc de
	djnz loop_hiscore

lose_life_3:
	ld hl, SCORE_BUFFER
	ld de, HISCORE
	ld bc, $0004
	ldir
	jp diagonal_clear


MISS_TERM:
	ABYTEC 0 "MISSION TERMINATED"
