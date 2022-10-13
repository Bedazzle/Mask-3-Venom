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
; +3: ???
SLOT
.XPOS	EQU $00
.WEAPON	EQU $01
.LOAD 	EQU $02
.XXX	EQU $03
 

BOX
.Y			EQU $00
.X			EQU $01
.TYPE		EQU $02
.BUFF_LO	EQU $03		; address in F0C0 buffer
.BUFF_HI	EQU $04
.LO			EQU $05
.HI			EQU $06
._07		EQU $07

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

ALIEN
._00	EQU $00
._05	EQU $05
._06	EQU $06
._07	EQU $07
._09	EQU $09
._0A	EQU $0A
._0E	EQU $0E
._0F	EQU $0F
.COLOR	EQU $20


PLAYER_X	EQU $03

ROTATOR_OK		EQU $1B
ROTATOR_KILL	EQU $47

CANNON_OK		EQU $12
CANNON_KILL		EQU $2B

