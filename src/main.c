/*
*     Example program for the Allegro library, by Shawn Hargreaves.
*
*     This program demonstrates how to use the 3d matrix functions.
*     It isn't a very elegant or efficient piece of code, but it
*     does show the stuff in action. It is left to the reader as
*     an exercise to design a proper model structure and rendering
*     pipeline: after all, the best way to do that sort of stuff
*     varies hugely from one game to another.
*
*     The example first shows a screen resolution selection dialog.
*     Then, a number of bouncing 3d cubes are animated. Pressing
*     a key modifies the rendering of the cubes, which can be
*     wireframe, the more complex transparent perspective correct
*     texture mapped version, and many other.
*/


#include <allegro.h>
#include <stdbool.h>
#include <stdlib.h>

#define NUM_VERTICES         8      /* a cube has eight corners */
#define NUM_FACES            6      /* a cube has six faces */
#define NUM_SHAPES           3      /* the paddles and the cube */

#define LEFT_PADDLE 0
#define RIGHT_PADDLE 1
#define CUBE 2

#define FIXED_1 (1 << 16)

typedef struct VTX
{
    fixed x, y, z;
} VTX;


typedef struct Quad                  /* four vertices makes a quad */
{
    VTX *vtxlist;
    int v1, v2, v3, v4;
} Quad;


typedef struct  Shape                 /* store position of a shape */
{
    Quad *quads;
    fixed x, y, z;                     /* x, y, z position */
    fixed rx, ry, rz;                 /* rotations */
    fixed dy, dx;                            /* speed of movement */
    fixed drx, dry, drz;             /* speed of rotation */
}  Shape;


VTX points[] =                         /* a cube, centered on the origin */
{
    /* vertices of the paddle */
    { -6*FIXED_1, -32*FIXED_1, -16*FIXED_1 },
    { -6*FIXED_1,  32*FIXED_1, -16*FIXED_1 },
    {  6*FIXED_1,  32*FIXED_1, -16*FIXED_1 },
    {  6*FIXED_1, -32*FIXED_1, -16*FIXED_1 },
    { -6*FIXED_1, -32*FIXED_1,  16*FIXED_1 },
    { -6*FIXED_1,  32*FIXED_1,  16*FIXED_1 },
    {  6*FIXED_1,  32*FIXED_1,  16*FIXED_1 },
    {  6*FIXED_1, -32*FIXED_1,  16*FIXED_1 },
    
    /* vertices of the cube */
    { -6*FIXED_1, -6*FIXED_1, -6*FIXED_1 },
    { -6*FIXED_1,  6*FIXED_1, -6*FIXED_1 },
    {  6*FIXED_1,  6*FIXED_1, -6*FIXED_1 },
    {  6*FIXED_1, -6*FIXED_1, -6*FIXED_1 },
    { -6*FIXED_1, -6*FIXED_1,  6*FIXED_1 },
    { -6*FIXED_1,  6*FIXED_1,  6*FIXED_1 },
    {  6*FIXED_1,  6*FIXED_1,  6*FIXED_1 },
    {  6*FIXED_1, -6*FIXED_1,  6*FIXED_1 },
};


Quad paddle_faces[] = { /* group the vertices into polygons */
    { points, 0, 3, 2, 1 },
    { points, 4, 5, 6, 7 },
    { points, 0, 1, 5, 4 },
    { points, 2, 3, 7, 6 },
    { points, 0, 4, 7, 3 },
    { points, 1, 2, 6, 5 }
};

Quad cube_faces[] = {
    { points,  8, 11, 10,  9 },
    { points, 12, 13, 14, 15 },
    { points,  8,  9, 13, 12 },
    { points, 10, 11, 15, 14 },
    { points,  8, 12, 15, 11 },
    { points,  9, 10, 14, 13 }
};

Shape shapes[NUM_SHAPES];          /* a list of shapes */

/* somewhere to put translated vertices */
VTX output_points[NUM_VERTICES * 2 * NUM_SHAPES];
Quad output_faces[NUM_FACES * NUM_SHAPES];
BITMAP *texture;

