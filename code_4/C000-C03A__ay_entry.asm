; ============================================================
;  MASK III (128K) - AY music player, RAM bank 4 ($C000-$CF9F)
;  From venom2.c on MASK3128.TAP (author "DRJ"); 128K build only.
;  Byte-exact to the tape block. The main-game interrupt pages
;  bank 4 ($7FFD=$14) and calls ay_play each frame.
;  API @ $C000: ay_init(A=song) / ay_play / ay_init_song ;
;  ay_write_reg = out ($FFFD),reg=e : out ($BFFD),val=a.
;  Auto-disassembled (recursive-descent, byte-exact). Intra-routine
;  branch labels are dot-locals (.loop/.skip/.done); channel state is
;  the CHAN (iy) / CHANREG (ix) structs; pattern + instrument byte
;  grammars are decoded (see data_4/C5C6-CF9F__song_data.asm header).
; ============================================================
; --- ay_entry ($C000-$C03A): public jump table (ay_init/ay_play/ay_init_song) + song init body
; --- ay_init ---------------------------------------------------
; @done
; Public entry: A = song number. Reset and start playback of that song.
ay_init:
	jp ay_init_impl

; --- ay_play ---------------------------------------------------
; @done
; Public entry: call once per frame - advance the 3 channels and emit AY registers.
ay_play:
	jp ay_play_impl

play_active:
	DB $00
; --- ay_init_song ----------------------------------------------
; @done
; Public entry (UNUSED): jp ay_init_body.
ay_init_song:
	jp ay_init_body

	DB $AF,$32,$06,$C0,$C3,$F1,$C3
initsong_chanreg_ptr:
	DB $34,$C3
; --- ay_init_body ----------------------------------------------
; @done
; Unused init path: pick a descriptor from leftover_gameloop and call start_note.
ay_init_body:
	di
	ld l, a
	ld e, a
	ld h, $00
	ld d, h
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	add hl, de
	ld iy, leftover_gameloop
	ex de, hl
	add iy, de
	ld l, (iy+CHAN.pat_orn)
	ld h, (iy+CHAN.pending)
	ld c, (iy+CHAN.nd_dur)
	ld ix, (initsong_chanreg_ptr)
	call start_note
	set 7, (ix+CHANREG.flags)
	ei
	ret

