do_spheres:
	ld (ix+$00), $01

	ld hl, TEMPLATE_SPHERE

	call copy_alien_template

	ld (ix+$04), $E0

	call generate_random

	and $7F
	add a, $40
	
	ld (ix+$03), a		; initial x point

	and $03
	add a, $02			; vert speed
	ld (ix+$1C), a		; sphere y coord

LC04B_0:
	call generate_random

	and $03
	dec a

	cp $02
	jr z, LC04B_0

	ld (ix+$1B), a

	call generate_random

	ld (ix+$02), a

	ret
