@ECHO OFF

del recompile\mask_3_loaded.bin
del recompile\mask_3_loaded.sna
del recompile\mask_3_loaded.tap

set ASM=..\_tools\sjasmplus.exe

cls

%ASM% --syntax=abF --nologo --msg=err mask_3_loaded.asm

echo _
echo _

pause 
tools\py_diff_bin.py original/mask_3_6000-FFFF.mem recompile/mask_3_loaded.bin

pause