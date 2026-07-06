; --- striped_border --------------------------------------------
; @done
; Draw a striped border by racing the beam.
; Note: DEAD - no callers.
striped_border:
	push bc
	push af
	ld bc, 3000
loop_striped:
	inc a
	and a, $07
	out ($FE), a	; border color
	dec bc
	ld a, b
	or c
	jr nz, loop_striped
	
	pop af
	pop bc

	ret
