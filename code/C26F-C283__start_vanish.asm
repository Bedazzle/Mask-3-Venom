; --- start_vanish --------------------------------------------
; @done
; Turn this alien into its disappearing animation: enter state_vanish
; with a short timer, load the given "disappear" template, play a pop.
; In: ix = alien, hl = disappear template
start_vanish:
	ld (ix+ALIEN.timer), $04
	ld (ix+ALIEN.state), $03
	call copy_alien_template
	call generate_random
	and $03
	add a, $0B
	jp play_sfx
