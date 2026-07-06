; --- move_bridge -----------------------------------------------
; @done
; Animate the bridge tiles via BRIDGE_PTR (extend / retract).
move_bridge:
	ld hl, (BRIDGE_PTR)
	ld a, h
	or l

	ret z

	ld a, (BRIDGE_DIR)
	and a
	jr nz, bridge_to_left

bridge_to_right:
	ld a, (hl)

	cp $69
	jr z, .place

	ld a, $69
	jp bridge_done

.place:
	inc hl
	ld a, (hl)
	and a
	jr z, .placed

	dec hl
	ld (BRIDGE_PTR), hl
	or $FF
	ld (BRIDGE_DIR), a
	ld a, $6B

	jp bridge_done

.placed:
	ld (BRIDGE_PTR), hl
	ld a, $6B

	jp bridge_done

bridge_to_left:
	ld a, (hl)

	cp $6B
	jr z, .place
	
	ld a, $6B

	jp bridge_done
	
.place:
	dec hl
	ld a, (hl)

	cp $69
	jr nz, .placed

	ld (BRIDGE_PTR), hl
	inc hl
	xor a
	ld (hl), a
	ld de, $0020
	add hl, de
	ld (hl), a
	inc h
	inc h
	inc h
	inc a
	ld (hl), a
	sbc hl, de
	ld (hl), a

	ret

.placed:
	inc hl
	ld (BRIDGE_PTR), hl
	xor a
	ld (BRIDGE_DIR), a

	ret

bridge_done:
	ld (hl), a
	ld de, $0020
	add hl, de
	inc a
	ld (hl), a
	inc h
	inc h
	inc h
	ld (hl), $01
	and a
	sbc hl, de
	ld (hl), $01

	ret
