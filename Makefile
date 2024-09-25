IN := ${CURDIR}

dev:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'DJGPP\DJ.BAT' -C 'GCC src\main.c -o OUT\MAIN.EXE -lalleg' -C 'MAIN.EXE'