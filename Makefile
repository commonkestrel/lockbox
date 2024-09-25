IN := ${CURDIR}

dev:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'set path=%path%;c:djgpp\bin' -C 'set djgpp=c:djgpp\djgpp.env' -C 'GCC src\main.c -o main.exe -lalleg' -C 'main.exe'

build:
	dosbox -C 'MOUNT C: $(IN)' -C 'C:' -C 'set path=%path%;c:djgpp\bin' -C 'set djgpp=c:djgpp\djgpp.env' -C 'GCC src\main.c -o main.exe -lalleg' -C 'EXIT'