collect_box:
	ld ix, BOX.1

	call collect_box_0

	ld ix, BOX.2
collect_box_0:
	ld a, (ix + BOX.X)
	inc a
	ret z

	ld a, (PLAYER_X_COORD)
	sub $36
	srl a
	srl a
	ld l, a
	ld a, (ROOM_NUMBER)
	add a, a	; x2
	add a, a	; x4
	add a, l
	ld l, a
	sub (ix + BOX.X)

	cp $04
	ret nc

	ld (ix + BOX.X), $FF
	ld c, (ix + BOX.TYPE)
	ld l, (ix + BOX.LO)
	ld h, (ix + BOX.HI)
	set 7, (hl)

	ld ix, (ACTIVE_SLOT)
	ld a, (ix + SLOT.WEAPON)
	and a						; check if slot is empty

	call z, find_weapon
	call nz, find_empty_slot

	ld (ix + SLOT.WEAPON), c
	ld (ix + SLOT.LOAD), $99		; fully loaded weapon
	ld b, $00
	ld hl, X_BUFFER
	add hl, bc
	ld a, (hl)
	ld (ix + SLOT.XXX), a

	call slot_blinking

	ret

find_empty_slot:
	push bc
	ld ix, SLOT.1
	ld de, $0004	; slot length in bytes
	ld b, $04		; number of slots
loop_slots:
	ld a, (ix + SLOT.WEAPON)
	and a
	jr z, slot_found

	add ix, de
	djnz loop_slots

	ld ix, (ACTIVE_SLOT)
slot_found:
	pop bc

	ret


find_weapon:
	push af
	push bc
	ld a, c

	call LB0CE

	pop bc
	pop af

	ret

	
WEAPONS:		;LB197:
	DEFM "   EMPTY   "		; 0
	DEFM "PENETRATOR "		; 1
	DEFM "ULTRA FLASH"		; 2
	DEFM "  MIRAGE   "		; 3
	DEFM "  HEALER   "		; 4
	DEFM "JACKRABBIT "		; 5
	DEFM "  LIFTER   "		; 6
	DEFM "  BLASTER  "		; 7
	DEFM " BACKLASH  "		; 8
	DEFM " LAVA SHOT "		; 9
	DEFM " STREAMER  "		; 10
