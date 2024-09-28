	.file	"main.c"
.globl _points
	.section .data
	.p2align 4
_points:
	.long	-393216
	.long	-2097152
	.long	-1048576
	.long	-393216
	.long	2097152
	.long	-1048576
	.long	393216
	.long	2097152
	.long	-1048576
	.long	393216
	.long	-2097152
	.long	-1048576
	.long	-393216
	.long	-2097152
	.long	1048576
	.long	-393216
	.long	2097152
	.long	1048576
	.long	393216
	.long	2097152
	.long	1048576
	.long	393216
	.long	-2097152
	.long	1048576
	.long	-393216
	.long	-393216
	.long	-393216
	.long	-393216
	.long	393216
	.long	-393216
	.long	393216
	.long	393216
	.long	-393216
	.long	393216
	.long	-393216
	.long	-393216
	.long	-393216
	.long	-393216
	.long	393216
	.long	-393216
	.long	393216
	.long	393216
	.long	393216
	.long	393216
	.long	393216
	.long	393216
	.long	-393216
	.long	393216
.globl _paddle_faces
	.p2align 4
_paddle_faces:
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
.globl _cube_faces
	.p2align 4
_cube_faces:
	.long	_points
	.long	8
	.long	11
	.long	10
	.long	9
	.long	_points
	.long	12
	.long	13
	.long	14
	.long	15
	.long	_points
	.long	8
	.long	9
	.long	13
	.long	12
	.long	_points
	.long	10
	.long	11
	.long	15
	.long	14
	.long	_points
	.long	8
	.long	12
	.long	15
	.long	11
	.long	_points
	.long	9
	.long	10
	.long	14
	.long	13
	.section .text
.globl _init_shapes
_init_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_paddle_faces, _shapes
	subl	$12, %esp
	pushl	$-164
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+4
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+8
	movl	$12582912, _shapes+12
	movl	$0, _shapes+16
	movl	$0, _shapes+20
	movl	$0, _shapes+24
	call	_rand
	andl	$255, %eax
	subl	$8, %eax
	sall	$12, %eax
	movl	%eax, _shapes+28
	movl	$0, _shapes+36
	movl	$0, _shapes+40
	movl	$0, _shapes+44
	movl	$_paddle_faces, _shapes+48
	subl	$12, %esp
	pushl	$164
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+52
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+56
	movl	$12582912, _shapes+60
	movl	$0, _shapes+64
	movl	$0, _shapes+68
	movl	$0, _shapes+72
	call	_rand
	andl	$255, %eax
	subl	$8, %eax
	sall	$12, %eax
	movl	%eax, _shapes+76
	movl	$0, _shapes+84
	movl	$0, _shapes+88
	movl	$0, _shapes+92
	movl	$_cube_faces, _shapes+96
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+100
	subl	$12, %esp
	pushl	$0
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+104
	movl	$12582912, _shapes+108
	movl	$0, _shapes+112
	movl	$0, _shapes+116
	movl	$0, _shapes+120
	subl	$12, %esp
	pushl	$4
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+128
	subl	$12, %esp
	pushl	$10
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+124
	movl	$0, _shapes+132
	movl	$0, _shapes+136
	movl	$0, _shapes+140
	leave
	ret
.globl _animate_shapes
_animate_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	$0, -8(%ebp)
	jmp	L4
