; control-key sets: packed keyboard matrix codes (halfrow<<4 | column) for the 5
; controls in order right, left, down, up, fire - one row per scheme (Sinclair
; joystick / Cursor / user-defined). read_key tests one code.
SINCLAIR_KEYS:
	DB $40,$41,$42,$44,$43

CURSOR_KEYS:
	DB $40,$43,$44,$34,$42

DEFINED_KEYS:
	DB $70,$50,$61,$20,$21
