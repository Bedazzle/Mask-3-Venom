; --- channel_state ($C03B-$C091): per-voice channel state - CHAN_A/B/C, 21 bytes each (pattern ptr, duration, ornament, flags)
CHAN_A:
	DS 21
CHAN_B:
	DB $08
	DS 20
CHAN_C:
	DB $10
	DS 20
CHAN_CMD_OFS:
	DS 24
