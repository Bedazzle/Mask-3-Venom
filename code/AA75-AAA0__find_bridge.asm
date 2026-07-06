; --- find_bridge ----------------------------------------------
; @done
; Locate the bridge tile ($34) in the current room's playfield
; map (PLAYFIELD_MAP, $0240 bytes) and cache its cell pointer for
; move_bridge; resets the bridge direction. Only theme 0 has a
; bridge, so other spritesets bail out.
; Out: BRIDGE_PTR = cell after the bridge tile (0 if none),
;      BRIDGE_DIR = 0
find_bridge:
	ld hl, $0000
	ld (BRIDGE_PTR), hl

	ld a, (SPRITESET)
	and a
	ret nz

	ld a, (SPRITESET)	; optimize by remove
	and a			; optimize by remove
	ret nz			; optimize by remove

	ld hl, PLAYFIELD_MAP
	ld bc, $0240
	ld e, $34		; 52 = bridge tile
.scan:
	ld a, (hl)

	cp e
	jr z, .found

	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .scan

	ret

.found:
	inc hl
	ld (BRIDGE_PTR), hl
	xor a
	ld (BRIDGE_DIR), a

	ret
