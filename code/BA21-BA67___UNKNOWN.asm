LBA21:
	ld ix, SLOT.1
	ld a,(ix+$01)
	and a

	call z, LBA60
	call LBA3E

	ld (ix+$01), $06
	ld (ix+$02), $99
	ld (ix+$03), $01

	jp slot_blinking

LBA3E:
	ld ix, SLOT.1
	ld de, $0004
	ld b, $04
LBA47:
	ld a, (ix+$01)

	cp $08
	jr nz, LBA52

	ld (ix+$03), $03
LBA52:
	and a
	ret z

	cp $01
	ret z

	add ix, de
	djnz LBA47

	ld ix, SLOT.1

	ret

LBA60:
	push af
	ld a, $06

	call LB0CE

	pop af

	ret 	
