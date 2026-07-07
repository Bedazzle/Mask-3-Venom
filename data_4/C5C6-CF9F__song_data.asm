; --- song_data ($C5C6-$CF9F): song/pattern/ornament data: SONG_PATTERNS ($CAA8), SONG_TABLE ($CC0A), patterns
; song / pattern / instrument data ($C5C6-$CF9F). Layout:
;   NOTE_PERIODS  $C5C6  85 x DW = AY tone period per chromatic note (note_to_period)
;   NOTEDATA_nn   $C670  27 instrument/note-event byte streams (via NOTEDATA_LO/HI)
;   NOTEDATA_LO/HI $CA72/$CA8D  split lo/hi pointer table -> the 27 streams
;   SONG_PATTERNS $CAA8  9 x DW (3 songs x 3 chans) -> PAT_n pattern streams
;   PAT_n         $CABA  channel pattern streams (process_channel reads these)
;   SAMPLE_DATA   $CBA2  sample/instrument bytes (note_cmd, indexed via CHAN_CMD_OFS)
;   leftover_gameloop $CC0A  NOT a song table! coherent (dead/leftover) game-loop code
; PATTERN byte grammar (process_channel): $00-$7F note ; $80-$BF set duration (&$1F) ;
;   $C0-$FD + b = set chan_cmd_ofs[&7] ; $FE b = set ornament ; $FF end.
; INSTRUMENT byte grammar (NOTEDATA, note-stream reader): $00-$7D pitch + dur byte ;
;   $7E lo hi dur = absolute AY period ; $7F dur = rest ; $80-$87 sample select ;
;   $88-$BF ornament (&$0F) ; $C0-$FE control (1 or 4 bytes) ; $FF note-off.
NOTE_PERIODS:
	DW $0EEE	; note 0
	DW $0E18
	DW $0D4D
	DW $0C8E
	DW $0BDA
	DW $0B2F
	DW $0A8F
	DW $09F7
	DW $0968
	DW $08E1
	DW $0861
	DW $07E9
	DW $0777	; note 12
	DW $070C
	DW $06A7
	DW $0647
	DW $05ED
	DW $0598
	DW $0547
	DW $04FC
	DW $04D4
	DW $0470
	DW $0431
	DW $03F4
	DW $03DC	; note 24
	DW $0386
	DW $0353
	DW $0324
	DW $02F6
	DW $02CC
	DW $02A4
	DW $027E
	DW $025A
	DW $0238
	DW $0218
	DW $01FA
	DW $01DE	; note 36
	DW $01C3
	DW $01AA
	DW $0192
	DW $017B
	DW $0166
	DW $0152
	DW $013F
	DW $012D
	DW $011C
	DW $010C
	DW $00FD
	DW $00EF	; note 48
	DW $00E1
	DW $00D5
	DW $00C9
	DW $00BE
	DW $00B3
	DW $00A9
	DW $009F
	DW $0096
	DW $008E
	DW $0086
	DW $007F
	DW $0077	; note 60
	DW $0071
	DW $006A
	DW $0064
	DW $005F
	DW $0059
	DW $0054
	DW $0050
	DW $004B
	DW $0047
	DW $0043
	DW $003F
	DW $003C	; note 72
	DW $0038
	DW $0035
	DW $0032
	DW $002F
	DW $002D
	DW $002A
	DW $0028
	DW $0026
	DW $0024
	DW $0022
	DW $0020
	DW $0018	; note 84
NOTEDATA_00:		; phrase: sample 0, 64 notes
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $15,$08	; pitch $15, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $15,$08	; pitch $15, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $1E,$08	; pitch $1E, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $15,$08	; pitch $15, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $1A,$08	; pitch $1A, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $1A,$08	; pitch $1A, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $0F,$08	; pitch $0F, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $FF	; note-off
NOTEDATA_01:		; phrase: no-sample rest, 0 notes
	DB $7F,$80	; rest, dur $80
	DB $FF	; note-off
