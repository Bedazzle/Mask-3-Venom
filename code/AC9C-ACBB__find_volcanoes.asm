VOLCANO_1:
	DB $00,$00
VOLCANO_2:
	DB $00,$00


; --- find_volcanoes -------------------------------------------
; @done
; Locate up to two volcano tiles ($61) in the current room and
; cache their packed screen positions for do_volcano.
; Out: VOLCANO_1 / VOLCANO_2 = positions (zero if absent)
find_volcanoes:
	ld hl, $0000
	ld (VOLCANO_1), hl
	ld (VOLCANO_2), hl
	ld a, $61		; volcano tile code

	call find_room_tile
	ret z

	ld (VOLCANO_1), bc

	call find_room_tile_next
	ret z

	ld (VOLCANO_2), bc

	ret
