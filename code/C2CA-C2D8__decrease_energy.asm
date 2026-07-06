; --- decrease_energy -------------------------------------------
; @done
; Subtract the alien's contact damage from the player's ENERGY,
; clamping at 0.
; In: ix = alien (its .damage)
; Out: ENERGY reduced
decrease_energy:
	ld a, (ENERGY)
	sub (ix+ALIEN.damage)
	ld (ENERGY), a
	ret nc

	xor a
	ld (ENERGY), a

	ret
