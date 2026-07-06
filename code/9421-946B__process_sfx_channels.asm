; --- process_sfx_channels ------------------------------------
; @done
; Drain the SFX channel queue: for each of SFX_CH1..3 holding a
; descriptor, dequeue and play it through the alien-vector sound
; path. Called each frame from the interrupt.
; Note: dead in practice - the SFX_CH slots are only filled by
; play_sfx's dead branch (IS_128K is a constant $FF).
process_sfx_channels:
	ld hl, (SFX_CH1)
	ld a, h
	or l
	jr z, .ch2

	push hl
	pop iy
	ld ix, vec_cannonball-1
	ld hl, $00
	ld (SFX_CH1), hl

.play:
	ld c, (iy+SFX.DURATION)
	ld l, (iy+SFX.PITCH_LO)
	ld h, (iy+SFX.PITCH_HI)

	jp move_alien_x-1  ;C36A


.ch2:
	ld hl, (SFX_CH2)
	ld a, h
	or l
	jr z, .ch3

	push hl
	pop iy
	ld ix, vec_bomber_bomb-1
	ld hl, $00
	ld (SFX_CH2), hl

	jr .play


.ch3:
	ld hl, (SFX_CH3)
	ld a, h
	or l
	ret z

	push hl
	pop iy
	ld ix, vec_explosion-1
	ld hl, $00
	ld (SFX_CH3), hl

	jr .play
