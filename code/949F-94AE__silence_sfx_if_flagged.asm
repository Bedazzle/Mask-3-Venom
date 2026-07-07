; --- silence_sfx_if_flagged ----------------------------------
; @done
; If the reset flag RESET_JUMPER_SND is set, clear it and silence the object
; sound (SOUND_STATE). Called each frame from the interrupt.
silence_sfx_if_flagged:
	ld hl, RESET_JUMPER_SND
	ld a, (hl)
	and a
	ret z
	xor a
	ld (SOUND_STATE), a
	ld (hl), a
	ret


; Active object-sound state driven by sound_tick:
;   [0]   = frames remaining ($FF = indefinite, 0 = silent)
;   [1,2] = pitch accumulator (advanced by the source step each frame)
;   [3,4] = pointer to the source descriptor (its +$07/$08 = step)
SOUND_STATE:
	DB $00,$00,$00,$00