/* initialise shape positions */
void init_shapes(void)
{
    int c;

    /* Left paddle */
    shapes[LEFT_PADDLE].quads = paddle_faces;
    shapes[LEFT_PADDLE].x = itofix(-164);
    shapes[LEFT_PADDLE].y = itofix(0);
    shapes[LEFT_PADDLE].z = 192 << 16;
    shapes[LEFT_PADDLE].rx = 0;
    shapes[LEFT_PADDLE].ry = 0;
    shapes[LEFT_PADDLE].rz = 0;
    shapes[LEFT_PADDLE].dy = ((AL_RAND() & 255) - 8) << 12;
    shapes[LEFT_PADDLE].drx = 0;
    shapes[LEFT_PADDLE].dry = 0;
    shapes[LEFT_PADDLE].drz = 0;

    /* Right paddle */
    shapes[RIGHT_PADDLE].quads = paddle_faces;
    shapes[RIGHT_PADDLE].x = itofix(164);
    shapes[RIGHT_PADDLE].y = itofix(0);
    shapes[RIGHT_PADDLE].z = 192 << 16;
    shapes[RIGHT_PADDLE].rx = 0;
    shapes[RIGHT_PADDLE].ry = 0;
    shapes[RIGHT_PADDLE].rz = 0;
    shapes[RIGHT_PADDLE].dy = ((AL_RAND() & 255) - 8) << 12;
    shapes[RIGHT_PADDLE].drx = 0;
    shapes[RIGHT_PADDLE].dry = 0;
    shapes[RIGHT_PADDLE].drz = 0;

    /* Cube */
    shapes[CUBE].quads = cube_faces;
    shapes[CUBE].x = itofix(0);
    shapes[CUBE].y = itofix(0);
    shapes[CUBE].z = 192 << 16;
    shapes[CUBE].rx = 0;
    shapes[CUBE].ry = 0;
    shapes[CUBE].rz = 0;
    shapes[CUBE].dx = itofix(-2);
    shapes[CUBE].dy = ftofix(3.5);
    shapes[CUBE].drx = 0;
    shapes[CUBE].dry = 0;
    shapes[CUBE].drz = 0;
}

void animate_paddle(int i) {
    if ((shapes[i].y < itofix(164) || shapes[i].dy < 0) &&
    (shapes[i].y > itofix(-164) || shapes[i].dy > 0))
        shapes[i].y += shapes[i].dy;

    if ((shapes[i].x < itofix(164) || shapes[i].dx < 0) ||
    (shapes[i].x > itofix(-164) || shapes[i].dx > 0))
        shapes[i].x += shapes[i].dx;

    shapes[i].rx += shapes[i].drx;
    shapes[i].ry += shapes[i].dry;
    shapes[i].rz += shapes[i].drz;
}

void animate_cube(void) {
    if (shapes[CUBE].y > itofix(164)) {
        shapes[CUBE].dy = itofix(-5);
    } else if (shapes[CUBE].y < itofix(-164)) {
        shapes[CUBE].dy = itofix(5);
    }

    shapes[CUBE].x += shapes[CUBE].dx;
    shapes[CUBE].y += shapes[CUBE].dy;

    shapes[CUBE].rx += shapes[CUBE].drx;
    shapes[CUBE].ry += shapes[CUBE].dry;
    shapes[CUBE].rz += shapes[CUBE].drz;
}

/* update shape positions */
void animate_shapes(void) {
    animate_paddle(LEFT_PADDLE);
    animate_paddle(RIGHT_PADDLE);
    animate_cube();
}

void reset(void) {
    shapes[LEFT_PADDLE].y = 0;
    shapes[RIGHT_PADDLE].y = 0;

    shapes[CUBE].x = 0;
    shapes[CUBE].y = 0;
}

