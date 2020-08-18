	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"opt_main.c"
	.text
	.align	2
	.global	codewordToMagnitude
	.type	codewordToMagnitude, %function
codewordToMagnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r3, r0, #112
	mov	r3, r3, asr #4
	sub	r3, r3, #1
	and	r0, r0, #15
	cmp	r3, #6
	ldrls	pc, [pc, r3, asl #2]
	b	.L2
.L10:
	.word	.L3
	.word	.L4
	.word	.L5
	.word	.L6
	.word	.L7
	.word	.L8
	.word	.L9
.L2:
	mov	r3, r0, asl #1
	orr	r0, r3, #33
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L3:
	mov	r3, r0, asl #2
	orr	r0, r3, #66
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L4:
	mov	r3, r0, asl #3
	orr	r0, r3, #132
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L5:
	mov	r3, r0, asl #4
	orr	r0, r3, #264
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L6:
	mov	r3, r0, asl #5
	orr	r0, r3, #528
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L7:
	mov	r3, r0, asl #6
	orr	r0, r3, #1056
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L8:
	mov	r3, r0, asl #7
	orr	r0, r3, #2112
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
.L9:
	mov	r3, r0, asl #8
	orr	r0, r3, #4224
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
	.size	codewordToMagnitude, .-codewordToMagnitude
	.align	2
	.global	sign
	.type	sign, %function
sign:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mvn	r0, r0
	mov	r0, r0, lsr #31
	bx	lr
	.size	sign, .-sign
	.align	2
	.global	magnitude
	.type	magnitude, %function
magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	rsblt	r0, r0, #0
	mov	r0, r0, asl #16
	mov	r0, r0, lsr #16
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword
	.type	codeword, %function
codeword:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	tst	r1, #32
	mov	ip, r0
	movne	r3, #5
	bne	.L20
	tst	r1, #64
	movne	r3, #6
	bne	.L20
	tst	r1, #128
	movne	r3, #7
	bne	.L20
	tst	r1, #256
	movne	r3, #8
	bne	.L20
	tst	r1, #512
	movne	r3, #9
	bne	.L20
	tst	r1, #1024
	movne	r3, #10
	bne	.L20
	tst	r1, #2048
	movne	r3, #11
	bne	.L20
	ands	r3, r1, #4096
	moveq	r0, r3
	bne	.L30
	orr	r0, r0, ip, asl #7
	orr	r0, r0, r1
	and	r0, r0, #255
	bx	lr
.L30:
	mov	r3, #12
.L20:
	sub	r2, r3, #4
	mov	r2, r1, asr r2
	sub	r3, r3, #5
	mov	r3, r3, asl #4
	and	r0, r3, #255
	and	r1, r2, #15
	orr	r0, r0, ip, asl #7
	orr	r0, r0, r1
	and	r0, r0, #255
	bx	lr
	.size	codeword, .-codeword
	.align	2
	.global	LE_format_32
	.type	LE_format_32, %function
LE_format_32:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L33
	mov	r2, r0, lsr #24
	mov	r1, r0, lsr #8
	mov	ip, r0, lsr #16
	strb	r2, [r3, #3]
	strb	r1, [r3, #1]
	strb	ip, [r3, #2]
	strb	r0, [r3, #0]
	bx	lr
.L34:
	.align	2
.L33:
	.word	data_array
	.size	LE_format_32, .-LE_format_32
	.align	2
	.global	LE_format_16
	.type	LE_format_16, %function
LE_format_16:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L37
	mov	r3, r0, lsr #8
	strb	r3, [r2, #1]
	strb	r0, [r2, #0]
	bx	lr
.L38:
	.align	2
.L37:
	.word	data_array
	.size	LE_format_16, .-LE_format_16
	.align	2
	.global	generate_compressed_file
	.type	generate_compressed_file, %function
generate_compressed_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r0, .L47
	bl	puts
	ldr	r0, .L47+4
	ldr	r1, .L47+8
	bl	fopen
	subs	sl, r0, #0
	beq	.L46
	ldr	r5, .L47+12
	mov	r1, #4
	mov	r2, #1
	mov	r3, sl
	mov	r0, r5
	ldr	r8, .L47+16
	bl	fwrite
	ldr	ip, [r5, #4]
	mov	r1, #4
	mov	r7, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	ip, [r8, #0]
	strb	r4, [r8, #1]
	strb	r6, [r8, #2]
	strb	r7, [r8, #3]
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, sl
	add	r0, r5, #8
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, sl
	add	r0, r5, #12
	bl	fwrite
	ldr	ip, [r5, #16]
	mov	r1, #4
	mov	r7, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	r4, [r8, #1]
	strb	r6, [r8, #2]
	strb	r7, [r8, #3]
	strb	ip, [r8, #0]
	bl	fwrite
	ldrb	ip, [r5, #20]	@ zero_extendqisi2
	mov	r1, #2
	mov	r2, #1
	mov	r3, sl
	mov	r9, #0
	mov	r0, r8
	strb	ip, [r8, #0]
	strb	r9, [r8, #1]
	bl	fwrite
	ldrh	ip, [r5, #22]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	r4, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldr	ip, [r5, #24]
	mov	r1, #4
	mov	r7, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	r4, [r8, #1]
	strb	r6, [r8, #2]
	strb	r7, [r8, #3]
	strb	ip, [r8, #0]
	bl	fwrite
	ldr	ip, [r5, #28]
	mov	r1, #4
	mov	r4, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r7, ip, lsr #24
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	r4, [r8, #1]
	strb	r6, [r8, #2]
	strb	ip, [r8, #0]
	strb	r7, [r8, #3]
	bl	fwrite
	ldrh	ip, [r5, #32]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	r4, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldrh	ip, [r5, #34]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, sl
	mov	r0, r8
	strb	ip, [r8, #0]
	strb	r4, [r8, #1]
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, sl
	add	r0, r5, #36
	bl	fwrite
	ldr	ip, [r5, #40]
	mov	r3, sl
	mov	r4, ip, lsr #8
	mov	r6, ip, lsr #24
	mov	r5, ip, lsr #16
	mov	r0, r8
	mov	r1, #4
	mov	r2, #1
	strb	r4, [r8, #1]
	strb	r5, [r8, #2]
	strb	r6, [r8, #3]
	strb	ip, [r8, #0]
	bl	fwrite
	ldr	r3, .L47+20
	ldr	r4, [r3, #0]
	cmp	r4, r9
	beq	.L42
	ldr	r6, .L47+24
	mov	r5, r9
.L43:
	ldr	r3, [r6, #44]
	ldrb	ip, [r3, r4]	@ zero_extendqisi2
	ldr	r0, .L47+16
	mov	r1, #2
	mov	r2, #1
	mov	r3, sl
	strb	ip, [r8, #0]
	strb	r5, [r8, #1]
	bl	fwrite
	subs	r4, r4, #1
	bne	.L43
.L42:
	mov	r0, sl
	bl	fclose
	ldr	r0, .L47+28
	bl	puts
.L44:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L46:
	ldr	r0, .L47+32
	bl	puts
	b	.L44
.L48:
	.align	2
.L47:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	wave
	.word	data_array
	.word	numSamples
	.word	cwave
	.word	.LC4
	.word	.LC3
	.size	generate_compressed_file, .-generate_compressed_file
	.align	2
	.global	generate_decompressed_file
	.type	generate_decompressed_file, %function
generate_decompressed_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r0, .L57
	bl	puts
	ldr	r0, .L57+4
	ldr	r1, .L57+8
	bl	fopen
	subs	r8, r0, #0
	beq	.L56
	ldr	sl, .L57+12
	mov	r1, #4
	mov	r2, #1
	mov	r3, r8
	mov	r0, sl
	ldr	r7, .L57+16
	bl	fwrite
	ldr	ip, [sl, #4]
	mov	r1, #4
	mov	r6, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r5, ip, lsr #16
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	ip, [r7, #0]
	strb	r4, [r7, #1]
	strb	r5, [r7, #2]
	strb	r6, [r7, #3]
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, r8
	add	r0, sl, #8
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, r8
	add	r0, sl, #12
	bl	fwrite
	ldr	ip, [sl, #16]
	mov	r1, #4
	mov	r6, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r5, ip, lsr #16
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #1]
	strb	r5, [r7, #2]
	strb	r6, [r7, #3]
	strb	ip, [r7, #0]
	bl	fwrite
	ldrb	r4, [sl, #20]	@ zero_extendqisi2
	mov	ip, #0
	mov	r1, #2
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #0]
	strb	ip, [r7, #1]
	bl	fwrite
	ldrh	ip, [sl, #22]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #1]
	strb	ip, [r7, #0]
	bl	fwrite
	ldr	ip, [sl, #24]
	mov	r1, #4
	mov	r6, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r5, ip, lsr #16
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #1]
	strb	r5, [r7, #2]
	strb	r6, [r7, #3]
	strb	ip, [r7, #0]
	bl	fwrite
	ldr	ip, [sl, #28]
	mov	r1, #4
	mov	r6, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r5, ip, lsr #16
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #1]
	strb	r5, [r7, #2]
	strb	r6, [r7, #3]
	strb	ip, [r7, #0]
	bl	fwrite
	ldrh	ip, [sl, #32]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	r4, [r7, #1]
	strb	ip, [r7, #0]
	bl	fwrite
	ldrh	ip, [sl, #34]
	mov	r1, #2
	mov	r4, ip, lsr #8
	mov	r2, #1
	mov	r3, r8
	mov	r0, r7
	strb	ip, [r7, #0]
	strb	r4, [r7, #1]
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	mov	r3, r8
	add	r0, sl, #36
	bl	fwrite
	ldr	ip, [sl, #40]
	mov	r3, r8
	mov	r5, ip, lsr #16
	mov	r6, ip, lsr #24
	mov	r4, ip, lsr #8
	mov	r0, r7
	mov	r1, #4
	mov	r2, #1
	strb	r5, [r7, #2]
	strb	r4, [r7, #1]
	strb	r6, [r7, #3]
	strb	ip, [r7, #0]
	bl	fwrite
	ldr	r3, .L57+20
	ldr	r5, [r3, #0]
	cmp	r5, #0
	beq	.L52
	ldr	r6, .L57+24
	mov	r4, r5, asl #1
.L53:
	ldr	r3, [sl, #44]
	ldrh	ip, [r3, r4]
	ldr	r0, .L57+16
	mov	lr, ip, lsr #8
	ldr	r1, [r6, #0]
	mov	r2, #1
	mov	r3, r8
	strb	lr, [r7, #1]
	strb	ip, [r7, #0]
	bl	fwrite
	subs	r5, r5, #1
	sub	r4, r4, #2
	bne	.L53
.L52:
	mov	r0, r8
	bl	fclose
	ldr	r0, .L57+28
	bl	puts
.L54:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L56:
	ldr	r0, .L57+32
	bl	puts
	b	.L54
.L58:
	.align	2
.L57:
	.word	.LC5
	.word	.LC6
	.word	.LC2
	.word	wave
	.word	data_array
	.word	numSamples
	.word	sizeOfEachSample
	.word	.LC7
	.word	.LC3
	.size	generate_decompressed_file, .-generate_decompressed_file
	.align	2
	.global	display_samples
	.type	display_samples, %function
display_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r6, .L64
	ldr	r0, .L64+4
	bl	puts
	ldr	r3, [r6, #0]
	cmp	r3, #0
	beq	.L62
	mov	r4, #0
	ldr	r5, .L64+8
	mov	r1, r4
.L61:
	ldr	r3, [r5, #44]
	mov	r1, r1, asl #1
	ldrsh	r2, [r3, r1]
	ldr	r0, .L64+12
	mov	r1, r4
	bl	printf
	ldr	r3, [r6, #0]
	add	r4, r4, #1
	cmp	r4, r3
	mov	r1, r4
	bcc	.L61
.L62:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L65:
	.align	2
.L64:
	.word	numSamples
	.word	.LC8
	.word	wave
	.word	.LC9
	.size	display_samples, .-display_samples
	.global	__aeabi_uidiv
	.align	2
	.global	read_wave_file_data_samples
	.type	read_wave_file_data_samples, %function
read_wave_file_data_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r7, .L75
	ldrb	r3, [r7, #20]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L67
	ldr	r0, .L75+4
	bl	puts
	ldrh	r2, [r7, #22]
	ldrh	r3, [r7, #34]
	ldr	r0, [r7, #40]
	mul	r1, r3, r2
	mov	r0, r0, asl #3
	bl	__aeabi_uidiv
	ldr	r4, .L75+8
	mov	r3, r0
	mov	r1, r0
	str	r3, [r4, #0]
	ldr	r0, .L75+12
	bl	printf
	ldrh	r1, [r7, #22]
	ldrh	r3, [r7, #34]
	mul	r2, r3, r1
	ldr	r8, .L75+16
	mov	r2, r2, asr #3
	mov	r1, r2
	ldr	r0, .L75+20
	str	r2, [r8, #0]
	bl	printf
	ldr	r0, [r4, #0]
	ldr	r1, [r8, #0]
	bl	calloc
	cmp	r0, #0
	str	r0, [r7, #44]
	beq	.L74
	ldr	r5, [r4, #0]
	cmp	r5, #0
	beq	.L70
	ldr	r6, .L75+24
	ldr	sl, .L75+28
	mov	r4, r5, asl #1
.L71:
	ldr	r1, [r8, #0]
	mov	r2, #1
	ldr	r3, [sl, #0]
	ldr	r0, .L75+24
	bl	fread
	ldrb	r3, [r6, #1]	@ zero_extendqisi2
	ldrb	r2, [r6, #0]	@ zero_extendqisi2
	ldr	r1, [r7, #44]
	orr	r2, r2, r3, asl #8
	subs	r5, r5, #1
	strh	r2, [r1, r4]	@ movhi
	sub	r4, r4, #2
	bne	.L71
.L70:
	ldr	r0, .L75+32
	bl	puts
.L72:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L74:
	ldr	r0, .L75+36
	bl	puts
	b	.L72
.L67:
	ldr	r0, .L75+40
	bl	printf
	mov	r0, #1
	bl	exit
.L76:
	.align	2
.L75:
	.word	wave
	.word	.LC10
	.word	numSamples
	.word	.LC11
	.word	sizeOfEachSample
	.word	.LC12
	.word	data_array
	.word	fp
	.word	.LC14
	.word	.LC13
	.word	.LC15
	.size	read_wave_file_data_samples, .-read_wave_file_data_samples
	.align	2
	.global	read_wave_file_headers
	.type	read_wave_file_headers, %function
read_wave_file_headers:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r8, .L82
	ldr	r6, .L82+4
	ldr	r5, .L82+8
	ldr	r0, .L82+12
	bl	puts
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r8
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	add	r0, r8, #8
	str	ip, [r8, #4]
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	add	r0, r8, #12
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	str	ip, [r8, #16]
	bl	fread
	ldrb	ip, [r5, #0]	@ zero_extendqisi2
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	strb	ip, [r8, #20]
	bl	fread
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5, #0]	@ zero_extendqisi2
	mov	r1, #4
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	strh	ip, [r8, #22]	@ movhi
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	str	ip, [r8, #24]
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	str	ip, [r8, #28]
	bl	fread
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5, #0]	@ zero_extendqisi2
	mov	r1, #2
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	strh	ip, [r8, #32]	@ movhi
	bl	fread
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5, #0]	@ zero_extendqisi2
	mov	r1, #4
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r0, r5
	strh	ip, [r8, #34]	@ movhi
	bl	fread
	mov	r0, r5
	ldr	r1, .L82+16
	bl	strcmp
	cmp	r0, #0
	ldr	r3, [r8, #4]
	beq	.L78
	cmp	r3, #40
	bmi	.L78
	sub	r4, r3, #41
	mov	r7, r6
	b	.L79
.L81:
	ldr	r0, [r7, #0]
	bl	fseek
	cmn	r4, #1
	sub	r4, r4, #1
	beq	.L78
.L79:
	mov	r2, #1
	ldr	r3, [r6, #0]
	mov	r1, #4
	ldr	r0, .L82+8
	bl	fread
	ldr	r1, .L82+16
	ldr	r0, .L82+8
	bl	strcmp
	cmp	r0, #0
	mvn	r1, #2
	mov	r2, #1
	bne	.L81
.L78:
	ldr	r1, .L82+8
	ldr	r0, .L82+20
	bl	strcpy
	ldr	r3, [r6, #0]
	mov	r1, #4
	mov	r2, #1
	ldr	r0, .L82+8
	bl	fread
	ldrb	r3, [r5, #2]	@ zero_extendqisi2
	ldrb	r1, [r5, #1]	@ zero_extendqisi2
	ldrb	r0, [r5, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r3, r3, r1, asl #8
	ldrb	r2, [r5, #3]	@ zero_extendqisi2
	orr	r3, r3, r0
	orr	r3, r3, r2, asl #24
	ldr	r0, .L82+24
	str	r3, [r8, #40]
	bl	puts
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L83:
	.align	2
.L82:
	.word	wave
	.word	fp
	.word	data_array
	.word	.LC16
	.word	.LC17
	.word	wave+36
	.word	.LC18
	.size	read_wave_file_headers, .-read_wave_file_headers
	.align	2
	.global	read_wave_file
	.type	read_wave_file, %function
read_wave_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	bl	read_wave_file_headers
	ldmfd	sp!, {r4, lr}
	b	read_wave_file_data_samples
	.size	read_wave_file, .-read_wave_file
	.align	2
	.global	compress_samples
	.type	compress_samples, %function
compress_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r0, #10
	ldr	r4, .L105
	bl	putchar
	ldr	r0, .L105+4
	bl	puts
	ldr	r0, [r4, #0]
	bl	malloc
	ldr	r5, .L105+8
	cmp	r0, #0
	str	r0, [r5, #44]
	beq	.L87
	ldr	r3, [r4, #0]
	cmp	r3, #0
	movne	r0, #0
	ldrne	r6, .L105+12
	movne	ip, r0
	beq	.L89
.L101:
	ldr	r1, [r6, #44]
	mov	r2, ip, asl #1
	ldrsh	r3, [r1, r2]
	mov	r3, r3, asl #14
	mov	r3, r3, lsr #16
	mov	lr, r3, asl #16
	mov	r2, lr, asr #16
	cmp	r2, #0
	rsblt	r2, r2, #0
	mov	r2, r2, asl #16
	mov	r1, r2, lsr #16
	tst	r1, #32
	movne	r3, #5
	bne	.L92
	tst	r1, #64
	movne	r3, #6
	bne	.L92
	tst	r1, #128
	movne	r3, #7
	bne	.L92
	tst	r1, #256
	movne	r3, #8
	bne	.L92
	tst	r1, #512
	movne	r3, #9
	bne	.L92
	tst	r1, #1024
	movne	r3, #10
	bne	.L92
	tst	r1, #2048
	movne	r3, #11
	bne	.L92
	ands	r3, r1, #4096
	moveq	r2, r3
	bne	.L104
.L100:
	mov	r3, lr, asr #16
	mvn	r3, r3
	mov	r3, r3, lsr #31
	orr	r3, r2, r3, asl #7
	orr	r3, r3, r1
	ldr	r2, [r5, #44]
	mvn	r3, r3
	strb	r3, [r2, ip]
	ldr	r1, [r4, #0]
	add	r0, r0, #1
	cmp	r1, r0
	mov	ip, r0
	bhi	.L101
.L89:
	ldr	r0, .L105+16
	bl	puts
.L102:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L104:
	mov	r3, #12
.L92:
	sub	r2, r3, #4
	mov	r2, r1, asr r2
	sub	r3, r3, #5
	mov	r3, r3, asl #4
	and	r1, r2, #15
	and	r2, r3, #255
	b	.L100
.L87:
	ldr	r0, .L105+20
	bl	puts
	b	.L102
.L106:
	.align	2
.L105:
	.word	numSamples
	.word	.LC19
	.word	cwave
	.word	wave
	.word	.LC21
	.word	.LC20
	.size	compress_samples, .-compress_samples
	.align	2
	.global	decompress_samples
	.type	decompress_samples, %function
decompress_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r0, #10
	bl	putchar
	ldr	r0, .L124
	bl	puts
	ldr	r3, .L124+4
	ldr	lr, [r3, #0]
	cmp	lr, #0
	beq	.L108
	mov	r0, #0
	ldr	r5, .L124+8
	ldr	r4, .L124+12
	mov	ip, r0
.L121:
	ldr	r3, [r5, #44]
	ldrb	r2, [r3, ip]	@ zero_extendqisi2
	mvn	r2, r2
	and	r3, r2, #112
	mov	r3, r3, asr #4
	sub	r3, r3, #1
	and	r1, r2, #255
	and	r2, r2, #15
	cmp	r3, #6
	ldrls	pc, [pc, r3, asl #2]
	b	.L109
.L117:
	.word	.L110
	.word	.L111
	.word	.L112
	.word	.L113
	.word	.L114
	.word	.L115
	.word	.L116
.L109:
	mov	r3, r2, asl #1
	orr	r2, r3, #33
.L118:
	sub	r3, r2, #33
	mov	r3, r3, asl #16
	movs	r1, r1, lsr #7
	mov	r2, r3, lsr #16
	rsbeq	r3, r2, #0
	moveq	r3, r3, asl #16
	movne	r3, r2
	moveq	r3, r3, lsr #16
	add	r0, r0, #1
	ldr	r1, [r4, #44]
	mov	r2, ip, asl #1
	mov	r3, r3, asl #2
	cmp	r0, lr
	strh	r3, [r1, r2]	@ movhi
	mov	ip, r0
	bcc	.L121
.L108:
	ldr	r0, .L124+16
	bl	puts
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L116:
	mov	r3, r2, asl #8
	orr	r2, r3, #4224
	b	.L118
.L115:
	mov	r3, r2, asl #7
	orr	r2, r3, #2112
	b	.L118
.L114:
	mov	r3, r2, asl #6
	orr	r2, r3, #1056
	b	.L118
.L113:
	mov	r3, r2, asl #5
	orr	r2, r3, #528
	b	.L118
.L112:
	mov	r3, r2, asl #4
	orr	r2, r3, #264
	b	.L118
.L111:
	mov	r3, r2, asl #3
	orr	r2, r3, #132
	b	.L118
.L110:
	mov	r3, r2, asl #2
	orr	r2, r3, #66
	b	.L118
.L125:
	.align	2
.L124:
	.word	.LC22
	.word	numSamples
	.word	cwave
	.word	wave
	.word	.LC23
	.size	decompress_samples, .-decompress_samples
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #1
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r4, r1
	ble	.L147
	ldr	r1, [r1, #4]
	ldr	r0, .L150
	bl	printf
	ldr	r0, [r4, #4]
	ldr	r1, .L150+4
	bl	fopen
	ldr	r3, .L150+8
	cmp	r0, #0
	str	r0, [r3, #0]
	beq	.L148
.L129:
	bl	read_wave_file_headers
	bl	read_wave_file_data_samples
	bl	clock
	ldr	r7, .L150+12
	ldr	r4, .L150+16
	str	r0, [r7, #0]
	mov	r0, #10
	bl	putchar
	ldr	r0, .L150+20
	bl	puts
	ldr	r0, [r4, #0]
	bl	malloc
	ldr	r6, .L150+24
	cmp	r0, #0
	str	r0, [r6, #44]
	beq	.L130
	ldr	r3, [r4, #0]
	cmp	r3, #0
	movne	r0, #0
	ldrne	r5, .L150+28
	movne	ip, r0
	beq	.L132
.L144:
	ldr	r1, [r5, #44]
	mov	r2, ip, asl #1
	ldrsh	r3, [r1, r2]
	mov	r3, r3, asl #14
	mov	r3, r3, lsr #16
	mov	lr, r3, asl #16
	mov	r2, lr, asr #16
	cmp	r2, #0
	rsblt	r2, r2, #0
	mov	r2, r2, asl #16
	mov	r1, r2, lsr #16
	tst	r1, #32
	movne	r3, #5
	bne	.L135
	tst	r1, #64
	movne	r3, #6
	bne	.L135
	tst	r1, #128
	movne	r3, #7
	bne	.L135
	tst	r1, #256
	movne	r3, #8
	bne	.L135
	tst	r1, #512
	movne	r3, #9
	bne	.L135
	tst	r1, #1024
	movne	r3, #10
	bne	.L135
	tst	r1, #2048
	movne	r3, #11
	bne	.L135
	ands	r3, r1, #4096
	moveq	r2, r3
	bne	.L149
.L143:
	mov	r3, lr, asr #16
	mvn	r3, r3
	mov	r3, r3, lsr #31
	orr	r3, r2, r3, asl #7
	orr	r3, r3, r1
	ldr	r2, [r6, #44]
	mvn	r3, r3
	strb	r3, [r2, ip]
	ldr	r1, [r4, #0]
	add	r0, r0, #1
	cmp	r1, r0
	mov	ip, r0
	bhi	.L144
.L132:
	ldr	r0, .L150+32
	bl	puts
.L133:
	bl	clock
	ldr	r4, .L150+36
	mov	r3, r0
	ldr	r0, [r7, #0]
	str	r3, [r4, #0]
	rsb	r0, r0, r3
	bl	__aeabi_i2d
	mov	r3, #1090519040
	add	r3, r3, #3047424
	mov	r2, #0
	add	r3, r3, #1152
	bl	__aeabi_ddiv
	ldr	r5, .L150+40
	stmia	r5, {r0-r1}
	bl	clock
	str	r0, [r7, #0]
	bl	decompress_samples
	bl	clock
	mov	r3, r0
	ldr	r0, [r7, #0]
	str	r3, [r4, #0]
	rsb	r0, r0, r3
	bl	__aeabi_i2d
	mov	r3, #1090519040
	add	r3, r3, #3047424
	mov	r2, #0
	add	r3, r3, #1152
	bl	__aeabi_ddiv
	ldr	r4, .L150+44
	ldmia	r5, {r2-r3}
	stmia	r4, {r0-r1}
	ldr	r0, .L150+48
	bl	printf
	ldmia	r4, {r2-r3}
	ldr	r0, .L150+52
	bl	printf
	bl	generate_compressed_file
	bl	generate_decompressed_file
	mov	r0, #0
.L128:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L149:
	mov	r3, #12
.L135:
	sub	r2, r3, #4
	mov	r2, r1, asr r2
	sub	r3, r3, #5
	mov	r3, r3, asl #4
	and	r1, r2, #15
	and	r2, r3, #255
	b	.L143
.L147:
	ldr	r0, .L150+56
	bl	perror
	ldr	r0, .L150+56
	bl	printf
	b	.L128
.L148:
	ldr	r1, [r4, #4]
	ldr	r0, .L150+60
	bl	printf
	b	.L129
.L130:
	ldr	r0, .L150+64
	bl	puts
	b	.L133
.L151:
	.align	2
.L150:
	.word	.LC25
	.word	.LC26
	.word	fp
	.word	start
	.word	numSamples
	.word	.LC19
	.word	cwave
	.word	wave
	.word	.LC21
	.word	stop
	.word	compression_time
	.word	decompression_time
	.word	.LC28
	.word	.LC29
	.word	.LC24
	.word	.LC27
	.word	.LC20
	.size	main, .-main
	.comm	fp,4,4
	.comm	wave,48,4
	.comm	cwave,48,4
	.comm	data_array,4,4
	.comm	numSamples,4,4
	.comm	sizeOfEachSample,4,4
	.comm	start,4,4
	.comm	stop,4,4
	.comm	compression_time,8,8
	.comm	decompression_time,8,8
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Generating compressed audio to compressed_output.wa"
	.ascii	"v\012\000"
	.space	2
.LC1:
	.ascii	"compressed_output.wav\000"
	.space	2
.LC2:
	.ascii	"w\000"
	.space	2
.LC3:
	.ascii	"File write failed!\012\000"
.LC4:
	.ascii	"Output Generated -- compressed_output.wav\012\000"
	.space	1
.LC5:
	.ascii	"Generating decompressed audio to output.wav\012\000"
	.space	3
.LC6:
	.ascii	"output.wav\000"
	.space	1
.LC7:
	.ascii	"Output Generated -- output.wav\012\000"
.LC8:
	.ascii	"Wave Samples...\012\000"
	.space	3
.LC9:
	.ascii	"Sample %d : %hhx\012\000"
	.space	2
.LC10:
	.ascii	"Reading PCM Data:\011\011 STARTED\000"
.LC11:
	.ascii	"\011Number of Samples:\011%  lu\012\000"
	.space	1
.LC12:
	.ascii	"\011Size of Each Sample:\011%    lu\012\000"
	.space	1
.LC13:
	.ascii	"\011Could not allocate enough memory to read data s"
	.ascii	"amples\000"
	.space	1
.LC14:
	.ascii	"Reading PCM data:\011\011Complete\000"
.LC15:
	.ascii	"\011Only use PCM data format please!\000"
	.space	2
.LC16:
	.ascii	"\012Reading Wave Headers:\011\011 STARTED\000"
	.space	3
.LC17:
	.ascii	"data\000"
	.space	3
.LC18:
	.ascii	"Reading Wave Headers:\011\011COMPLETED\012\000"
	.space	2
.LC19:
	.ascii	"Start audio Compression...\012\000"
.LC20:
	.ascii	"Memory allocation failed.\000"
	.space	2
.LC21:
	.ascii	"Audio compression successful\012\000"
	.space	2
.LC22:
	.ascii	"Start audio Decompression...\012\000"
	.space	2
.LC23:
	.ascii	"Audio decompression successful\012\000"
.LC24:
	.ascii	"\012Please input a .wav file\012\000"
	.space	1
.LC25:
	.ascii	"\012Input .wav Filename:\011\011%s\012\000"
	.space	1
.LC26:
	.ascii	"rb\000"
	.space	1
.LC27:
	.ascii	"Error opening .wav file %s\000"
	.space	1
.LC28:
	.ascii	"Compression Time:\011\011%fs sec\012\000"
.LC29:
	.ascii	"Decompression Time:\011%fs sec\012\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
