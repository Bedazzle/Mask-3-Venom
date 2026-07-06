; --- find_room_tile -------------------------------------------
; @done
; Search the current room background map (ROOM_BACKGR_ADDR) for
; the first cell holding tile code A, scanning an 8-wide x 5-tall
; window (40-byte row stride). On a hit, room_tile_found converts
; the grid position into a packed screen coordinate in bc.
; In:  a = tile code to find
; Out: nz + bc = packed screen position if found; z if not found
; Note: find_room_tile_next resumes this scan for further hits
find_room_tile:
	ld (SEARCH_TILE), a
	ld hl, (ROOM_BACKGR_ADDR)
	ld de, $0028		; 40 = row stride
	ld bc, $0805		; b=8 cols, c=5 rows

.scan:
	cp (hl)
	jr z, room_tile_found

	inc hl
	djnz .scan

	add hl, de
	ld b, $08
	dec c
	jr nz, .scan

	ret


; Shared tail of find_room_tile / find_room_tile_next: turn the
; grid position (b=cols left, c=rows left) into a packed screen
; coordinate in bc and flag success (or $FF -> nz).
room_tile_found:
	push bc
	exx
	pop bc
	ld a, $08
	sub b			; column = 8 - cols_left
	rlca
	rlca
	rlca
	rlca
	add a, $40
	ld b, a
	ld a, $05
	sub c			; row = 5 - rows_left
	rrca
	rrca
	rrca
	sub $10
	ld c, a
	or $FF			; nz = found

	ret


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
