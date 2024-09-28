	.file	"main.c"
.globl _points
	.section .data
	.p2align 4
_points:
	.long	-2097152
	.long	-2097152
	.long	-4194304
	.long	-2097152
	.long	2097152
	.long	-4194304
	.long	2097152
	.long	2097152
	.long	-4194304
	.long	2097152
	.long	-2097152
	.long	-4194304
	.long	-2097152
	.long	-2097152
	.long	4194304
	.long	-2097152
	.long	2097152
	.long	4194304
	.long	2097152
	.long	2097152
	.long	4194304
	.long	2097152
	.long	-2097152
	.long	4194304
.globl _faces
	.p2align 4
_faces:
	.long	_points
	.long	0
	.long	3
	.long	2
	.long	1
	.long	_points
	.long	4
	.long	5
	.long	6
	.long	7
	.long	_points
	.long	0
	.long	1
	.long	5
	.long	4
	.long	_points
	.long	2
	.long	3
	.long	7
	.long	6
	.long	_points
	.long	0
	.long	4
	.long	7
	.long	3
	.long	_points
	.long	1
	.long	2
	.long	6
	.long	5
	.section .text
LC0:
	.ascii "At: 10\0"
LC1:
	.ascii "At: 11\0"
.globl _main
_main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$36, %esp
	pushl	$262659
	pushl	$_atexit
	pushl	$_errno
	pushl	$0
	call	__install_allegro_version_check
	addl	$16, %esp
	testl	%eax, %eax
	je	L2
	movl	$1, -40(%ebp)
	jmp	L4
L2:
	call	_install_keyboard
	call	_install_mouse
	call	_install_timer
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L5
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -36(%ebp)
	jmp	L7
L5:
	movl	$0, -36(%ebp)
L7:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L8
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -32(%ebp)
	jmp	L10
L8:
	movl	$0, -32(%ebp)
L10:
	subl	$8, %esp
	pushl	-36(%ebp)
	pushl	-32(%ebp)
	call	_create_bitmap
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L11
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -28(%ebp)
	jmp	L13
L11:
	movl	$0, -28(%ebp)
L13:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L14
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -24(%ebp)
	jmp	L16
L14:
	movl	$0, -24(%ebp)
L16:
	pushl	-28(%ebp)
	pushl	-24(%ebp)
	pushl	$0
	pushl	$0
	call	_set_projection_viewport
	addl	$16, %esp
	call	_init_shapes
L17:
	subl	$12, %esp
	pushl	-8(%ebp)
	call	_clear_bitmap
	addl	$16, %esp
	subl	$12, %esp
	pushl	$LC0
	call	_puts
	addl	$16, %esp
	subl	$12, %esp
	pushl	-8(%ebp)
	call	_draw_shapes
	addl	$16, %esp
	subl	$12, %esp
	pushl	$LC1
	call	_puts
	addl	$16, %esp
	call	_keypressed
	testl	%eax, %eax
	je	L17
	call	_readkey
	andl	$255, %eax
	cmpl	$1, %eax
	je	L20
	jmp	L17
L20:
	movl	$0, -40(%ebp)
L4:
	movl	-40(%ebp), %eax
	movl	-4(%ebp), %ecx
	leave
	leal	-4(%ecx), %esp
	ret
.globl _init_shapes
_init_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, %esi
	subl	$12, %esp
	pushl	$-1
	call	_itofix
	addl	$16, %esp
	movl	%eax, %edi
	subl	$12, %esp
	pushl	$3
	call	_itofix
	addl	$16, %esp
	movl	%eax, -52(%ebp)
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, -48(%ebp)
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%esi, -36(%ebp)
	movl	%edi, -32(%ebp)
	movl	-52(%ebp), %edx
	movl	%edx, -28(%ebp)
	movl	-48(%ebp), %edx
	movl	%edx, -24(%ebp)
	movl	%ebx, -20(%ebp)
	movl	%eax, -16(%ebp)
	movl	$_paddle, %edi
	leal	-36(%ebp), %esi
	cld
	movl	$6, %eax
	movl	%eax, %ecx
	rep
	movsl
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
LC2:
	.ascii "At: 20\0"
LC3:
	.ascii "At: 21\0"
.globl _draw_shapes
_draw_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$_output_faces, -20(%ebp)
	subl	$12, %esp
	pushl	$LC2
	call	_puts
	addl	$16, %esp
	pushl	$_quad_cmp
	pushl	$20
	pushl	$6
	pushl	$_output_faces
	call	_qsort
	addl	$16, %esp
	subl	$12, %esp
	pushl	$LC3
	call	_puts
	addl	$16, %esp
	movl	$0, -24(%ebp)
	jmp	L25
