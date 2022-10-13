L946F:
	ld a, (L946C)
	and a
	jr z, L947F

	xor a
	ld (LC338+2), a
	ld (L946C), a
	ld (L94AB), a

L947F:
	ld a, (L946D)
	and a
	jr z, L948F

	xor a
	ld (LC34A+2), a
	ld (L946D), a
	ld (L94AB), a

L948F:
	ld a, (L946E)
	and a
	ret nz

	xor a
	ld (LC35C+2), a
	ld (L946E), a
	ld (L94AB), a

	ret
