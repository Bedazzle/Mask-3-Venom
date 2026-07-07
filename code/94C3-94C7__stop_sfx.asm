; --- stop_sfx ------------------------------------------------
; @done
; Silence the object sound (clear the frame counter).
stop_sfx:
	xor a
	ld (SOUND_STATE), a

	ret