L26:
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -8(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -4(%ebp)
	subl	$4, %esp
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	pushl	8(%ebp)
	call	_wire
	addl	$16, %esp
	subl	$4, %esp
	pushl	-8(%ebp)
	pushl	-12(%ebp)
	pushl	8(%ebp)
	call	_wire
	addl	$16, %esp
	subl	$4, %esp
	pushl	-4(%ebp)
	pushl	-8(%ebp)
	pushl	8(%ebp)
	call	_wire
	addl	$16, %esp
	subl	$4, %esp
	pushl	-16(%ebp)
	pushl	-4(%ebp)
	pushl	8(%ebp)
	call	_wire
	addl	$16, %esp
	incl	-24(%ebp)
L25:
	cmpl	$5, -24(%ebp)
	jle	L26
	leave
	ret
.globl _translate_shapes
_translate_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$92, %esp
	movl	$_output_points, -20(%ebp)
	movl	$_output_faces, -16(%ebp)
	movl	_paddle+8, %ebx
	movl	_paddle+4, %esi
	movl	_paddle, %edi
	movl	_paddle+20, %eax
	movl	%eax, -92(%ebp)
	movl	_paddle+16, %eax
	movl	%eax, -88(%ebp)
	movl	_paddle+12, %eax
	movl	%eax, -84(%ebp)
	subl	$12, %esp
	pushl	$1
	call	_itofix
	addl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	-92(%ebp)
	pushl	-88(%ebp)
	pushl	-84(%ebp)
	pushl	%eax
	leal	-72(%ebp), %eax
	pushl	%eax
	call	_get_transformation_matrix
	addl	$32, %esp
	movl	$0, -24(%ebp)
	jmp	L30
L31:
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	leal	8(%eax), %ecx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	leal	4(%eax), %ebx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	movl	%eax, %esi
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	_points+8(%eax), %edi
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	_points+4(%eax), %eax
	movl	%eax, -80(%ebp)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	_points(%eax), %eax
	subl	$4, %esp
	pushl	%ecx
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	-80(%ebp)
	pushl	%eax
	leal	-72(%ebp), %eax
	pushl	%eax
	call	_apply_matrix
	addl	$32, %esp
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	leal	4(%eax), %ecx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	movl	%eax, %ebx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	movl	8(%eax), %esi
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	movl	4(%eax), %edi
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-20(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%ecx
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	%eax
	call	_persp_project
	addl	$32, %esp
	incl	-24(%ebp)
L30:
	cmpl	$7, -24(%ebp)
	jle	L31
	movl	$0, -24(%ebp)
	jmp	L33
L34:
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %ecx
	addl	-16(%ebp), %ecx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	_faces(%edx), %eax
	movl	%eax, (%ecx)
	movl	_faces+4(%edx), %eax
	movl	%eax, 4(%ecx)
	movl	_faces+8(%edx), %eax
	movl	%eax, 8(%ecx)
	movl	_faces+12(%edx), %eax
	movl	%eax, 12(%ecx)
	movl	_faces+16(%edx), %eax
	movl	%eax, 16(%ecx)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %edx
	addl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	movl	%eax, (%edx)
	incl	-24(%ebp)
L33:
	cmpl	$5, -24(%ebp)
	jle	L34
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.globl _wire
_wire:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	12(%ebp), %eax
	movl	8(%eax), %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	leal	(%edx,%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	subl	$4, %esp
	pushl	-20(%ebp)
	pushl	-20(%ebp)
	pushl	-20(%ebp)
	call	_makecol
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	16(%ebp), %eax
	movl	4(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %ebx
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %esi
	movl	12(%ebp), %eax
	movl	4(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %edi
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	%eax
	pushl	8(%ebp)
	call	_line
	addl	$32, %esp
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
LC4:
	.ascii "At: 30\0"
LC5:
	.ascii "At: 31\0"
LC6:
	.ascii "At: 32\0"
LC7:
	.ascii "faces[0] %p \0"
LC8:
	.ascii "vtxlist: %p \0"
LC9:
	.ascii "e1:%p \0"
LC10:
	.ascii "i:%d \0"
LC11:
	.ascii "At: 33\0"
.globl _quad_cmp
_quad_cmp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	subl	$12, %esp
	pushl	$LC4
	call	_puts
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -20(%ebp)
	subl	$12, %esp
	pushl	$LC5
	call	_puts
	addl	$16, %esp
	movl	_faces, %eax
	movl	%eax, -16(%ebp)
	movl	_faces+16, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %edx
	addl	-16(%ebp), %edx
	movl	(%edx), %eax
	movl	%eax, -36(%ebp)
	movl	4(%edx), %eax
	movl	%eax, -32(%ebp)
	movl	8(%edx), %eax
	movl	%eax, -28(%ebp)
	subl	$12, %esp
	pushl	$LC6
	call	_puts
	addl	$16, %esp
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	subl	$8, %esp
	pushl	$_faces
	pushl	$LC7
	call	_printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	$LC8
	call	_printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	-24(%ebp)
	pushl	$LC9
	call	_printf
	addl	$16, %esp
	movl	-24(%ebp), %eax
	movl	16(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$LC10
	call	_printf
	addl	$16, %esp
	movl	-24(%ebp), %eax
	movl	(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %ebx
	movl	-24(%ebp), %eax
	movl	(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-24(%ebp), %eax
	movl	(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-24(%ebp), %eax
	movl	(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	leal	(%ebx,%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %ebx
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-20(%ebp), %eax
	movl	(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	leal	(%ebx,%eax), %eax
	movl	%eax, -8(%ebp)
	subl	$12, %esp
	pushl	$LC11
	call	_puts
	addl	$16, %esp
	movl	-8(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	ret
.comm _paddle,32
.comm _output_points,96
.comm _output_faces,128
	.ident	"GCC: (GNU) 4.2.1"
