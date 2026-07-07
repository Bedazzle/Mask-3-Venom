; bank 4 ($C000): 128K AY music player (venom2.c). Included by mask_3_loaded.asm under IFDEF _128K.

; --- CHAN: 21-byte per-voice channel state (iy in the pattern/note routines) ---
CHAN_LEN	EQU $15
CHAN
.base     	EQU $00
.pat_lo   	EQU $01
.pat_hi   	EQU $02
.nd_lo    	EQU $03
.nd_hi    	EQU $04
.cur_lo   	EQU $05
.cur_hi   	EQU $06
.smp_lo   	EQU $07
.smp_hi   	EQU $08
.pat_dur  	EQU $09
.pat_orn  	EQU $0A
.pending  	EQU $0B
.nd_dur   	EQU $0C
.active   	EQU $0D
.note     	EQU $0E
.orn_idx  	EQU $0F
.ornp_lo  	EQU $10
.ornp_hi  	EQU $11
.orn_dur  	EQU $12
.orn_rep  	EQU $13
.orn_ctl  	EQU $14

; --- CHANREG: 18-byte per-voice AY register work set (ix) ---
CHANREG_LEN	EQU $12
CHANREG
.tonemask 	EQU $00
.noisemask	EQU $01
.mixmask  	EQU $02
.per_lo   	EQU $03
.per_hi   	EQU $04
.level    	EQU $05
.dur      	EQU $06
.vib_delay	EQU $07
.vib_half 	EQU $08
.vacc_lo  	EQU $09
.vacc_hi  	EQU $0A
.vstep_lo 	EQU $0B
.vstep_hi 	EQU $0C
.env_lo   	EQU $0D
.env_hi   	EQU $0E
.nd_lo    	EQU $0F
.nd_hi    	EQU $10
.flags    	EQU $11

	SLOT 3
	PAGE 4
	ORG $C000

	include "code_4/C000-C03A__ay_entry.asm"
	include "data_4/C03B-C091__channel_state.asm"
	include "code_4/C092-C332__ay_core.asm"
	include "data_4/C333-C369__chan_regs.asm"
	include "code_4/C36A-C506__ay_notes.asm"
	include "code_4/C507-C563__envelope.asm"
	include "code_4/C564-C5C5__ay_output.asm"
	include "data_4/C5C6-CF9F__song_data.asm"

	SLOT 3
	PAGE 0