NOTEDATA_02:		; phrase: sample 0/2, 64 notes
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $1C,$08	; pitch $1C, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $1E,$08	; pitch $1E, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $1C,$08	; pitch $1C, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $1A,$08	; pitch $1A, dur $08
	DB $0E,$08	; pitch $0E, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $0E,$08	; pitch $0E, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $0B,$08	; pitch $0B, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $0F,$08	; pitch $0F, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $FF	; note-off
NOTEDATA_03:		; phrase: sample 1, 4 notes
	DB $81	; sample 1
	DB $2A,$04	; pitch $2A, dur $04
	DB $2D,$04	; pitch $2D, dur $04
	DB $31,$04	; pitch $31, dur $04
	DB $36,$04	; pitch $36, dur $04
	DB $FF	; note-off
NOTEDATA_04:		; phrase: sample 1, 4 notes
	DB $81	; sample 1
	DB $2A,$04	; pitch $2A, dur $04
	DB $2D,$04	; pitch $2D, dur $04
	DB $32,$04	; pitch $32, dur $04
	DB $36,$04	; pitch $36, dur $04
	DB $FF	; note-off
NOTEDATA_05:		; phrase: sample 1, 4 notes
	DB $81	; sample 1
	DB $2A,$04	; pitch $2A, dur $04
	DB $2F,$04	; pitch $2F, dur $04
	DB $32,$04	; pitch $32, dur $04
	DB $36,$04	; pitch $36, dur $04
	DB $FF	; note-off
NOTEDATA_06:		; phrase: no-sample rest, 0 notes
	DB $7F,$02	; rest, dur $02
	DB $FF	; note-off
NOTEDATA_07:		; phrase: sample 6, 8 notes
	DB $86	; sample 6
	DB $31,$80	; pitch $31, dur $80
	DB $34,$80	; pitch $34, dur $80
	DB $2F,$80	; pitch $2F, dur $80
	DB $36,$80	; pitch $36, dur $80
	DB $39,$80	; pitch $39, dur $80
	DB $3D,$80	; pitch $3D, dur $80
	DB $3B,$80	; pitch $3B, dur $80
	DB $39,$80	; pitch $39, dur $80
	DB $FF	; note-off
NOTEDATA_08:		; phrase: sample 0, 8 notes
	DB $90	; ornament $00
	DB $80	; sample 0
	DB $0D,$08	; pitch $0D, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $FF	; note-off
NOTEDATA_09:		; phrase: sample 3, 11 notes
	DB $83	; sample 3
	DB $1C,$38	; pitch $1C, dur $38
	DB $1B,$10	; pitch $1B, dur $10
	DB $1C,$10	; pitch $1C, dur $10
	DB $7F,$20	; rest, dur $20
	DB $1C,$08	; pitch $1C, dur $08
	DB $1C,$28	; pitch $1C, dur $28
	DB $1C,$08	; pitch $1C, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $1D,$30	; pitch $1D, dur $30
	DB $1E,$08	; pitch $1E, dur $08
	DB $20,$08	; pitch $20, dur $08
	DB $1E,$08	; pitch $1E, dur $08
	DB $FF	; note-off
NOTEDATA_10:		; phrase: sample 4, 28 notes
	DB $84	; sample 4
	DB $C1,$01,$01,$FF	; ctrl $C1 +3
	DB $1B,$08	; pitch $1B, dur $08
	DB $1B,$10	; pitch $1B, dur $10
	DB $17,$10	; pitch $17, dur $10
	DB $17,$10	; pitch $17, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $1B,$08	; pitch $1B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $1B,$10	; pitch $1B, dur $10
	DB $17,$10	; pitch $17, dur $10
	DB $17,$10	; pitch $17, dur $10
	DB $17,$08	; pitch $17, dur $08
	DB $1B,$04	; pitch $1B, dur $04
	DB $1B,$04	; pitch $1B, dur $04
	DB $1B,$08	; pitch $1B, dur $08
	DB $17,$04	; pitch $17, dur $04
	DB $17,$04	; pitch $17, dur $04
	DB $17,$08	; pitch $17, dur $08
	DB $14,$04	; pitch $14, dur $04
	DB $14,$04	; pitch $14, dur $04
	DB $14,$08	; pitch $14, dur $08
	DB $11,$04	; pitch $11, dur $04
	DB $11,$04	; pitch $11, dur $04
	DB $11,$06	; pitch $11, dur $06
	DB $C2	; ctrl $C2
	DB $FF	; note-off
