; --- ay_core ($C092-$C332): init impl, per-frame play (ay_play_impl), pattern interpreter (process_channel)
; --- ay_init_impl ----------------------------------------------
; @done
; Init: A*6 -> SONG_PATTERNS; load the 3 channels' pattern-start pointers; silence.
ay_init_impl:
	push af
	call ay_silence
	pop af
	ld l, a
	add a, a
	add a, l
	add a, a
	ld hl, SONG_PATTERNS
	add a, l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry:
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld (CHAN_A+CHAN.pat_lo), de
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld (CHAN_B+CHAN.pat_lo), de
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld (CHAN_C+CHAN.pat_lo), de
	xor a
	ld (CHAN_A+CHAN.pat_orn), a
	ld (CHAN_B+CHAN.pat_orn), a
	ld (CHAN_C+CHAN.pat_orn), a
	ld (CHAN_A+CHAN.orn_idx), a
	ld (CHAN_B+CHAN.orn_idx), a
	ld (CHAN_C+CHAN.orn_idx), a
	cpl
	ld (CHAN_A+CHAN.pending), a
	ld (CHAN_B+CHAN.pending), a
	ld (CHAN_C+CHAN.pending), a
	ld a, $01
	ld (CHAN_A+CHAN.pat_dur), a
	ld (CHAN_B+CHAN.pat_dur), a
	ld (CHAN_C+CHAN.pat_dur), a
	ld (CHAN_A+CHAN.nd_dur), a
	ld (CHAN_B+CHAN.nd_dur), a
	ld (CHAN_C+CHAN.nd_dur), a
	ld hl, CHAN_CMD_OFS
	ld bc, $030A
.next_grp:
	xor a
.fill_ofs:
	ld (hl), a
	inc hl
	add a, c
	ld (hl), a
	inc hl
	add a, c
	cp $50
	jr nz, .fill_ofs
	djnz .next_grp
	ld hl, SAMPLE_DATA
	ld (CHAN_A+CHAN.smp_lo), hl
	ld (CHAN_B+CHAN.smp_lo), hl
	ld (CHAN_C+CHAN.smp_lo), hl
	ld a, $FF
	ld (CHAN_A+CHAN.active), a
	ld (CHAN_B+CHAN.active), a
	ld (CHAN_C+CHAN.active), a
	ld (play_active), a
	ret

; --- ay_play_impl ----------------------------------------------
; @done
; Per-frame play: update state, then run process_channel for channels A/B/C.
ay_play_impl:
	call ay_frame_update
	ld a, (play_active)
	and a
	ret z
	ld a, (CHAN_A+CHAN.active)
	ld hl, CHAN_B+CHAN.active
	or (hl)
	ld hl, CHAN_C+CHAN.active
	or (hl)
	ld (play_active), a
	jr nz, .process
	xor a
	ld (play_active), a
	ld a, (AY_MIXER)
	and $3F
	cp $3F
	ret z
	ld a, $01
	ld (play_active), a
	ret

.process:
	ld iy, CHAN_A
	ld ix, CHANREG_A
	call process_channel
	ld iy, CHAN_B
	ld ix, CHANREG_B
	call process_channel
	ld iy, CHAN_C
	ld ix, CHANREG_C
; --- process_channel -------------------------------------------
; @done
; Interpret one channel's PATTERN stream (note / duration / ornament / cmd / end). In: iy=CHAN, ix=CHANREG.
process_channel:
	call apply_ornament
	ld a, (iy+CHAN.pending)
	and a
	jr z, play_note.continue
.tick_pat:
	dec (iy+CHAN.pat_dur)
	jr z, .read_pat
	ld a, (iy+CHAN.nd_lo)
	ld (iy+CHAN.cur_lo), a
	ld a, (iy+CHAN.nd_hi)
	ld (iy+CHAN.cur_hi), a
	ld (iy+CHAN.pending), $00
	jr play_note.continue

.read_pat:
	ld (iy+CHAN.pat_dur), $01
	ld l, (iy+CHAN.pat_lo)
	ld h, (iy+CHAN.pat_hi)
.next_byte:
	ld a, (hl)
	cp $80
	jr c, play_note
	cp $FE
	jr nz, .chk_end
	inc hl
	ld a, (hl)
	ld (iy+CHAN.pat_orn), a
	inc hl
	jp .next_byte

.chk_end:
	cp $FF
	jr nz, .set_dur
	xor a
	ld (iy+CHAN.active), a
	ret

.set_dur:
	cp $C0
	jr nc, .set_cmd
	and $1F
	ld (iy+CHAN.pat_dur), a
	inc hl
	jp .next_byte

.set_cmd:
	and $07
	add a, (iy+CHAN.base)
	ld de, CHAN_CMD_OFS
	add a, e
	ld e, a
	jr nc, .no_carry
	inc d
.no_carry:
	inc hl
	ldi
	jp .next_byte

; --- play_note -------------------------------------------------
; @done
; Pattern NOTE byte: look up its note-data stream (NOTEDATA_LO/HI) and start it.
play_note:
	ld (iy+CHAN.pending), $00
	inc hl
	ld (iy+CHAN.pat_lo), l
	ld (iy+CHAN.pat_hi), h
	ld c, a
	ld b, $00
	ld hl, NOTEDATA_LO
	add hl, bc
	ld e, (hl)
	ld hl, NOTEDATA_HI
	add hl, bc
	ld d, (hl)
	ld (iy+CHAN.nd_lo), e
	ld (iy+CHAN.nd_hi), d
	jr .advance

