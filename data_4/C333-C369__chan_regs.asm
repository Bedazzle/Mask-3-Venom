; --- chan_regs ($C333-$C369): AY_MIXER (reg-7 shadow) + per-channel AY register work sets CHANREG_A/B/C
AY_MIXER:
	DB $BF
CHANREG_A:
	DB $FE,$F7,$09
	DS 15
CHANREG_B:
	DB $FD,$EF,$12
	DS 15
CHANREG_C:
	DB $FB,$DF,$24
	DS 15
