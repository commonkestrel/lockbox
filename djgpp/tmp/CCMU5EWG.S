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
	pushl	$2
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+128
	subl	$12, %esp
	pushl	$5
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+124
	movl	$0, _shapes+132
	movl	$0, _shapes+136
	movl	$0, _shapes+140
	leave
	ret
.globl _animate_paddle
_animate_paddle:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %edx
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
	jl	L4
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	testl	%eax, %eax
	jns	L6
L4:
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %ebx
	subl	$12, %esp
	pushl	$-164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jg	L7
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	testl	%eax, %eax
	jle	L6
L7:
	movl	8(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+8(%eax), %ecx
	movl	8(%ebp), %edx
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
L6:
	movl	8(%ebp), %edx
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
	jl	L9
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	testl	%eax, %eax
	js	L9
	movl	8(%ebp), %edx
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
	jg	L9
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+32(%eax), %eax
	testl	%eax, %eax
	jle	L13
L9:
	movl	8(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+4(%eax), %ecx
	movl	8(%ebp), %edx
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
L13:
	movl	8(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+16(%eax), %ecx
	movl	8(%ebp), %edx
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
	movl	8(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+20(%eax), %ecx
	movl	8(%ebp), %edx
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
	movl	8(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	_shapes+24(%eax), %ecx
	movl	8(%ebp), %edx
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
	movl	-4(%ebp), %ebx
	leave
	ret
.globl _animate_cube
_animate_cube:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	movl	_shapes+104, %ebx
	subl	$12, %esp
	pushl	$30
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jle	L16
	movl	_shapes+104, %ebx
	subl	$12, %esp
	pushl	$-30
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jge	L16
	movl	_shapes+124, %eax
	negl	%eax
	movl	%eax, _shapes+124
L16:
	movl	_shapes+100, %ebx
	subl	$12, %esp
	pushl	$164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jg	L19
	movl	_shapes+100, %ebx
	subl	$12, %esp
	pushl	$-164
	call	_itofix
	addl	$16, %esp
	cmpl	%eax, %ebx
	jge	L21
L19:
	movl	_shapes+128, %eax
	negl	%eax
	movl	%eax, _shapes+128
L21:
	movl	_shapes+100, %edx
	movl	_shapes+128, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, _shapes+100
	movl	_shapes+104, %edx
	movl	_shapes+124, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, _shapes+104
	movl	_shapes+112, %edx
	movl	_shapes+132, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, _shapes+112
	movl	_shapes+116, %edx
	movl	_shapes+136, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, _shapes+116
	movl	_shapes+120, %edx
	movl	_shapes+140, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, _shapes+120
	movl	-4(%ebp), %ebx
	leave
	ret
.globl _animate_shapes
_animate_shapes:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	$0
	call	_animate_paddle
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	_animate_paddle
	addl	$16, %esp
	call	_animate_cube
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
	jmp	L26
L27:
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
	jmp	L28
L29:
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
L28:
	cmpl	$15, -24(%ebp)
	jle	L29
	movl	$0, -24(%ebp)
	jmp	L31
L32:
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
L31:
	cmpl	$5, -24(%ebp)
	jle	L32
	addl	$192, -20(%ebp)
	addl	$120, -16(%ebp)
	incl	-28(%ebp)
L26:
	cmpl	$2, -28(%ebp)
	jle	L27
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
	jg	L37
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
	jle	L39
L37:
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
	jg	L40
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
	jmp	L42
L40:
	movl	$255, -36(%ebp)
L42:
	movl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)
	jmp	L43
L39:
	movl	$128, -40(%ebp)
L43:
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
	jmp	L48
L49:
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
L48:
	cmpl	$17, -24(%ebp)
	jle	L49
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
	je	L53
	movl	$1, -1096(%ebp)
	jmp	L55
L53:
	call	_install_keyboard
	call	_install_mouse
	call	_install_timer
	movb	$0, -1058(%ebp)
	movb	-1058(%ebp), %al
	movb	%al, -1059(%ebp)
	movb	-1059(%ebp), %al
	movb	%al, -1060(%ebp)
	movl	$1, -32(%ebp)
	jmp	L56
L57:
	movl	-32(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	_desktop_palette(,%edx,4), %edx
	movl	%edx, -1060(%ebp,%eax,4)
	incl	-32(%ebp)
L56:
	cmpl	$63, -32(%ebp)
	jle	L57
	movl	$64, -32(%ebp)
	jmp	L59
L60:
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
L59:
	cmpl	$95, -32(%ebp)
	jle	L60
	movl	$96, -32(%ebp)
	jmp	L62
L63:
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
L62:
	cmpl	$127, -32(%ebp)
	jle	L63
	movl	$128, -32(%ebp)
	jmp	L65
L66:
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
L65:
	cmpl	$255, -32(%ebp)
	jle	L66
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
	je	L68
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
	jmp	L55
L68:
	subl	$12, %esp
	leal	-1060(%ebp), %eax
	pushl	%eax
	call	_set_palette
	addl	$16, %esp
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L70
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1092(%ebp)
	jmp	L72
L70:
	movl	$0, -1092(%ebp)
L72:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L73
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1088(%ebp)
	jmp	L75
L73:
	movl	$0, -1088(%ebp)
L75:
	subl	$8, %esp
	pushl	-1092(%ebp)
	pushl	-1088(%ebp)
	call	_create_bitmap
	addl	$16, %esp
	movl	%eax, -36(%ebp)
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L76
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1084(%ebp)
	jmp	L78
L76:
	movl	$0, -1084(%ebp)
L78:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L79
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1080(%ebp)
	jmp	L81
L79:
	movl	$0, -1080(%ebp)
L81:
	pushl	-1084(%ebp)
	pushl	-1080(%ebp)
	pushl	$0
	pushl	$0
	call	_set_projection_viewport
	addl	$16, %esp
	call	_init_shapes
	movl	_retrace_count, %eax
	movl	%eax, -16(%ebp)
L82:
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_clear_bitmap
	addl	$16, %esp
	jmp	L83
L84:
	call	_animate_shapes
	incl	-16(%ebp)
L83:
	movl	_retrace_count, %eax
	cmpl	%eax, -16(%ebp)
	jl	L84
	call	_project_shapes
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_draw_shapes
	addl	$16, %esp
	call	_vsync
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L86
	movl	_gfx_driver, %eax
	movl	112(%eax), %eax
	movl	%eax, -1076(%ebp)
	jmp	L88
L86:
	movl	$0, -1076(%ebp)
L88:
	movl	_gfx_driver, %eax
	testl	%eax, %eax
	je	L89
	movl	_gfx_driver, %eax
	movl	108(%eax), %eax
	movl	%eax, -1072(%ebp)
	jmp	L91
L89:
	movl	$0, -1072(%ebp)
L91:
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
	call	_keyboard_needs_poll
	testl	%eax, %eax
	je	L92
	call	_poll_keyboard
L92:
	movb	_key+23, %al
	testb	%al, %al
	je	L94
	subl	$12, %esp
	pushl	$-3
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+28
	jmp	L96
L94:
	movb	_key+19, %al
	testb	%al, %al
	je	L97
	subl	$12, %esp
	pushl	$3
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+28
	jmp	L96
L97:
	movl	$0, _shapes+28
L96:
	movb	_key+84, %al
	testb	%al, %al
	je	L99
	subl	$12, %esp
	pushl	$-3
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+76
	jmp	L101
L99:
	movb	_key+85, %al
	testb	%al, %al
	je	L102
	subl	$12, %esp
	pushl	$3
	call	_itofix
	addl	$16, %esp
	movl	%eax, _shapes+76
	jmp	L101
L102:
	movl	$0, _shapes+76
L101:
	movb	_key+59, %al
	testb	%al, %al
	jne	L104
	jmp	L82
L104:
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
L55:
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