NOTEDATA_11:		; phrase: sample 3, 17 notes
	DB $83	; sample 3
	DB $30,$08	; pitch $30, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$18	; pitch $2A, dur $18
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$18	; pitch $2A, dur $18
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$10	; pitch $2A, dur $10
	DB $2A,$08	; pitch $2A, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $30,$08	; pitch $30, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$18	; pitch $2A, dur $18
	DB $28,$08	; pitch $28, dur $08
	DB $2A,$48	; pitch $2A, dur $48
	DB $FF	; note-off
NOTEDATA_12:		; phrase: no-sample rest, 19 notes
	DB $30,$08	; pitch $30, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $31,$10	; pitch $31, dur $10
	DB $30,$10	; pitch $30, dur $10
	DB $2F,$18	; pitch $2F, dur $18
	DB $2F,$08	; pitch $2F, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $28,$08	; pitch $28, dur $08
	DB $30,$08	; pitch $30, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $31,$10	; pitch $31, dur $10
	DB $2F,$08	; pitch $2F, dur $08
	DB $2D,$08	; pitch $2D, dur $08
	DB $2A,$48	; pitch $2A, dur $48
	DB $FF	; note-off
NOTEDATA_13:		; phrase: sample 0/2, 21 notes
	DB $80	; sample 0
	DB $10,$10	; pitch $10, dur $10
	DB $1C,$10	; pitch $1C, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $1A,$08	; pitch $1A, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $0B,$18	; pitch $0B, dur $18
	DB $17,$10	; pitch $17, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $0E,$08	; pitch $0E, dur $08
	DB $0F,$08	; pitch $0F, dur $08
	DB $10,$18	; pitch $10, dur $18
	DB $1C,$10	; pitch $1C, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $1A,$08	; pitch $1A, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $0B,$18	; pitch $0B, dur $18
	DB $17,$10	; pitch $17, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $0F,$08	; pitch $0F, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $FF	; note-off
NOTEDATA_14:		; phrase: sample 3, 17 notes
	DB $83	; sample 3
	DB $2C,$20	; pitch $2C, dur $20
	DB $2C,$08	; pitch $2C, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $28,$08	; pitch $28, dur $08
	DB $2A,$28	; pitch $2A, dur $28
	DB $27,$08	; pitch $27, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $23,$20	; pitch $23, dur $20
	DB $2C,$10	; pitch $2C, dur $10
	DB $2C,$08	; pitch $2C, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $28,$08	; pitch $28, dur $08
	DB $2A,$28	; pitch $2A, dur $28
	DB $27,$08	; pitch $27, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $23,$08	; pitch $23, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $FF	; note-off
NOTEDATA_15:		; phrase: sample 5, 16 notes
	DB $85	; sample 5
	DB $91	; ornament $01
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $92	; ornament $02
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $2F,$08	; pitch $2F, dur $08
	DB $90	; ornament $00
	DB $FF	; note-off
NOTEDATA_16:		; phrase: sample 4, 15 notes
	DB $84	; sample 4
	DB $C1,$01,$01,$FF	; ctrl $C1 +3
	DB $14,$08	; pitch $14, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $7F,$38	; rest, dur $38
	DB $1B,$10	; pitch $1B, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $17,$10	; pitch $17, dur $10
	DB $17,$08	; pitch $17, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $7F,$38	; rest, dur $38
	DB $1B,$08	; pitch $1B, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $1B,$08	; pitch $1B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $14,$08	; pitch $14, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $17,$06	; pitch $17, dur $06
	DB $C2	; ctrl $C2
	DB $FF	; note-off
NOTEDATA_17:		; phrase: sample 1, 4 notes
	DB $81	; sample 1
	DB $36,$04	; pitch $36, dur $04
	DB $34,$04	; pitch $34, dur $04
	DB $31,$04	; pitch $31, dur $04
	DB $2F,$04	; pitch $2F, dur $04
	DB $FF	; note-off
