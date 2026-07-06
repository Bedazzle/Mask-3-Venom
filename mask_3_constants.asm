	;DEFINE WATERPROOF	; no drowning
	;DEFINE DESERT		; no enemies
	;DEFINE INFINIAMMO	; infinite ammo
	;DEFINE SAFEROTATOR	; rotator do not kill
	;DEFINE SAFESOME	; some infinite energy
	
	;DEFINE FIXENDGAME	; bugfix for ugly panel after game end

SCREEN		EQU $4000	; 16384
SCREEN_LEN	EQU $1B00	; 6912
LEN_SCR		EQU $1800	; 6144
ATTRIB		EQU $5800	; 22528

COLOR
.BRIGHT		EQU %01000000
.FLASH		EQU %10000000
.BLACK 		EQU 00o
.BLUE 		EQU 01o
.RED 		EQU 02o
.MAGENTA	EQU 03o
.GREEN 		EQU 04o
.SKYBLUE	EQU 05o
.YELLOW		EQU 06o
.WHITE 		EQU 07o

PAPER
.BLACK		EQU 00o
.BLUE		EQU 10o
.RED		EQU 20o
.MAGENTA	EQU 30o
.GREEN		EQU 40o
.SKYBLUE	EQU 50o
.YELLOW		EQU 60o
.WHITE		EQU 70o


; +0: displacement from third part of screen
;   $61=$20*$03 + $01 = 97=32*3 + 1
; +1: index from WEAPONS (0-10)
; +2: amount
; +3: weapon power = bullet hit points (penetration)
SLOT
.XPOS	EQU $00
.WEAPON	EQU $01
.LOAD 	EQU $02
.POWER		EQU $03	; weapon power = bullet hit points (penetration)
 

BOX
.Y			EQU $00
.X			EQU $01
.TYPE		EQU $02
.BUFF_LO	EQU $03		; address in F0C0 buffer
.BUFF_HI	EQU $04
.LO			EQU $05
.HI			EQU $06
.TILE		EQU $07		; base tile code for the box glyphs

WEAPON
.Empty		EQU $00
.Penetrator	EQU $01
.UltraFlash	EQU $02	; not used
.Mirage		EQU $03	; not used
.Healer		EQU $04
.Jackrabbit	EQU $05
.Lifter		EQU $06
.Blaster	EQU $07
.Backlash	EQU $08
.LavaShot	EQU $09	; not used
.Streamer	EQU $0A	; not used

; 38-byte actor record, shared by aliens (ALIEN.1..6) and the player/objects (LA43F..).
; Dispatched by alien_vectors on (state & $3F). See templates in alien_templates.
ALIEN_LEN	EQU $26		; 38 - record stride

ALIEN
.state		EQU $00		; behaviour vector (bits0-5 index alien_vectors; $80=spawn, $40=alive)
._01		EQU $01		; reserved (not used by actors)
.facing		EQU $02		; bit7 = facing left (mirror sprite)
.x		EQU $03		; x pixel coordinate
.y		EQU $04		; y pixel coordinate
.width		EQU $05		; sprite width in cells (-1); outer loop = $05+1 columns
.height		EQU $06		; sprite height in cells (-1); inner loop = $06+1 rows
.col_cnt	EQU $07		; scratch: column loop counter during draw (=$05+1)
.row_cnt	EQU $08		; scratch: row loop counter during draw (=$06+1)
.buf_lo		EQU $09		; render graphics-buffer ptr lo
.buf_hi		EQU $0A		; ... hi
.attr		EQU $0B		; colour/attribute captured at draw time
.spr_lo		EQU $0C		; current frame graphics ptr lo
.spr_hi		EQU $0D		; ... hi
.map_lo		EQU $0E		; playfield/map ptr lo (=LA2CB in A56F)
.map_hi		EQU $0F		; ... hi
.timer		EQU $10		; action countdown; changes state at 0
.param1		EQU $11		; multipurpose word lo (velocity/aim, cell ptr, saved x)
.param2		EQU $12		; multipurpose word hi (velocity/aim, cell ptr, saved y)
.draw_x		EQU $13		; signed horiz draw offset; bit7 gates fall/jump/fly
.score_lo	EQU $14		; score awarded when killed (lo)
.score_hi	EQU $15		; ... hi
.base_lo	EQU $16		; sprite/anim base ptr lo
.base_hi	EQU $17		; sprite/anim base ptr hi (type id, polled externally)
.anim		EQU $18		; animation frame counter
.mode		EQU $19		; render/behaviour mode
.anim_mask	EQU $1A		; animation frame mask (AND with .anim)
.xvel		EQU $1B		; signed x velocity
.yvel		EQU $1C		; signed y velocity
.noclip		EQU $1D		; when set, alien ignores background collision
.damage		EQU $1E		; ENERGY drained from player on hit
.spawn		EQU $1F		; spawn-done flag / respawn countdown
.color		EQU $20		; sprite colour / char code ($41-$46)
.hp		EQU $21		; hit points (0 => death)
.hit		EQU $22		; hit-this-frame collision flag
.index		EQU $23		; alien index 1-6
.draw_cx	EQU $24		; scratch: draw cursor x (px)
.draw_cy	EQU $25		; scratch: draw cursor y (px)


PLAYER_X	EQU $03

; 14-byte sound descriptor (SFX_TABLE entry); fields used by the
; object-sound engine (load_sfx / sound_tick / play_sfx).
SFX
.STEP_LO	EQU $07		; pitch step added each frame
.STEP_HI	EQU $08
.CHANNEL	EQU $0A		; channel select (dead 3-channel path)
.DURATION	EQU $0B		; frames to play
.PITCH_LO	EQU $0C		; start pitch
.PITCH_HI	EQU $0D


; 5-byte record; the PARTICLES array animated by death_explosion
PARTICLE_LEN	EQU $05
PARTICLE
.ACTIVE		EQU $00		; $FF = live, $00 = dead
.X		EQU $01
.Y		EQU $02
.XVEL		EQU $03
.YVEL		EQU $04

ROTATOR_OK		EQU $1B
ROTATOR_KILL	EQU $47

; 4-byte record; up to 3 rotators located per room by find_rotators
ROTATOR_LEN	EQU $04
ROTATOR
.X		EQU $00
.Y		EQU $01
.CELL_LO	EQU $02		; playfield map cell pointer
.CELL_HI	EQU $03

CANNON_OK		EQU $12
CANNON_KILL		EQU $2B

; 12-byte per-level record (ROOMS_EXITS + level*12), pointed to by
; ROOM_EXITS_ADDR. Exit bytes hold the destination level ($FF = none).
ROOM_EXITS_LEN	EQU $0C
ROOM_EXITS
.LEFT		EQU $00		; level via the left exit
.RIGHT		EQU $01		; level via the right exit
.TRANSFER	EQU $02		; level via the transfer exit
._03		EQU $03		; unused (always $FF)
.THEME		EQU $04		; spritesheet / theme index (0-3)
.TRANSFER_DEST	EQU $05		; transfer dest: room (hi 3 bits) | x-col (lo 5)
.ALIEN_SET	EQU $06		; per-room alien-type table, indexed by room>>3

