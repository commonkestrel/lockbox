#include <allegro.h>

int main(int argc, const char **argv) {
    if (allegro_init() != 0) {
        return 1;
    }

    install_keyboard();

    if (set_gfx_mode(GFX_AUTODETECT, 320, 200, 0, 0) != 0) {
        set_gfx_mode(GFX_TEXT, 0, 0, 0, 0);
        allegro_message("Cannot set graphics mode:\r\n%s\r\n", allegro_error);
        return 1;
    }

    set_palette(desktop_palette);
    clear_to_color(screen, makecol(255, 255, 255));
    textout_centre_ex(screen, font, "Hello, world!", SCREEN_W / 2, SCREEN_H / 2, makecol(0,0,0), -1);
    textout_centre_ex(screen, font, ALLEGRO_VERSION_STR, SCREEN_W / 2, SCREEN_H / 2 + 20, makecol(0,0,0), -1);

    readkey();
    
    return 0;
}
