LAA75:
	ld hl, $0000
	ld (LAA72), hl

	ld a, (LA194)
	and a
	ret nz

	ld a, (LA194)	; optimize by remove
	and a			; optimize by remove
	ret nz			; optimize by remove
	
	ld hl, LF0C0
	ld bc, $0240
	ld e, $34		; 52
LAA75_0:
	ld a, (hl)

	cp e
	jr z, LAA75_1

	inc hl
	dec bc
	ld a, b
	or c
	jr nz, LAA75_0

	ret

LAA75_1:
	inc hl
	ld (LAA72), hl
	xor a
	ld (BRIDGE_DIR), a

	ret
