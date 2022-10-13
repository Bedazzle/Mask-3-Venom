welcome_message:
	ld a, (ROOM_NUMBER)
	and a
	ret nz

	ld hl, GOOD_LUCK
	ld a, (LEVEL_NUMBER)
	and a
	jp z, set_new_message

	;-----------------
	ld hl, BUFFER_PASS
	ld de, PASS_1
	call decode_pass

	ld hl, CODE_BROKEN
	cp $0B
	jp z, set_new_message

	;-----------------
	ld hl, BUFFER_PASS
	ld de, PASS_2
	call decode_pass

	ld hl, CODE_BROKEN
	cp $03
	jp z, set_new_message

	;-----------------
	ld hl, BUFFER_PASS
	ld de, PASS_3
	call decode_pass

	ld hl, CODE_BROKEN
	cp $07
	jp z, set_new_message

	;-----------------
	ld hl, BUFFER_PASS
	ld de, PASS_4
	call decode_pass

	ld hl, CODE_BROKEN
	cp $0A
	jp z, set_new_message

	ret


GOOD_LUCK:
	ABYTEC 0 "GOOD LUCK MATT......"

CODE_BROKEN:
	DEFM "...CODE BROKEN.....PASSWORD IS "

BUFFER_PASS:
	defs $10