NOTEDATA_18:		; phrase: sample 0/2, 8 notes
	DB $80	; sample 0
	DB $0D,$08	; pitch $0D, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $19,$08	; pitch $19, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $19,$08	; pitch $19, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $FF	; note-off
NOTEDATA_19:		; phrase: sample 0/2, 8 notes
	DB $80	; sample 0
	DB $06,$08	; pitch $06, dur $08
	DB $06,$08	; pitch $06, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $04,$08	; pitch $04, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $05,$08	; pitch $05, dur $08
	DB $FF	; note-off
NOTEDATA_20:		; phrase: sample 3, 2 notes
	DB $83	; sample 3
	DB $39,$20	; pitch $39, dur $20
	DB $38,$20	; pitch $38, dur $20
	DB $93	; ornament $03
	DB $FF	; note-off
NOTEDATA_21:		; phrase: sample 4, 5 notes
	DB $84	; sample 4
	DB $C1,$01,$01,$FF	; ctrl $C1 +3
	DB $1E,$08	; pitch $1E, dur $08
	DB $1E,$10	; pitch $1E, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $17,$08	; pitch $17, dur $08
	DB $FF	; note-off
NOTEDATA_22:		; phrase: sample 5, 49 notes
	DB $85	; sample 5
	DB $2A,$08	; pitch $2A, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $3A,$08	; pitch $3A, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $29,$08	; pitch $29, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $35,$08	; pitch $35, dur $08
	DB $38,$08	; pitch $38, dur $08
	DB $35,$08	; pitch $35, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $27,$08	; pitch $27, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $30,$08	; pitch $30, dur $08
	DB $33,$08	; pitch $33, dur $08
	DB $38,$08	; pitch $38, dur $08
	DB $33,$08	; pitch $33, dur $08
	DB $30,$08	; pitch $30, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $27,$08	; pitch $27, dur $08
	DB $2B,$08	; pitch $2B, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $33,$08	; pitch $33, dur $08
	DB $37,$08	; pitch $37, dur $08
	DB $33,$08	; pitch $33, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $2B,$08	; pitch $2B, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $3A,$08	; pitch $3A, dur $08
	DB $36,$08	; pitch $36, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $29,$08	; pitch $29, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $35,$08	; pitch $35, dur $08
	DB $38,$08	; pitch $38, dur $08
	DB $35,$08	; pitch $35, dur $08
	DB $31,$08	; pitch $31, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $27,$80	; pitch $27, dur $80
	DB $7F,$04	; rest, dur $04
	DB $FF	; note-off
NOTEDATA_23:		; phrase: sample 0/2, 31 notes
	DB $80	; sample 0
	DB $12,$10	; pitch $12, dur $10
	DB $12,$10	; pitch $12, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $0D,$18	; pitch $0D, dur $18
	DB $0D,$10	; pitch $0D, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $11,$08	; pitch $11, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $14,$18	; pitch $14, dur $18
	DB $14,$10	; pitch $14, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $14,$08	; pitch $14, dur $08
	DB $13,$08	; pitch $13, dur $08
	DB $0F,$18	; pitch $0F, dur $18
	DB $0F,$10	; pitch $0F, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $0F,$08	; pitch $0F, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $12,$18	; pitch $12, dur $18
	DB $12,$10	; pitch $12, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $12,$08	; pitch $12, dur $08
	DB $11,$08	; pitch $11, dur $08
	DB $0D,$18	; pitch $0D, dur $18
	DB $0D,$10	; pitch $0D, dur $10
	DB $82	; sample 2
	DB $1E,$08	; pitch $1E, dur $08
	DB $80	; sample 0
	DB $11,$08	; pitch $11, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $14,$80	; pitch $14, dur $80
	DB $7F,$04	; rest, dur $04
	DB $FF	; note-off
