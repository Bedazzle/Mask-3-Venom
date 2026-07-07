; --- envelope ($C507-$C563): 4-phase amplitude envelope generator (env_attack->decay->sustain->release; jp (hl) state machine via ix+13/14)
; --- env_attack ------------------------------------------------
; @done
; Envelope attack: raise level to the peak, then chain to env_decay.
env_attack:
	ld a, (ix+CHANREG.level)
	add a, (iy+CHAN.base)
	cp (iy+CHAN.nd_hi)
	jr nc, .to_decay
	ld (ix+CHANREG.level), a
	ret

.to_decay:
	ld a, (iy+CHAN.nd_hi)
	ld (ix+CHANREG.level), a
	ld hl, env_decay
	ld (ix+CHANREG.env_lo), l
	ld (ix+CHANREG.env_hi), h
	ret

; --- env_decay -------------------------------------------------
; @done
; Envelope decay: fall to the sustain level, then chain to env_sustain.
env_decay:
	ld a, (ix+CHANREG.level)
	add a, (iy+CHAN.pat_lo)
	jp m, .to_sustain
	cp (iy+CHAN.pat_hi)
	jr c, .to_sustain
	ld (ix+CHANREG.level), a
	ret

.to_sustain:
	ld a, (iy+CHAN.pat_hi)
	ld (ix+CHANREG.level), a
	ld hl, env_sustain
	ld (ix+CHANREG.env_lo), l
	ld (ix+CHANREG.env_hi), h
	ret

; --- env_sustain -----------------------------------------------
; @done
; Envelope sustain: hold, then chain to env_release.
env_sustain:
	ld a, (ix+CHANREG.dur)
	and a
	ret nz
	ld hl, env_release
	ld (ix+CHANREG.env_lo), l
	ld (ix+CHANREG.env_hi), h
	ret

; --- env_release -----------------------------------------------
; @done
; Envelope release: fall to silence.
env_release:
	ld a, (ix+CHANREG.level)
	add a, (iy+CHAN.nd_lo)
	jp m, silence_channel
	ld (ix+CHANREG.level), a
	ret

