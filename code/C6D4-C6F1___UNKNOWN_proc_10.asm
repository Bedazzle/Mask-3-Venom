LC6D4:
	ld a, (ix+$04)
	ld (ix+$1C), a
	sub $08
	ld (ix+$04), a

	call LC362_0

	ld a, (ix+$04)
	bit $07, a
	ret z

	cp $E0
	ret nc

	ld a, (ix+$11)
	ld (ix+$00), a

	ret
