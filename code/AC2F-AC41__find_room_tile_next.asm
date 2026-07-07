; --- find_room_tile_next --------------------------------------
; @done
; Resume the previous find_room_tile scan (hl/de/bc preserved in
; the alternate register set) to locate the next matching cell.
; Out: nz + bc = packed screen position if found; z if not found
find_room_tile_next:
	ld a, (SEARCH_TILE)
	exx
	jr .step

.cmp:
	cp (hl)
	jr z, room_tile_found

.step:
	inc hl
	djnz .cmp

	add hl, de
	ld b, $08
	dec c
	jr nz, .cmp

	ret
