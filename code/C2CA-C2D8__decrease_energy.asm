decrease_energy:
	ld a, (ENERGY)
	sub (ix+$1E)
	ld (ENERGY), a
	ret nc

	xor a
	ld (ENERGY), a

	ret
