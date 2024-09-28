IN := ${CURDIR}

dev:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'set path=%path%;c:djgpp\bin' -C 'set djgpp=c:djgpp\djgpp.env' -C 'GCC src\main.c -o out\main.exe -lalleg' -C 'out\main.exe'

build:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'set path=%path%;c:djgpp\bin' -C 'set djgpp=c:djgpp\djgpp.env' -C 'GCC src\main.c -o out\main.exe -lalleg' -C 'EXIT'

box:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'set path=%path%;c:djgpp\bin' -C 'set djgpp=c:djgpp\djgpp.env'
