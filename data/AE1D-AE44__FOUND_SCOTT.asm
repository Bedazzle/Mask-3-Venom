; --- end-game text: 'found Scott' / 'well done' messages + score buffer
FOUND_SCOTT:
	ABYTEC 0 "YOU HAVE FOUND SCOTT......"

WELL_DONE:
	ABYTEC 0 "WELL DONE."

SCORE_BUFFER:
	DB $00,$00,$00,$00	; digits encoded as nibbles