L5:
	movl	-8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+28(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+8(%eax)
	movl	-8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+4(%eax), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+4(%eax)
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %ebx
	subl	$12, %esp
	pushl	$164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jg	L6
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %ebx
	subl	$12, %esp
	pushl	$-172
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jge	L8
L6:
	movl	-8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+28(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+28(%eax)
L8:
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+4(%eax), %ebx
	subl	$12, %esp
	pushl	$164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jg	L9
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+4(%eax), %ebx
	subl	$12, %esp
	pushl	$-164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jge	L11
L9:
	movl	-8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+32(%eax)
L11:
	movl	-8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+16(%eax), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+36(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+16(%eax)
	movl	-8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+20(%eax), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+40(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+20(%eax)
	movl	-8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+24(%eax), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+44(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$4, %eax
	movl	%edx, _shapes+24(%eax)
	incl	-8(%ebp)
L4:
	cmpl	$2, -8(%ebp)
	jle	L5
	movl	-4(%ebp), %ebx
	leave
	ret
.globl _project_shapes
_project_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$92, %esp
	movl	$_output_points, -20(%ebp)
	movl	$_output_faces, -16(%ebp)
	movl	$0, -28(%ebp)
	jmp	L15
L16:
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+12(%eax), %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %esi
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+4(%eax), %edi
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+24(%eax), %eax
	movl	%eax, -92(%ebp)
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+20(%eax), %eax
	movl	%eax, -88(%ebp)
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+16(%eax), %eax
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
	leal	-76(%ebp), %eax
	pushl	%eax
	call	_get_transformation_matrix
	addl	$32, %esp
	movl	$0, -24(%ebp)
	jmp	L17
L18:
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
	leal	-76(%ebp), %eax
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
L17:
	cmpl	$15, -24(%ebp)
	jle	L18
	movl	$0, -24(%ebp)
	jmp	L20
L21:
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %ecx
	addl	-16(%ebp), %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes(%eax), %ebx
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %edx
	movl	(%edx), %eax
	movl	%eax, (%ecx)
	movl	4(%edx), %eax
	movl	%eax, 4(%ecx)
	movl	8(%edx), %eax
	movl	%eax, 8(%ecx)
	movl	12(%edx), %eax
	movl	%eax, 12(%ecx)
	movl	16(%edx), %eax
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
L20:
	cmpl	$5, -24(%ebp)
	jle	L21
	addl	$192, -20(%ebp)
	addl	$120, -16(%ebp)
	incl	-28(%ebp)
L15:
	cmpl	$2, -28(%ebp)
	jle	L16
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
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%edx, %eax
	sarl	$4, %eax
	movl	%eax, %edx
	movl	$255, %eax
	subl	%edx, %eax
	cmpl	$254, %eax
	jg	L26
	movl	12(%ebp), %eax
	movl	8(%eax), %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	leal	(%edx,%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%edx, %eax
	sarl	$4, %eax
	movl	%eax, %edx
	movl	$255, %eax
	subl	%edx, %eax
	cmpl	$127, %eax
	jle	L28
L26:
	movl	12(%ebp), %eax
	movl	8(%eax), %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	leal	(%edx,%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%edx, %eax
	sarl	$4, %eax
	movl	%eax, %edx
	movl	$255, %eax
	subl	%edx, %eax
	cmpl	$254, %eax
	jg	L29
	movl	12(%ebp), %eax
	movl	8(%eax), %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	leal	(%edx,%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%edx, %eax
	sarl	$4, %eax
	movl	%eax, %edx
	movl	$255, %eax
	movl	%eax, %ecx
	subl	%edx, %ecx
	movl	%ecx, -36(%ebp)
	jmp	L31
L29:
	movl	$255, -36(%ebp)
L31:
	movl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)
	jmp	L32
L28:
	movl	$128, -40(%ebp)
L32:
	movl	-40(%ebp), %ecx
	movl	%ecx, -16(%ebp)
	movl	-16(%ebp), %eax
	sall	$2, %eax
	movl	%eax, %edx
	movl	_palette_color, %eax
	leal	(%edx,%eax), %eax
	movl	(%eax), %ebx
	movl	16(%ebp), %eax
	movl	4(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %esi
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, %edi
	movl	12(%ebp), %eax
	movl	4(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	_fixtoi
	addl	$16, %esp
	subl	$8, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	-32(%ebp)
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
.globl _quad_cmp
_quad_cmp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -16(%ebp)
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
	movl	%eax, -12(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %ebx
	movl	-16(%ebp), %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-16(%ebp), %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	8(%eax), %eax
	addl	%eax, %ebx
	movl	-16(%ebp), %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
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
	movl	-12(%ebp), %edx
	movl	-8(%ebp), %eax
	subl	%edx, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%ebp
	ret
.globl _draw_shapes
_draw_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$_output_faces, -20(%ebp)
	pushl	$_quad_cmp
	pushl	$20
	pushl	$18
	pushl	$_output_faces
	call	_qsort
	addl	$16, %esp
	movl	$0, -24(%ebp)
	jmp	L37
L38:
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
	addl	$20, -20(%ebp)
	incl	-24(%ebp)
L37:
	cmpl	$17, -24(%ebp)
	jle	L38
	leave
	ret
	.p2align 2
LC0:
	.ascii "Unable to set any graphic mode\12%s\12\0"
.globl _main
_main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	subl	$1084, %esp
	pushl	$262659
	pushl	$_atexit
	pushl	$_errno
	pushl	$0
	call	__install_allegro_version_check
	addl	$16, %esp
	testl	%eax, %eax
	je	L42
	movl	$1, -1096(%ebp)
	jmp	L44
L42:
	call	_install_keyboard
	call	_install_mouse
	call	_install_timer
	movb	$0, -1058(%ebp)
	movb	-1058(%ebp), %al
	movb	%al, -1059(%ebp)
	movb	-1059(%ebp), %al
	movb	%al, -1060(%ebp)
	movl	$1, -32(%ebp)
	jmp	L45
L46:
	movl	-32(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	_desktop_palette(,%edx,4), %edx
	movl	%edx, -1060(%ebp,%eax,4)
	incl	-32(%ebp)
L45:
	cmpl	$63, -32(%ebp)
	jle	L46
	movl	$64, -32(%ebp)
	jmp	L48
L49:
	movl	-32(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%eax, %eax
	addl	$-128, %eax
	movb	%al, -1060(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	movl	-32(%ebp), %eax
	movb	$0, -1058(%ebp,%eax,4)
	movb	-1058(%ebp,%eax,4), %al
	movb	%al, -1059(%ebp,%edx,4)
	incl	-32(%ebp)
L48:
	cmpl	$95, -32(%ebp)
	jle	L49
	movl	$96, -32(%ebp)
	jmp	L51
L52:
	movl	-32(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%eax, %eax
	addl	$64, %eax
	movb	%al, -1059(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	movl	-32(%ebp), %eax
	movb	$0, -1058(%ebp,%eax,4)
	movb	-1058(%ebp,%eax,4), %al
	movb	%al, -1060(%ebp,%edx,4)
	incl	-32(%ebp)
L51:
	cmpl	$127, -32(%ebp)
	jle	L52
	movl	$128, -32(%ebp)
	jmp	L54
L55:
	movl	-32(%ebp), %esi
	movl	-32(%ebp), %ecx
	movl	-32(%ebp), %ebx
	movl	-32(%ebp), %edx
	addl	$-128, %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movb	%al, -1058(%ebp,%ebx,4)
	movb	-1058(%ebp,%ebx,4), %al
	movb	%al, -1059(%ebp,%ecx,4)
	movb	-1059(%ebp,%ecx,4), %al
	movb	%al, -1060(%ebp,%esi,4)
	incl	-32(%ebp)
L54:
	cmpl	$255, -32(%ebp)
	jle	L55
	subl	$4, %esp
	pushl	$0
	leal	-1060(%ebp), %eax
	pushl	%eax
	pushl	$_rgb_table
	call	_create_rgb_table
	addl	$16, %esp
	movl	$_rgb_table, _rgb_map
	subl	$8, %esp
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$0
	leal	-1060(%ebp), %eax
	pushl	%eax
	pushl	$_light_table
	call	_create_light_table
	addl	$32, %esp
	movl	$_light_table, _color_map
	subl	$8, %esp
	pushl	$0
	pushl	$192
	pushl	$192
	pushl	$192
	leal	-1060(%ebp), %eax
	pushl	%eax
	pushl	$_trans_table
	call	_create_trans_table
	addl	$32, %esp
	pushl	$192
	pushl	$0
	pushl	$0
	pushl	$0
	call	_set_trans_blender
	addl	$16, %esp
	subl	$12, %esp
	pushl	$0
	pushl	$0
	pushl	$200
	pushl	$320
	pushl	$0
	call	_set_gfx_mode
	addl	$32, %esp
	testl	%eax, %eax
	je	L57
	subl	$12, %esp
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$-1
	call	_set_gfx_mode
	addl	$32, %esp
	subl	$8, %esp
	pushl	$_allegro_error
	pushl	$LC0
	call	_allegro_message
	addl	$16, %esp
	movl	$1, -1096(%ebp)
	jmp	L44
L57:
	subl	$12, %esp
	leal	-1060(%ebp), %eax
	pushl	%eax
	call	_set_palette
	addl	$16, %esp
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L59
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1092(%ebp)
	jmp	L61
L59:
	movl	$0, -1092(%ebp)
L61:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L62
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1088(%ebp)
	jmp	L64
L62:
	movl	$0, -1088(%ebp)
L64:
	subl	$8, %esp
	pushl	-1092(%ebp)
	pushl	-1088(%ebp)
	call	_create_bitmap
	addl	$16, %esp
	movl	%eax, -36(%ebp)
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L65
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1084(%ebp)
	jmp	L67
L65:
	movl	$0, -1084(%ebp)
L67:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L68
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1080(%ebp)
	jmp	L70
L68:
	movl	$0, -1080(%ebp)
L70:
	pushl	-1084(%ebp)
	pushl	-1080(%ebp)
	pushl	$0
	pushl	$0
	call	_set_projection_viewport
	addl	$16, %esp
	call	_init_shapes
	movl	_retrace_count, %eax
	movl	%eax, -16(%ebp)
L71:
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_clear_bitmap
	addl	$16, %esp
	jmp	L72
L73:
	call	_animate_shapes
	incl	-16(%ebp)
L72:
	movl	_retrace_count, %eax
	cmpl	%eax, -16(%ebp)
	jl	L73
	call	_project_shapes
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_draw_shapes
	addl	$16, %esp
	call	_vsync
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L75
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1076(%ebp)
	jmp	L77
L75:
	movl	$0, -1076(%ebp)
L77:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L78
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1072(%ebp)
	jmp	L80
L78:
	movl	$0, -1072(%ebp)
L80:
	movl	_screen, %eax
	pushl	-1076(%ebp)
	pushl	-1072(%ebp)
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	%eax
	pushl	-36(%ebp)
	call	_blit
	addl	$32, %esp
	call	_keypressed
	testl	%eax, %eax
	je	L71
	call	_readkey
	sarl	$8, %eax
	cmpl	$59, %eax
	je	L83
	jmp	L71
L83:
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_destroy_bitmap
	addl	$16, %esp
	movl	_texture, %eax
	subl	$12, %esp
	pushl	%eax
	call	_destroy_bitmap
	addl	$16, %esp
	movl	$0, -1096(%ebp)
L44:
	movl	-1096(%ebp), %eax
	leal	-12(%ebp), %esp
	popl	%ecx
	popl	%ebx
	popl	%esi
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
.comm _shapes,144
.comm _output_points,576
.comm _output_faces,368
.comm _texture,16
.comm _rgb_table,32768
.comm _light_table,65536
.comm _trans_table,65536
	.ident	"GCC: (GNU) 4.2.1"
