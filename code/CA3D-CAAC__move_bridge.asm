move_bridge:
	ld hl, (LAA72)
	ld a, h
	or l

	;display "here: move_bridge", $
	ret z
	;ret

	ld a, (BRIDGE_DIR)
	and a
	jr nz, bridge_to_left

bridge_to_right:
	ld a, (hl)

	cp $69
	jr z, LCA3D_0

	ld a, $69
	jp LCA3D_5

LCA3D_0:
	inc hl
	ld a, (hl)
	and a
	jr z, LCA3D_1

	dec hl
	ld (LAA72), hl
	or $FF
	ld (BRIDGE_DIR), a
	ld a, $6B

	jp LCA3D_5

LCA3D_1:
	ld (LAA72), hl
	ld a, $6B

	jp LCA3D_5

bridge_to_left:
	ld a, (hl)

	cp $6B
	jr z, LCA3D_3
	
	ld a, $6B

	jp LCA3D_5
	
LCA3D_3:
	dec hl
	ld a, (hl)

	cp $69
	jr nz, LCA3D_4

	ld (LAA72), hl
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

LCA3D_4:
	inc hl
	ld (LAA72), hl
	xor a
	ld (BRIDGE_DIR), a

	ret

LCA3D_5:
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