/* translate shapes from 3d world space to 2d screen space */
void project_shapes(void) {
    int c, d;
    MATRIX matrix;
    VTX *outpoint = output_points;
    Quad *outface = output_faces;
    
    for (c=0; c < NUM_SHAPES; c++) {
        /* build a transformation matrix */
        get_transformation_matrix(
            &matrix, itofix(1),
            shapes[c].rx, shapes[c].ry, shapes[c].rz,
            shapes[c].x, shapes[c].y, shapes[c].z
        );

        /* output the vertices */
        for (d=0; d<NUM_VERTICES*2; d++) {
            apply_matrix(
                &matrix, points[d].x, points[d].y, points[d].z,
                &outpoint[d].x, &outpoint[d].y, &outpoint[d].z
            );

            persp_project(
                outpoint[d].x, outpoint[d].y, outpoint[d].z,
                &outpoint[d].x, &outpoint[d].y
            );
        }

        /* output the faces */
        for (d=0; d<NUM_FACES; d++) {
            outface[d] = shapes[c].quads[d];
            outface[d].vtxlist = outpoint;
        }

        outpoint += NUM_VERTICES * 2;
        outface += NUM_FACES;
    }
}

/* draw a line (for wireframe display) */
void wire(BITMAP *b, VTX *v1, VTX *v2)
{
    int col = MID(128, 255 - fixtoi(v1->z+v2->z) / 16, 255);
    line(b, fixtoi(v1->x), fixtoi(v1->y), fixtoi(v2->x), fixtoi(v2->y),
    palette_color[col]);
}

/* callback for qsort() */
int quad_cmp(const void *e1, const void *e2)
{
    Quad *q1 = (Quad *)e1;
    Quad *q2 = (Quad *)e2;

    fixed d1 = q1->vtxlist[q1->v1].z + q1->vtxlist[q1->v2].z +
            q1->vtxlist[q1->v3].z + q1->vtxlist[q1->v4].z;

    fixed d2 = q2->vtxlist[q2->v1].z + q2->vtxlist[q2->v2].z +
            q2->vtxlist[q2->v3].z + q2->vtxlist[q2->v4].z;

    return d2 - d1;
}

/* draw the shapes calculated by project_shapes() */
void draw_shapes(BITMAP *b)
{
    int c;
    Quad *face = output_faces;
    VTX *v1, *v2, *v3, *v4;

    /* depth sort */
    qsort(output_faces, NUM_FACES * NUM_SHAPES, sizeof(Quad), quad_cmp);

    for (c=0; c < NUM_FACES * NUM_SHAPES; c++) {
        /* find the vertices used by the face */
        v1 = face->vtxlist + face->v1;
        v2 = face->vtxlist + face->v2;
        v3 = face->vtxlist + face->v3;
        v4 = face->vtxlist + face->v4;

        /* draw the face */
        wire(b, v1, v2);
        wire(b, v2, v3);
        wire(b, v3, v4);
        wire(b, v4, v1);

        face++;
    }
}

void min_max(int shape, fixed *min_x, fixed *min_y, fixed *max_x, fixed *max_y) {
    int width, height;
    if (shape == LEFT_PADDLE || shape == RIGHT_PADDLE) {
        width = 6;
        // we lie a little bit on the collisions to make it seem more fair :3
        height = 48;
    } else {
        width = 6;
        height = 6;
    }

    *min_y = shapes[shape].y - itofix(height / 2);
    *min_x = shapes[shape].x - itofix(width / 2);
    *max_y = *min_y + itofix(height);
    *max_x = *min_x + itofix(width);
}

bool paddle_contact(int paddle) {
    // get the minimum and maximum points of the paddle
    fixed px_min, py_min, px_max, py_max;
    min_max(paddle, &px_min, &py_min, &px_max, &py_max);

    // get the minimum and maximum points of the cube
    fixed cx_min, cy_min, cx_max, cy_max;
    min_max(CUBE, &cx_min, &cy_min, &cx_max, &cy_max);

    return !(cx_max < px_min || cx_min > px_max || cy_max < py_min || cy_min > py_max);
}

/* RGB -> color mapping table. Not needed, but speeds things up */
RGB_MAP rgb_table;

/* lighting color mapping table */
COLOR_MAP light_table;

/* transparency color mapping table */
COLOR_MAP trans_table;

