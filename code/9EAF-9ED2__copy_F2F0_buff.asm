; --- copy_F2F0_buff: copy the BUFF_F2F0 work buffer into PLAYFIELD_MAP (56 rows x 20 cells) (@done)
copy_F2F0_buff:
	ld de, PLAYFIELD_MAP
	ld hl, BUFF_F2F0
	ld b, $38
.loop:
	push hl
	ld c, 20		;$14
	DUP 10
		ldi
	EDUP

	pop hl
	inc hl
	djnz .loop

	ret
