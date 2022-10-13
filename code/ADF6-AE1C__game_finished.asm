game_finished:
	; cls start
	ld hl, SCREEN
	ld de, SCREEN+1

	IFNDEF FIXENDGAME
		ld bc, SCREEN_LEN-1
	ELSE:
		ld bc, $0FFF
	ENDIF

	ld (hl), $00
	ldir
	; cls end

	ld de, $0801
	ld hl, FOUND_SCOTT

	call term_print

	ld a, $20

	call print_char

	ld de, $0C08
	ld hl, WELL_DONE

	call term_print

	jp diagonal_clear
