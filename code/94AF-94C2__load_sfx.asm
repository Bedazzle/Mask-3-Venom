; --- load_sfx ------------------------------------------------
; @done
; Load a sound descriptor into SOUND_STATE (duration, start pitch,
; source pointer). Called by play_sfx. In: ix = descriptor
load_sfx:
	ld (SOUND_STATE+3), ix
	ld a, (ix+SFX.DURATION)
	ld (SOUND_STATE), a
	ld l, (ix+SFX.PITCH_LO)
	ld h, (ix+SFX.PITCH_HI)
	ld (SOUND_STATE+1), hl
	ret
