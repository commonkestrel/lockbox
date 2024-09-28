#include <allegro.h>
#include <stdio.h>

int main(void) {
    printf("%d\n", (signed int) ftofix(0.2));
    printf("%d\n", 32 << 16);
    printf("%d\n", (signed int) itofix(1));
}