.continue:
	ld e, (iy+CHAN.cur_lo)
	ld d, (iy+CHAN.cur_hi)
.advance:
	dec (iy+CHAN.nd_dur)
	jr z, .read_nd
	ld a, (de)
	cp $80
	call nc, note_cmd
	ld (iy+CHAN.cur_lo), e
	ld (iy+CHAN.cur_hi), d
	ret

.read_nd:
	ld a, (de)
	cp $80
	jr c, .chk_pitch
	call note_cmd
	ld a, (iy+CHAN.pending)
	and a
	jr z, .read_nd
	jp process_channel.tick_pat

.chk_pitch:
	cp $7F
	jr z, .rest
	cp $7E
	jr nz, .pitch
	inc de
	ld a, (de)
	ld l, a
	inc de
	ld a, (de)
	ld h, a
	jp .emit_note

.pitch:
	add a, (iy+CHAN.pat_orn)
	add a, $0C
	ld (iy+CHAN.note), a
	ld hl, NOTE_PERIODS
	add a, a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
.emit_note:
	ld a, (iy+CHAN.orn_idx)
	or $C0
	ld (iy+CHAN.orn_ctl), a
	inc de
	ld a, (de)
	inc de
	ld (iy+CHAN.nd_dur), a
	ld c, a
	ld (iy+CHAN.cur_lo), e
	ld (iy+CHAN.cur_hi), d
	ld e, (iy+CHAN.smp_lo)
	ld a, (iy+CHAN.smp_hi)
	ld iyh, a
	ld iyl, e
	bit 7, (ix+CHANREG.flags)
	ret nz
	jp start_note

.rest:
	inc de
	ld a, (de)
	inc de
	ld (iy+CHAN.nd_dur), a
	ld (iy+CHAN.cur_lo), e
	ld (iy+CHAN.cur_hi), d
	ret

; --- note_cmd --------------------------------------------------
; @done
; Note-data stream command ($80+): sample select / ornament / control / note-off.
note_cmd:
	ld a, (de)
	cp $88
	jr nc, .not_sample
	and $07
	add a, (iy+CHAN.base)
	ld c, a
	ld b, $00
	ld hl, CHAN_CMD_OFS
	add hl, bc
	ld c, (hl)
	ld hl, SAMPLE_DATA
	add hl, bc
	ld (iy+CHAN.smp_lo), l
	ld (iy+CHAN.smp_hi), h
	inc de
	ret

.not_sample:
	cp $FF
	jr nz, .set_orn
	ld (iy+CHAN.pending), $FF
	ret

.set_orn:
	cp $C0
	jr nc, .control
	and $0F
	ld (iy+CHAN.orn_idx), a
	inc de
	ret

.control:
	inc de
	cp $C2
	ret z
	inc de
	inc de
	inc de
	ret

; --- apply_ornament --------------------------------------------
; @done
; Advance the channel's ornament (arpeggio) one step; sets the current note offset.
apply_ornament:
	bit 7, (ix+CHANREG.flags)
	ret nz
	ld a, (iy+CHAN.orn_ctl)
	bit 7, a
	ret z
	and $3F
	jr nz, .active
	res 7, (iy+CHAN.orn_ctl)
	ret

.active:
	ld d, $07
	bit 6, (iy+CHAN.orn_ctl)
	jr nz, .next_seg
	dec (iy+CHAN.orn_dur)
	ret nz
	dec (iy+CHAN.orn_rep)
	jp z, .next_seg
	ld l, (iy+CHAN.ornp_lo)
	ld h, (iy+CHAN.ornp_hi)
	inc l
	ld (iy+CHAN.ornp_lo), l
	jp nz, .apply
	inc h
	ld (iy+CHAN.ornp_hi), h
.apply:
	ld a, (hl)
	and d
	ld (iy+CHAN.orn_dur), a
	ld a, (hl)
	rrca
	rrca
	rrca
	and $1F
	add a, (iy+CHAN.note)
	jp note_to_period

.next_seg:
	ld hl, $C4EA
	ld a, (iy+CHAN.orn_ctl)
	add a, a
	add a, a
	add a, a
	ld e, a
	add hl, de
	bit 7, (hl)
	jr nz, .load_seg
	bit 6, (iy+CHAN.orn_ctl)
	jr nz, .load_seg
	ld (iy+CHAN.orn_rep), $01
	ret

.load_seg:
	res 6, (iy+CHAN.orn_ctl)
	ld a, (hl)
	rrca
	rrca
	rrca
	and d
	ld (iy+CHAN.orn_dur), a
	ld a, (hl)
	and d
	inc a
	ld (iy+CHAN.orn_rep), a
	ld (iy+CHAN.ornp_lo), l
	ld (iy+CHAN.ornp_hi), h
	ld a, (iy+CHAN.note)
; --- note_to_period --------------------------------------------
; @done
; Note index -> AY tone period via NOTE_PERIODS; store in the channel's per_lo/hi.
note_to_period:
	add a, a
	ld hl, NOTE_PERIODS
	add a, l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry:
	ld a, (hl)
	ld (ix+CHANREG.per_lo), a
	inc hl
	ld a, (hl)
	ld (ix+CHANREG.per_hi), a
	ret