NOTEDATA_24:		; phrase: sample 3, 25 notes
	DB $83	; sample 3
	DB $2E,$20	; pitch $2E, dur $20
	DB $2E,$08	; pitch $2E, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $2C,$28	; pitch $2C, dur $28
	DB $29,$08	; pitch $29, dur $08
	DB $27,$08	; pitch $27, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $24,$28	; pitch $24, dur $28
	DB $24,$08	; pitch $24, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $27,$08	; pitch $27, dur $08
	DB $27,$28	; pitch $27, dur $28
	DB $2B,$08	; pitch $2B, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $2E,$08	; pitch $2E, dur $08
	DB $2E,$28	; pitch $2E, dur $28
	DB $2E,$08	; pitch $2E, dur $08
	DB $2C,$08	; pitch $2C, dur $08
	DB $2A,$08	; pitch $2A, dur $08
	DB $2C,$28	; pitch $2C, dur $28
	DB $29,$08	; pitch $29, dur $08
	DB $27,$08	; pitch $27, dur $08
	DB $25,$08	; pitch $25, dur $08
	DB $24,$80	; pitch $24, dur $80
	DB $7F,$04	; rest, dur $04
	DB $FF	; note-off
NOTEDATA_25:		; phrase: sample 4, 7 notes
	DB $84	; sample 4
	DB $1E,$08	; pitch $1E, dur $08
	DB $1E,$10	; pitch $1E, dur $10
	DB $1B,$10	; pitch $1B, dur $10
	DB $1B,$08	; pitch $1B, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $17,$08	; pitch $17, dur $08
	DB $14,$80	; pitch $14, dur $80
	DB $7F,$04	; rest, dur $04
	DB $FF	; note-off
NOTEDATA_26:		; phrase: sample 0, 9 notes
	DB $80	; sample 0
	DB $06,$08	; pitch $06, dur $08
	DB $06,$08	; pitch $06, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $06,$08	; pitch $06, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $0D,$08	; pitch $0D, dur $08
	DB $10,$08	; pitch $10, dur $08
	DB $12,$08	; pitch $12, dur $08
	DB $06,$80	; pitch $06, dur $80
	DB $7F,$04	; rest, dur $04
	DB $FF	; note-off
NOTEDATA_LO:
	DB low(NOTEDATA_00),low(NOTEDATA_01),low(NOTEDATA_02),low(NOTEDATA_03),low(NOTEDATA_04),low(NOTEDATA_05),low(NOTEDATA_06),low(NOTEDATA_07),low(NOTEDATA_08)
	DB low(NOTEDATA_09),low(NOTEDATA_10),low(NOTEDATA_11),low(NOTEDATA_12),low(NOTEDATA_13),low(NOTEDATA_14),low(NOTEDATA_15),low(NOTEDATA_16),low(NOTEDATA_17)
	DB low(NOTEDATA_18),low(NOTEDATA_19),low(NOTEDATA_20),low(NOTEDATA_21),low(NOTEDATA_22),low(NOTEDATA_23),low(NOTEDATA_24),low(NOTEDATA_25),low(NOTEDATA_26)
NOTEDATA_HI:
	DB high(NOTEDATA_00),high(NOTEDATA_01),high(NOTEDATA_02),high(NOTEDATA_03),high(NOTEDATA_04),high(NOTEDATA_05),high(NOTEDATA_06),high(NOTEDATA_07),high(NOTEDATA_08)
	DB high(NOTEDATA_09),high(NOTEDATA_10),high(NOTEDATA_11),high(NOTEDATA_12),high(NOTEDATA_13),high(NOTEDATA_14),high(NOTEDATA_15),high(NOTEDATA_16),high(NOTEDATA_17)
	DB high(NOTEDATA_18),high(NOTEDATA_19),high(NOTEDATA_20),high(NOTEDATA_21),high(NOTEDATA_22),high(NOTEDATA_23),high(NOTEDATA_24),high(NOTEDATA_25),high(NOTEDATA_26)
SONG_PATTERNS:
	DW PAT_S0A,PAT_S0B,PAT_S0C	; song 0 (A,B,C)
	DW PAT_S1A,PAT_S1B,PAT_S1C	; song 1 (A,B,C)
	DW PAT_S2A,PAT_S2B,PAT_S2C	; song 2 (A,B,C)
