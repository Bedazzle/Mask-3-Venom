; --- do_spheres ------------------------------------------------
; @done
; Spawn a sphere alien: state 1 (move_sphere), TEMPLATE_SPHERE,
; entering at the top (y $E0) at a random x.
; In: ix = alien slot
do_spheres:
	ld (ix+ALIEN.state), $01

	ld hl, TEMPLATE_SPHERE

	call copy_alien_template

	ld (ix+ALIEN.y), $E0

	call generate_random

	and $7F
	add a, $40
	
	ld (ix+ALIEN.x), a		; initial x point

	and $03
	add a, $02			; vert speed
	ld (ix+ALIEN.yvel), a		; sphere y coord

.retry_dir:
	call generate_random

	and $03
	dec a

	cp $02
	jr z, .retry_dir

	ld (ix+ALIEN.xvel), a

	call generate_random

	ld (ix+ALIEN.facing), a

	ret
