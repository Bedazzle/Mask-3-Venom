; --- level / room state: current level number, room-exits pointer, room number, box counts
LEVEL_NUMBER:
	DB $00
	
ROOM_EXITS_ADDR:
	DB $00,$00
	
ROOM_NUMBER:
	DB $00

BOXES:
	;    Lvl  ID  					X   Y
	DB $00, WEAPON.Penetrator,	$12,$0C	; Penetrator
	DB $00, WEAPON.Backlash,		$16,$0C	; Backlash

	DB $03, WEAPON.Healer,		$19,$08	; Healer
	DB $03, WEAPON.Blaster,		$1C,$08	; Blaster

	DB $05, WEAPON.Healer,		$0C,$08	; Healer
	DB $05, WEAPON.Jackrabbit,	$0E,$08	; Jackrabbit

	DB $08, WEAPON.Blaster,		$06,$08	; Blaster

	DB $0A, WEAPON.Blaster,		$0E,$0C	; Blaster
	DB $0A, WEAPON.Lifter,		$12,$0C	; Lifter
	DB $0A, WEAPON.Jackrabbit,	$8C,$0C	; Jackrabbit

	DB $0B, WEAPON.Jackrabbit,	$4A,$0C	; Jackrabbit

	DB $FF				; terminator
