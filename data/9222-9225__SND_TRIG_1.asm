; small interrupt/sound scratch: SND_TRIG_1/SND_TRIG_2 = 128K sound-trigger flags (interrupt
; calls into copy_alien_template when set); FRAME_COUNTER = frame counter (inc per interrupt);
; BORDER_VALUE = current border/beeper port value.
SND_TRIG_1:
	DB $00
SND_TRIG_2:
	DB $FF
FRAME_COUNTER:
	DB $00
	
BORDER_VALUE:
	DB $00
