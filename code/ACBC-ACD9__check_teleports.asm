check_teleports:
	ld hl, ROOMS_LANDSCAPE + 5 * 8	; L7628  TELEPORTS is 5th room, 8 is room width
	ld de, TELEPORT_1

	ld b, $04
loop_teleport:
	ld a, (de)
	inc de
	and a
	jr nz, open_teleport

	ld (hl), $45
	inc hl
	ld (hl), $46
	inc hl
	jr next_teleport

open_teleport:
	ld (hl), $1E
	inc hl
	ld (hl), $1F
	inc hl
next_teleport:
	djnz loop_teleport

	ret