int main(void)
{
    BITMAP *buffer;
    PALETTE pal;
    int c, w, h, bpp;
    int last_retrace_count;

    if (allegro_init() != 0)
        return 1;
    install_keyboard();
    install_mouse();
    install_timer();

    /* color 0 = black */
    pal[0].r = pal[0].g = pal[0].b = 0;

    /* copy the desktop palette */
    for (c=1; c<64; c++)
        pal[c] = desktop_palette[c];

    /* make a red gradient */
    for (c=64; c<96; c++) {
        pal[c].r = (c-64)*2;
        pal[c].g = pal[c].b = 0;
    }

    /* make a teal gradient */
    for (c=96; c<128; c++) {
        pal[c].b = (c-96)*2;
        pal[c].r = 0;
        pal[c].g = (c-96)*2;
    }

    /* set up a greyscale in the top half of the palette */
    for (c=128; c<256; c++)
        pal[c].r = pal[c].g = pal[c].b = (c-128)/2;

    /* build rgb_map table */
    create_rgb_table(&rgb_table, pal, NULL);
    rgb_map = &rgb_table;

    /* build a lighting table */
    create_light_table(&light_table, pal, 0, 0, 0, NULL);
    color_map = &light_table;

    /* build a transparency table */
    /* textures are 25% transparent (75% opaque) */
    create_trans_table(&trans_table, pal, 192, 192, 192, NULL);

    /* set up the truecolor blending functions */
    /* textures are 25% transparent (75% opaque) */
    set_trans_blender(0, 0, 0, 192);

    /* set the graphics mode */
    if (set_gfx_mode(GFX_AUTODETECT, 320, 200, 0, 0) != 0) {
        set_gfx_mode(GFX_TEXT, 0, 0, 0, 0);
        allegro_message("Unable to set any graphic mode\n%s\n", allegro_error);
        return 1;
    }
    set_palette(pal);

    /* double buffer the animation */
    buffer = create_bitmap(SCREEN_W, SCREEN_H);

    /* set up the viewport for the perspective projection */
    set_projection_viewport(0, 0, SCREEN_W, SCREEN_H);

    /* initialise the bouncing shapes */
    init_shapes();

    last_retrace_count = retrace_count;

    bool just_contacted = false;

    unsigned int left = 0;
    unsigned int right = 0;

    char left_buffer[10];
    char right_buffer[10];

    for (;;) {
        clear_bitmap(buffer);

        while (last_retrace_count < retrace_count) {
            animate_shapes();
            last_retrace_count++;
        }

        project_shapes();
        draw_shapes(buffer);

        itoa(left, left_buffer, 10);
        textout_centre_ex(buffer, font, left_buffer, 6, 6, 127, -1);

        itoa(right, right_buffer, 10);
        textout_centre_ex(buffer, font, right_buffer, SCREEN_W-6, 6, 95, -1);

        vsync();
        blit(buffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);

        if ((paddle_contact(LEFT_PADDLE) || paddle_contact(RIGHT_PADDLE)) && !just_contacted) {
            shapes[CUBE].dx = -shapes[CUBE].dx;
            just_contacted = true;
        } else {
            just_contacted = false;
        }

        if (shapes[CUBE].x < itofix(-172)) {
            right += 1;
            reset();
        } else if (shapes[CUBE].x > itofix(172)) {
            left += 1;
            reset();
        }

        if (keyboard_needs_poll()) {
            poll_keyboard();
        }

        if (key[KEY_W]) {
            shapes[LEFT_PADDLE].dy = itofix(-3);
        } else if (key[KEY_S]) {
            shapes[LEFT_PADDLE].dy = itofix(3);
        } else {
            shapes[LEFT_PADDLE].dy = 0;
        }

        if (key[KEY_UP]) {
            shapes[RIGHT_PADDLE].dy = itofix(-3);
        } else if (key[KEY_DOWN]) {
            shapes[RIGHT_PADDLE].dy = itofix(3);
        } else {
            shapes[RIGHT_PADDLE].dy = 0;
        }

        if (key[KEY_ESC]) {
            break;
        }
    }

    destroy_bitmap(buffer);
    destroy_bitmap(texture);

    return 0;
}

END_OF_MAIN()
