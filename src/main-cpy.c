#include <stdio.h>
#include <allegro.h>

#define NUM_VERTICES 8
#define NUM_FACES 6

typedef struct Vertex {
    fixed x, y, z;
} Vertex;

typedef struct Quad {
    Vertex *vtxlist;
    int v1, v2, v3, v4;
} Quad;

typedef struct Shape {
    fixed x, y, z;
    fixed rx, ry, rz;    
} Shape;

Vertex points[] = {
    /* vertices of the cube */
    /* for fixed point numbers, the high word is the integer part */
   { -32 << 16, -32 << 16, -32 << 17 },
   { -32 << 16,  32 << 16, -32 << 17 },
   {  32 << 16,  32 << 16, -32 << 17 },
   {  32 << 16, -32 << 16, -32 << 17 },
   { -32 << 16, -32 << 16,  32 << 17 },
   { -32 << 16,  32 << 16,  32 << 17 },
   {  32 << 16,  32 << 16,  32 << 17 },
   {  32 << 16, -32 << 16,  32 << 17 },
};

Quad faces[] = {
    { points, 0, 3, 2, 1 },
    { points, 4, 5, 6, 7 },
    { points, 0, 1, 5, 4 },
    { points, 2, 3, 7, 6 },
    { points, 0, 4, 7, 3 },
    { points, 1, 2, 6, 5 }
};

Shape paddle;

Vertex output_points[NUM_VERTICES];
Quad output_faces[NUM_FACES];

void init_shapes(void);
void draw_shapes(BITMAP *b);
void translate_shapes(void);
void wire(BITMAP *b, Vertex *v1, Vertex *v2);
int quad_cmp(const void *c1, const void *c2);

int main(void) {
    if (allegro_init() != 0) {
        return 1;
    }

    install_keyboard();
    install_mouse();
    install_timer();

    if (set_gfx_mode(GFX_AUTODETECT, 320, 200, 0, 0) != 0) {
        set_gfx_mode(GFX_TEXT, 0, 0, 0, 0);
        allegro_message("Cannot set graphics mode:\r\n%s\r\n", allegro_error);
        return 1;
    }

    set_palette(desktop_palette);
    // clear_to_color(screen, makecol(255, 255, 255));
    // textout_centre_ex(screen, font, "Hello, world!", SCREEN_W / 2, SCREEN_H / 2, makecol(0,0,0), -1);
    // textout_centre_ex(screen, font, ALLEGRO_VERSION_STR, SCREEN_W / 2, SCREEN_H / 2 + 20, makecol(0,0,0), -1);

    BITMAP *buffer = create_bitmap(SCREEN_W, SCREEN_H);
    set_projection_viewport(0, 0, SCREEN_W, SCREEN_H);

    init_shapes();

    for (;;) {
        clear_bitmap(buffer);

        translate_shapes();
        draw_shapes(buffer);

        vsync();
        blit(buffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);

        if (keypressed()) {
            if ((readkey() & 0xFF) == 0x01)
                break;
        }
    }

    printf("%d", fixtoi(768 << 16));
    
    return 0;
}

END_OF_MAIN()

void init_shapes(void) {
    paddle = (Shape) {  
        itofix(10), itofix(0), itofix(0),
        itofix(0), itofix(0), itofix(0),
    };
}

void draw_shapes(BITMAP *b) {
    int c;
    Quad *face = output_faces;
    Vertex *v1, *v2, *v3, *v4;

    // qsort(&output_faces, NUM_FACES, sizeof(Quad), quad_cmp);

    for (c=0; c < NUM_FACES; c++) {
        v1 = face[c].vtxlist + face[c].v1;
        v2 = face[c].vtxlist + face[c].v2;
        v3 = face[c].vtxlist + face[c].v3;
        v4 = face[c].vtxlist + face[c].v4;

        wire(b, v1, v2);
        wire(b, v2, v3);
        wire(b, v3, v4);
        wire(b, v4, v1);
    }
}

void translate_shapes(void) {
    int d;
    MATRIX matrix;
    Vertex *outp = output_points;
    Quad *outf = output_faces;

    get_transformation_matrix(&matrix, itofix(1),
        paddle.rx, paddle.ry, paddle.rz,
        paddle.x, paddle.y, paddle.z
    );

    for (d=0; d<NUM_VERTICES; d++) {
        apply_matrix(&matrix, 
            points[d].x, points[d].y, points[d].z,
            &outp[d].x, &outp[d].y, &outp[d].z
        );

        persp_project(
            outp[d].x, outp[d].y, outp[d].z,
            &outp[d].x, &outp[d].y
        );
    }

    for (d=0; d<NUM_FACES; d++) {
        outf[d] = faces[d];
        outf[d].vtxlist = outp;
    }
}

void wire(BITMAP *b, Vertex *v1, Vertex *v2) {
    int brightness = fixtoi(v1->z + v2-> z);
    int color = makecol(brightness, brightness, brightness);

    line(b, fixtoi(v1->x), fixtoi(v1->y), fixtoi(v2->x), fixtoi(v2->y), color);
}

int quad_cmp(const void *e1, const void *e2) {
    Quad *q1 = (Quad *)e1;
    Quad *q2 = (Quad *)e2;

    Vertex *vtx = faces[0].vtxlist;
    Vertex z = vtx[faces[0].v4];

    fixed d1 = q1->vtxlist[q1->v1].z + q1->vtxlist[q1->v2].z +
        q1->vtxlist[q1->v3].z + q1->vtxlist[q1->v4].z;

        
    fixed d2 = q2->vtxlist[q2->v1].z + q2->vtxlist[q2->v2].z +
        q2->vtxlist[q2->v3].z + q2->vtxlist[q2->v4].z;

    return d2;
}