PAT_S0A:
	DB $FE,$F4	; set ornament $F4
	DB $82	; dur 2
	DB $00	; note $00
	DB $84	; dur 4
	DB $08	; note $08
	DB $82	; dur 2
	DB $02	; note $02
	DB $0D	; note $0D
	DB $82	; dur 2
	DB $02	; note $02
	DB $0D	; note $0D
	DB $FE,$F6	; set ornament $F6
	DB $0D	; note $0D
	DB $FE,$FB	; set ornament $FB
	DB $88	; dur 8
	DB $08	; note $08
	DB $84	; dur 4
	DB $08	; note $08
	DB $FE,$F9	; set ornament $F9
	DB $08	; note $08
	DB $08	; note $08
	DB $FE,$F7	; set ornament $F7
	DB $08	; note $08
	DB $08	; note $08
	DB $FE,$FB	; set ornament $FB
	DB $84	; dur 4
	DB $08	; note $08
	DB $FE,$F9	; set ornament $F9
	DB $08	; note $08
	DB $08	; note $08
	DB $FE,$F7	; set ornament $F7
	DB $08	; note $08
	DB $08	; note $08
	DB $FE,$FB	; set ornament $FB
	DB $84	; dur 4
	DB $12	; note $12
	DB $FE,$F9	; set ornament $F9
	DB $12	; note $12
	DB $12	; note $12
	DB $FE,$F7	; set ornament $F7
	DB $12	; note $12
	DB $12	; note $12
	DB $FE,$FB	; set ornament $FB
	DB $84	; dur 4
	DB $12	; note $12
	DB $FE,$F9	; set ornament $F9
	DB $12	; note $12
	DB $12	; note $12
	DB $FE,$F7	; set ornament $F7
	DB $12	; note $12
	DB $12	; note $12
	DB $FE,$F6	; set ornament $F6
	DB $13	; note $13
	DB $02	; note $02
	DB $02	; note $02
	DB $0D	; note $0D
	DB $FE,$FB	; set ornament $FB
	DB $90	; dur 16
	DB $08	; note $08
	DB $FF	; end
PAT_S0B:
	DB $C0,$46	; chan_cmd_ofs[0] = $46
	DB $FE,$F4	; set ornament $F4
	DB $00	; note $00
	DB $06	; note $06
	DB $FE,$03	; set ornament $03
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $0A	; note $0A
	DB $FE,$F4	; set ornament $F4
	DB $0B	; note $0B
	DB $0B	; note $0B
	DB $0C	; note $0C
	DB $0C	; note $0C
	DB $0E	; note $0E
	DB $FE,$00	; set ornament $00
	DB $0B	; note $0B
	DB $0B	; note $0B
	DB $0C	; note $0C
	DB $0C	; note $0C
	DB $0E	; note $0E
	DB $FE,$02	; set ornament $02
	DB $0E	; note $0E
	DB $FE,$FB	; set ornament $FB
	DB $88	; dur 8
	DB $08	; note $08
	DB $FE,$02	; set ornament $02
	DB $07	; note $07
	DB $07	; note $07
	DB $14	; note $14
	DB $0B	; note $0B
	DB $0B	; note $0B
	DB $0C	; note $0C
	DB $0C	; note $0C
	DB $0E	; note $0E
	DB $FE,$FB	; set ornament $FB
	DB $90	; dur 16
	DB $08	; note $08
	DB $FF	; end
PAT_S0C:
	DB $FE,$03	; set ornament $03
	DB $84	; dur 4
	DB $01	; note $01
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $0A	; note $0A
	DB $06	; note $06
	DB $FE,$00	; set ornament $00
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $0F	; note $0F
	DB $0F	; note $0F
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $0F	; note $0F
	DB $0F	; note $0F
	DB $FE,$02	; set ornament $02
	DB $0F	; note $0F
	DB $0F	; note $0F
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $90	; dur 16
	DB $11	; note $11
	DB $15	; note $15
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $98	; dur 24
	DB $03	; note $03
	DB $84	; dur 4
	DB $04	; note $04
	DB $84	; dur 4
	DB $05	; note $05
	DB $0F	; note $0F
	DB $0F	; note $0F
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $10	; note $10
	DB $06	; note $06
	DB $FF	; end
