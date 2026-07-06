; --- apply_hazard_damage --------------------------------------
; @done
; In the hazard environment (SPRITESET theme 1), bleed the
; player's energy by 2 per call, clamped at zero. Any other
; theme is a no-op. Called each frame while jumping/flying.
; Out: (ENERGY) reduced by 2 when in theme 1
; Note: the SAFESOME cheat NOPs out the subtraction
apply_hazard_damage:
	push af
	ld a, (SPRITESET)
	dec a
	jr nz, .done		; only theme 1 hurts

	ld a, (ENERGY)
	IFNDEF SAFESOME
		sub $02
	ELSE
		nop
		nop
	ENDIF
	jr nc, .store

	xor a			; clamp at zero
.store:
	ld (ENERGY), a
.done:
	pop af

	ret
