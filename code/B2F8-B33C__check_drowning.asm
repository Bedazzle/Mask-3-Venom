DROWNING:
	DB $00


; --- check_drowning -------------------------------------------
; @done
; In the water/lava themes, test the two map cells just below the
; player (PLAYER_CELL_PTR + $81 / +$82) for the theme's deadly tile and
; raise the DROWNING flag on contact. The main loop turns
; DROWNING into a lost life unless WATERPROOF is defined. Skipped
; entirely while CHEAT_FLAG is set.
; In:  (PLAYER_CELL_PTR) = player's map cell (from find_player_cell)
; Out: DROWNING = $FF on a deadly tile
check_drowning:
	ld a, (CHEAT_FLAG)
	and a
	ret nz

	ld a, (SPRITESET)

	cp $02
	call z, .theme2

	ld c, $EA		; deadly tile (themes 0/1)
	ld a, (SPRITESET)

	cp $03
	jr nz, .test

	ld c, $ED		; deadly tile (theme 3)

.test:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp c
	jr nz, .test2

	ld a, $FF
	ld (DROWNING), a

.test2:
	inc hl
	ld a, (hl)

	cp c
	jr nz, .done

	ld a, $FF
	ld (DROWNING), a

.done:
	ret

.theme2:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp $FE			; theme 2 deadly tiles are >= $FE
	ret c

	ld a, $FF
	ld (DROWNING), a

	ret
