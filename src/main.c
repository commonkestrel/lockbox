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


#define NUM_VERTICES         8      /* a cube has eight corners */
#define NUM_FACES            6      /* a cube has six faces */
#define NUM_SHAPES           3      /* the paddles and the cube */

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
    shapes[0].quads = paddle_faces;
    shapes[0].x = itofix(-164);
    shapes[0].y = itofix(0);
    shapes[0].z = 192 << 16;
    shapes[0].rx = 0;
    shapes[0].ry = 0;
    shapes[0].rz = 0;
    shapes[0].dy = ((AL_RAND() & 255) - 8) << 12;
    shapes[0].drx = 0;
    shapes[0].dry = 0;
    shapes[0].drz = 0;

    /* Right paddle */
    shapes[1].quads = paddle_faces;
    shapes[1].x = itofix(164);
    shapes[1].y = itofix(0);
    shapes[1].z = 192 << 16;
    shapes[1].rx = 0;
    shapes[1].ry = 0;
    shapes[1].rz = 0;
    shapes[1].dy = ((AL_RAND() & 255) - 8) << 12;
    shapes[1].drx = 0;
    shapes[1].dry = 0;
    shapes[1].drz = 0;

    /* Cube */
    shapes[2].quads = cube_faces;
    shapes[2].x = itofix(0);
    shapes[2].y = itofix(0);
    shapes[2].z = 192 << 16;
    shapes[2].rx = 0;
    shapes[2].ry = 0;
    shapes[2].rz = 0;
    shapes[2].dx = itofix(4);
    shapes[2].dy = itofix(10);
    shapes[2].drx = 0;
    shapes[2].dry = 0;
    shapes[2].drz = 0;
}



/* update shape positions */
void animate_shapes(void)
{
    int c;
    for (c=0; c < NUM_SHAPES; c++) {
        shapes[c].y += shapes[c].dy;
        shapes[c].x += shapes[c].dx;

        if ((shapes[c].y > itofix(164)) ||
        (shapes[c].y < itofix(-172)))
            shapes[c].dy = -shapes[c].dy;

        if ((shapes[c].x > itofix(164)) ||
        (shapes[c].x < itofix(-164)))
            shapes[c].dx = -shapes[c].dx;
    
        shapes[c].rx += shapes[c].drx;
        shapes[c].ry += shapes[c].dry;
        shapes[c].rz += shapes[c].drz;
    }
}



/* translate shapes from 3d world space to 2d screen space */
void project_shapes(void)
{
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

    /* make a green gradient */
    for (c=96; c<128; c++) {
        pal[c].g = (c-96)*2;
        pal[c].r = pal[c].b = 0;
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

    for (;;) {
        clear_bitmap(buffer);

        while (last_retrace_count < retrace_count) {
            animate_shapes();
            last_retrace_count++;
        }

        project_shapes();
        draw_shapes(buffer);

        vsync();
        blit(buffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H); 

        if (keypressed()) {
            if ((readkey() >> 8) == KEY_ESC)
                break;
        }
    }

    destroy_bitmap(buffer);
    destroy_bitmap(texture);

    return 0;
}

END_OF_MAIN()