PAT_S1A:
	DB $FE,$0C	; set ornament $0C
	DB $16	; note $16
	DB $FF	; end
PAT_S1B:
	DB $FE,$F4	; set ornament $F4
	DB $17	; note $17
	DB $FF	; end
PAT_S1C:
	DB $18	; note $18
	DB $FF	; end
PAT_S2A:
	DB $06	; note $06
	DB $19	; note $19
	DB $FF	; end
PAT_S2B:
	DB $FE,$FB	; set ornament $FB
	DB $1A	; note $1A
	DB $FF	; end
PAT_S2C:
	DB $19	; note $19
	DB $FF	; end
SAMPLE_DATA:
	DB $35,$FD,$01,$FF,$7F,$00,$05,$05,$00,$01,$7F,$DF,$01,$FF,$72,$00
	DB $00,$00,$00,$03,$7F,$FA,$01,$FF,$7F,$00,$00,$75,$00,$03,$25,$FE
	DB $01,$FF,$7F,$00,$04,$01,$00,$01,$7F,$FC,$02,$FF,$7F,$00,$00,$1A
	DB $00,$01,$7F,$FB,$03,$FF,$73,$00,$01,$01,$00,$01,$02,$FF,$01,$FF
	DB $7F,$00,$04,$01,$00,$01,$35,$FD,$01,$FF,$7F,$00,$86,$05,$00,$01
	DB $8A,$29,$49
	DS 5
	DB $8A,$21,$39
	DS 5
	DB $89,$61
	DS 6
; --- leftover_gameloop ($CC0A-$CC5B): NOT a song table - a coherent per-frame
;     game-loop routine (calls the main-game update routines by absolute address +
;     a BCD counter at $CC5C). Reached ONLY via the UNUSED ay_init_song entry, so it
;     is dead/leftover in the venom2 tape block. Disassembled for reference.
leftover_gameloop:
	nop
	cp l
	call tick_hazards
	call $C284
	call fire_weapon
	call select_weapon_slot
	call print_score
	ld a, (DROWNING)
	and a
	jp nz, lose_life
	ld a, (ENERGY)
	and a
	jr nz, $CC41
	ld a, (PLAYER)
	cp $09
	jr z, $CC41
	ld a, $09
	ld (PLAYER), a
	ld a, $32
	ld (PLAYER_FRAME_COUNT), a
	ld a, $01
	ld (DISSOLVE), a
	ld (INPUT_LOCK), a
	call draw_energy
	call show_weapon_slot
	call $CACD
	call draw_all_actors
	ld hl, SLOT.BLINK
	inc (hl)
	ld hl, $CC5C
	ld a, (hl)
	add a, $01
	daa
	ld (hl), a
	jp $CC03

