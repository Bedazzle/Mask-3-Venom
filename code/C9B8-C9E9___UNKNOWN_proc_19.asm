LC9B8:
	ld a, (ix+$04)
	ld (ix+$1C), a
	ld a, (ix-10)
	ld (ix+$04), a
	dec (ix+$03)

	call LC2D9
	call z, decrease_energy

	ld a, (ix+$1B)
	and a
	ret z

	ld a, (ix+$03)
	cp $38
	ret nc

	ld ix, ALIEN.1
	ld de, $26
	ld b, $06

LC9E1:
	ld (ix+$00), $80
	add ix, de
	djnz LC9E1

	ret