; trailing data: BCD frame/score counter ($CC5C) + zero buffers + byte tables
	DS 36
	DB $01,$02,$02,$01,$00,$01,$01,$00,$80,$C0,$40,$80,$00,$80,$80,$00
	DB $04,$34,$00,$4F,$4F,$00,$27,$00,$E0,$EC,$00,$FE,$FE,$00,$FC
	DS 6
	DB $1F,$1F
	DS 6
	DB $80,$80,$00,$27,$27,$00,$4F,$4F,$00,$30,$00,$C0,$D4,$00,$FE,$FE
	DB $00,$0C,$00,$00,$01,$03,$01,$01,$10,$3C,$7C,$80,$C0,$E0,$C0,$C0
	DB $04,$1E,$1F,$3C,$10,$01,$01,$03,$01,$00,$00,$1E,$04,$C0,$C0,$E0
	DB $C0,$80,$00,$00,$00,$00,$7F,$7F,$7F,$00,$7F,$00,$00,$00,$FE,$C6
	DB $FE,$00,$FE,$49,$7F,$64,$7F,$49,$7F,$00,$00,$26,$FC,$9A,$F4,$2A
	DB $D6,$00,$00,$00,$01,$03,$00,$01,$10,$35,$75,$80,$C0,$E0,$00,$C0
	DB $04,$D6,$D7,$35,$10,$01,$00,$03,$01,$00,$00,$D6,$04,$C0,$00,$E0
	DB $C0,$80,$00,$00,$7F,$3F,$00,$1C,$00,$08,$08,$00,$FE,$FC,$00,$38
	DB $00,$10,$10,$08,$08,$00,$1C,$00,$3F,$7F,$00,$10,$10,$00,$38,$00
	DB $FC,$FE,$00,$00,$3F,$30,$20,$20,$20,$20,$20,$00,$FC,$0C,$34,$14
	DB $04,$14,$04,$30,$3F,$00,$3F,$2F,$3F,$00,$18,$0C,$FC,$00,$FC,$54
	DB $FC,$00,$18
	DS 8
	DB $01,$00,$05,$05,$01,$01,$01,$05,$05,$00,$01,$01
	DS 7
	DB $01,$01,$01
	DS 5
	DB $81,$03,$87,$87,$07,$C7,$18,$C7,$C8,$DD,$DE,$DE,$CE,$CF,$07,$D7
	DB $DB,$1C,$0F,$0F,$07,$07,$1E,$3D,$BE,$D8,$C1,$EF,$E7,$00,$00,$00
	DB $E0,$F8,$80,$AC,$80,$C8,$C8,$48,$98,$40,$A0,$C0,$C0,$10,$A8,$B8
	DB $B0,$00,$00,$80,$80,$40,$C0,$80,$00,$00,$C0,$E0,$E0
	DS 38
	DB $01,$00,$05,$05,$01,$01,$01,$05,$05,$00,$01,$01
	DS 8
	DB $01,$01,$02,$07,$07,$01,$00,$81,$03,$87,$87,$07,$C7,$18,$C7,$C8
	DB $DD,$DD,$DD,$DD,$BC,$3E,$BE,$DE,$01,$1F,$0F,$23,$38,$7C,$78,$F0
	DB $F0,$E1,$C1,$00,$E0,$E0,$00,$E0,$F8,$00,$5C,$00,$88,$88,$08,$98
	DB $40,$A0,$C0,$80,$40,$A0,$E0,$C0,$00,$D0,$D8,$D8,$60,$78,$F0,$70
	DB $80,$E0,$F8,$78
	DS 39
	DB $01,$00,$05,$05,$01,$01,$01,$05,$04
	DS 5
	DB $37,$37,$77,$6F,$60,$60
	DS 7
	DB $81,$03,$86,$86,$06,$C7,$18,$C7,$D8,$BD,$BB,$7B,$77,$F2,$F9,$FA
	DB $7B,$1B,$20,$37,$FB,$F8,$F0,$F0
	DS 8
	DB $E0,$F8,$00,$BC,$00,$08,$08,$08,$98,$40,$A0,$C0,$C0,$D0,$28,$B8
	DB $B0,$00,$E0,$D8,$D8,$EC,$30,$3E,$1E,$1F,$0E,$01,$07,$07
	DS 28
	DB $60,$E0,$C0
	DS 9
	DB $01,$00,$05,$05,$01,$01,$01,$04,$04,$00,$01,$01
	DS 5
	DB $06,$0D,$0D,$0D,$0C,$0C,$00,$00,$00,$00,$81,$03,$84,$85,$04,$C6
	DB $18,$C7,$D0,$BB,$7B,$77,$F7,$F7,$F9,$72,$B5,$17,$06,$09,$07,$0B
	DB $FD,$FE,$FE,$FE
	DS 6
	DB $E0,$F8,$00,$7C,$00,$08,$08,$08,$98,$40,$A0,$C0,$C8,$D4,$9C,$18
	DB $00,$00,$80,$80,$60,$60,$B0,$C0,$F0,$F8,$78,$70,$0F,$7F,$3C
	DS 40
	DB $01,$00,$05,$05,$01,$01,$01,$05,$05,$00,$01,$01
	DS 7
	DB $01,$01,$01
	DS 5
	DB $81,$03,$86,$86,$06,$C7,$18,$C7,$C8,$DD,$DD,$BB,$BB,$77,$71,$7A
	DB $B5,$17,$06,$19,$0E,$06,$05,$35,$B4,$D7,$C8,$EF,$E7
