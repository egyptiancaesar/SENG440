	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"main.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"\012Please input a .wav file\012\000"
	.align	2
.LC1:
	.ascii	"\012Input .wav Filename:\011\011%s\012\000"
	.align	2
.LC2:
	.ascii	"rb\000"
	.align	2
.LC3:
	.ascii	"Error opening .wav file %s\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bgt	.L2
	ldr	r0, .L6
	bl	perror
	ldr	r0, .L6
	bl	printf
	mov	r3, r0
	str	r3, [fp, #-16]
	b	.L3
.L2:
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L6+4
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	ldr	r1, .L6+8
	bl	fopen
	mov	r2, r0
	ldr	r3, .L6+12
	str	r2, [r3, #0]
	ldr	r3, .L6+12
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L4
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L6+16
	mov	r1, r3
	bl	printf
.L4:
	bl	read_wave_file
	bl	compress_samples
	bl	decompress_samples
	bl	generate_compressed_file
	bl	generate_decompressed_file
	mov	r3, #0
	str	r3, [fp, #-16]
.L3:
	ldr	r3, [fp, #-16]
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	fp
	.word	.LC3
	.size	main, .-main
	.section	.rodata
	.align	2
.LC4:
	.ascii	"\012Reading Wave Headers:\011\011 STARTED\000"
	.align	2
.LC5:
	.ascii	"data\000"
	.align	2
.LC6:
	.ascii	"Reading Wave Headers:\011\011COMPLETED\012\000"
	.text
	.align	2
	.global	read_wave_file_headers
	.type	read_wave_file_headers, %function
read_wave_file_headers:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L13
	bl	puts
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L13+8
	str	r2, [r3, #4]
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+20
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L13+8
	str	r2, [r3, #16]
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	and	r3, r3, #255
	orr	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	ldr	r2, .L13+8
	strb	r3, [r2, #20]
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, .L13+8
	strh	r2, [r3, #22]	@ movhi
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L13+8
	str	r2, [r3, #24]
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L13+8
	str	r2, [r3, #28]
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, .L13+8
	strh	r2, [r3, #32]	@ movhi
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, .L13+8
	strh	r2, [r3, #34]	@ movhi
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L13+12
	ldr	r1, .L13+24
	bl	strcmp
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, .L13+8
	ldr	r3, [r3, #4]
	sub	r3, r3, #40
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	beq	.L9
	b	.L10
.L11:
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L13+12
	ldr	r1, .L13+24
	bl	strcmp
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	beq	.L9
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	mov	r0, r3
	mvn	r1, #2
	mov	r2, #1
	bl	fseek
.L10:
	ldr	r3, [fp, #-8]
	mvn	r3, r3
	mov	r3, r3, lsr #31
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
	cmp	r2, #0
	bne	.L11
.L9:
	ldr	r0, .L13+28
	ldr	r1, .L13+12
	bl	strcpy
	ldr	r3, .L13+4
	ldr	r3, [r3, #0]
	ldr	r0, .L13+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L13+12
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L13+12
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L13+8
	str	r2, [r3, #40]
	ldr	r0, .L13+32
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	.LC4
	.word	fp
	.word	wave
	.word	data_array
	.word	wave+8
	.word	wave+12
	.word	.LC5
	.word	wave+36
	.word	.LC6
	.size	read_wave_file_headers, .-read_wave_file_headers
	.section	.rodata
	.align	2
.LC7:
	.ascii	"Reading PCM Data:\011\011 STARTED\000"
	.global	__aeabi_uidiv
	.align	2
.LC8:
	.ascii	"\011Number of Samples:\011%  lu\012\000"
	.align	2
.LC9:
	.ascii	"\011Size of Each Sample:\011%    lu\012\000"
	.align	2
.LC10:
	.ascii	"\011Could not allocate enough memory to read data s"
	.ascii	"amples\000"
	.align	2
.LC11:
	.ascii	"Reading PCM data:\011\011Complete\000"
	.align	2
.LC12:
	.ascii	"\011Only use PCM data format please!\000"
	.text
	.align	2
	.global	read_wave_file_data_samples
	.type	read_wave_file_data_samples, %function
read_wave_file_data_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L22
	ldrb	r3, [r3, #20]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L16
	ldr	r0, .L22+4
	bl	puts
	ldr	r3, .L22
	ldr	r3, [r3, #40]
	mov	r1, r3, asl #3
	ldr	r3, .L22
	ldrh	r3, [r3, #34]
	mov	r2, r3
	ldr	r3, .L22
	ldrh	r3, [r3, #22]
	mul	r3, r2, r3
	mov	r0, r1
	mov	r1, r3
	bl	__aeabi_uidiv
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+8
	str	r2, [r3, #0]
	ldr	r3, .L22+8
	ldr	r3, [r3, #0]
	ldr	r0, .L22+12
	mov	r1, r3
	bl	printf
	ldr	r3, .L22
	ldrh	r3, [r3, #34]
	mov	r2, r3
	ldr	r3, .L22
	ldrh	r3, [r3, #22]
	mul	r3, r2, r3
	add	r2, r3, #7
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #3
	mov	r2, r3
	ldr	r3, .L22+16
	str	r2, [r3, #0]
	ldr	r3, .L22+16
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, r3
	bl	printf
	ldr	r3, .L22+8
	ldr	r2, [r3, #0]
	ldr	r3, .L22+16
	ldr	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22
	str	r2, [r3, #44]
	ldr	r3, .L22+8
	ldr	r2, [r3, #0]
	ldr	r3, .L22+16
	ldr	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+24
	str	r2, [r3, #44]
	ldr	r3, .L22
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L17
	ldr	r0, .L22+28
	bl	puts
	b	.L21
.L17:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L19
.L20:
	ldr	r3, .L22+16
	ldr	r2, [r3, #0]
	ldr	r3, .L22+32
	ldr	r3, [r3, #0]
	ldr	r0, .L22+36
	mov	r1, r2
	mov	r2, #1
	bl	fread
	ldr	r3, .L22
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r1, r2, r3
	ldr	r3, .L22+36
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L22+36
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r1, #0]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L19:
	ldr	r3, [fp, #-8]
	ldr	r2, .L22+8
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L20
	ldr	r0, .L22+40
	bl	puts
	b	.L21
.L16:
	ldr	r0, .L22+44
	bl	printf
	mov	r0, #1
	bl	exit
.L21:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L23:
	.align	2
.L22:
	.word	wave
	.word	.LC7
	.word	numSamples
	.word	.LC8
	.word	sizeOfEachSample
	.word	.LC9
	.word	dwave
	.word	.LC10
	.word	fp
	.word	data_array
	.word	.LC11
	.word	.LC12
	.size	read_wave_file_data_samples, .-read_wave_file_data_samples
	.align	2
	.global	read_wave_file
	.type	read_wave_file, %function
read_wave_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	bl	read_wave_file_headers
	bl	read_wave_file_data_samples
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
	.size	read_wave_file, .-read_wave_file
	.section	.rodata
	.align	2
.LC13:
	.ascii	"Wave Samples...\012\000"
	.align	2
.LC14:
	.ascii	"Sample %d : %hhx\012\000"
	.text
	.align	2
	.global	display_samples
	.type	display_samples, %function
display_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L30
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L27
.L28:
	ldr	r3, .L30+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	ldr	r0, .L30+8
	ldr	r1, [fp, #-8]
	mov	r2, r3
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L27:
	ldr	r3, [fp, #-8]
	ldr	r2, .L30+12
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L28
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L31:
	.align	2
.L30:
	.word	.LC13
	.word	wave
	.word	.LC14
	.word	numSamples
	.size	display_samples, .-display_samples
	.section	.rodata
	.align	2
.LC15:
	.ascii	"Start audio Compression...\012\000"
	.align	2
.LC16:
	.ascii	"Memory allocation failed.\000"
	.align	2
.LC17:
	.ascii	"Audio compression successful\012\000"
	.text
	.align	2
	.global	compress_samples
	.type	compress_samples, %function
compress_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r0, #10
	bl	putchar
	ldr	r0, .L38
	bl	puts
	ldr	r3, .L38+4
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L38+8
	str	r2, [r3, #44]
	ldr	r3, .L38+8
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L33
	ldr	r0, .L38+12
	bl	puts
	b	.L37
.L33:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L35
.L36:
	ldr	r3, .L38+16
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asr #2
	strh	r3, [fp, #-18]	@ movhi
	ldrsh	r3, [fp, #-18]
	mov	r0, r3
	bl	sign
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-16]	@ movhi
	ldrsh	r3, [fp, #-18]
	mov	r0, r3
	bl	magnitude
	mov	r3, r0
	strh	r3, [fp, #-14]	@ movhi
	ldrh	r3, [fp, #-14]	@ movhi
	add	r3, r3, #33
	strh	r3, [fp, #-12]	@ movhi
	ldrsh	r3, [fp, #-16]
	ldrh	r2, [fp, #-14]
	mov	r0, r3
	mov	r1, r2
	bl	codeword
	mov	r3, r0
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]
	mvn	r3, r3
	strb	r3, [fp, #-9]
	ldr	r3, .L38+8
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r2, r2, r3
	ldrb	r3, [fp, #-9]
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L35:
	ldr	r3, [fp, #-8]
	ldr	r2, .L38+4
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L36
	ldr	r0, .L38+20
	bl	puts
.L37:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L39:
	.align	2
.L38:
	.word	.LC15
	.word	numSamples
	.word	cwave
	.word	.LC16
	.word	wave
	.word	.LC17
	.size	compress_samples, .-compress_samples
	.section	.rodata
	.align	2
.LC18:
	.ascii	"Start audio Decompression...\012\000"
	.align	2
.LC19:
	.ascii	"Audio decompression successful\012\000"
	.text
	.align	2
	.global	decompress_samples
	.type	decompress_samples, %function
decompress_samples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r0, #10
	bl	putchar
	ldr	r0, .L46
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L41
.L44:
	ldr	r3, .L46+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]
	mvn	r3, r3
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mov	r0, r3
	bl	codewordToMagnitude
	mov	r3, r0
	strh	r3, [fp, #-12]	@ movhi
	ldrh	r3, [fp, #-12]	@ movhi
	sub	r3, r3, #33
	strh	r3, [fp, #-14]	@ movhi
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mov	r3, r3, lsr #7
	and	r3, r3, #255
	strh	r3, [fp, #-16]	@ movhi
	ldrsh	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L42
	ldrh	r3, [fp, #-14]	@ movhi
	strh	r3, [fp, #-18]	@ movhi
	b	.L43
.L42:
	ldrh	r3, [fp, #-14]
	rsb	r3, r3, #0
	strh	r3, [fp, #-18]	@ movhi
.L43:
	ldr	r3, .L46+8
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r2, r2, r3
	ldrsh	r3, [fp, #-18]
	mov	r3, r3, asl #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r2, #0]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L41:
	ldr	r3, [fp, #-8]
	ldr	r2, .L46+12
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L44
	ldr	r0, .L46+16
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L47:
	.align	2
.L46:
	.word	.LC18
	.word	cwave
	.word	dwave
	.word	numSamples
	.word	.LC19
	.size	decompress_samples, .-decompress_samples
	.align	2
	.global	codewordToMagnitude
	.type	codewordToMagnitude, %function
codewordToMagnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	mov	r3, r0
	strb	r3, [fp, #-21]
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	and	r3, r3, #112
	mov	r3, r3, asr #4
	str	r3, [fp, #-20]
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	and	r3, r3, #15
	str	r3, [fp, #-16]
	mov	r3, #12
	str	r3, [fp, #-8]
	b	.L49
.L51:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #5
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L50
	ldr	r3, [fp, #-8]
	sub	r2, r3, #5
	mov	r3, #1
	mov	r1, r3, asl r2
	ldr	r3, [fp, #-8]
	sub	r2, r3, #4
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl r2
	orr	r1, r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-8]
	mov	r3, r2, asl r3
	orr	r3, r1, r3
	str	r3, [fp, #-12]
.L50:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
.L49:
	ldr	r3, [fp, #-8]
	cmp	r3, #4
	bgt	.L51
	ldr	r3, [fp, #-12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codewordToMagnitude, .-codewordToMagnitude
	.align	2
	.global	sign
	.type	sign, %function
sign:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmp	r3, #0
	bge	.L54
	mov	r2, #0
	str	r2, [fp, #-12]
	b	.L55
.L54:
	mov	r3, #1
	str	r3, [fp, #-12]
.L55:
	ldr	r2, [fp, #-12]
	mov	r3, r2, asl #16
	mov	r3, r3, asr #16
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	sign, .-sign
	.align	2
	.global	magnitude
	.type	magnitude, %function
magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmp	r3, #0
	bge	.L58
	ldrh	r3, [fp, #-6]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-6]	@ movhi
.L58:
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword
	.type	codeword, %function
codeword:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #36
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-30]	@ movhi
	strh	r2, [fp, #-32]	@ movhi
	ldrh	r3, [fp, #-32]
	str	r3, [fp, #-20]
	mov	r3, #12
	str	r3, [fp, #-12]
	b	.L61
.L64:
	ldrh	r2, [fp, #-32]
	ldr	r3, [fp, #-12]
	mov	r3, r2, asr r3
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L62
	ldr	r3, [fp, #-12]
	sub	r3, r3, #5
	str	r3, [fp, #-24]
	ldrh	r2, [fp, #-32]
	ldr	r3, [fp, #-12]
	sub	r3, r3, #4
	mov	r3, r2, asr r3
	and	r3, r3, #15
	str	r3, [fp, #-20]
	b	.L63
.L62:
	ldr	r3, [fp, #-12]
	sub	r3, r3, #1
	str	r3, [fp, #-12]
.L61:
	ldr	r3, [fp, #-12]
	cmp	r3, #4
	bgt	.L64
.L63:
	ldrsh	r3, [fp, #-30]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #4
	orr	r2, r2, r3
	ldr	r3, [fp, #-20]
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	strb	r3, [fp, #-13]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codeword, .-codeword
	.section	.rodata
	.align	2
.LC20:
	.ascii	"Generating decompressed audio to output.wav\012\000"
	.align	2
.LC21:
	.ascii	"output.wav\000"
	.align	2
.LC22:
	.ascii	"w\000"
	.align	2
.LC23:
	.ascii	"File write failed!\012\000"
	.align	2
.LC24:
	.ascii	"Output Generated -- output.wav\012\000"
	.text
	.align	2
	.global	generate_decompressed_file
	.type	generate_decompressed_file, %function
generate_decompressed_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L72
	bl	puts
	ldr	r0, .L72+4
	ldr	r1, .L72+8
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	bne	.L67
	ldr	r0, .L72+12
	bl	puts
	b	.L71
.L67:
	ldr	r0, .L72+16
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L72+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L72+24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L72+28
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldr	r3, [r3, #16]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L72+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldrb	r3, [r3, #20]	@ zero_extendqisi2
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L72+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldrh	r3, [r3, #22]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L72+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldr	r3, [r3, #24]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L72+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldr	r3, [r3, #28]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L72+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldrh	r3, [r3, #32]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L72+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldrh	r3, [r3, #34]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L72+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L72+32
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L72+16
	ldr	r3, [r3, #40]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L72+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L69
.L70:
	ldr	r3, .L72+16
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r0, r3
	bl	LE_format_16
	ldr	r3, .L72+36
	ldr	r3, [r3, #0]
	ldr	r0, .L72+20
	mov	r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L69:
	ldr	r3, [fp, #-8]
	ldr	r2, .L72+40
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L70
	ldr	r0, [fp, #-12]
	bl	fclose
	ldr	r0, .L72+44
	bl	puts
.L71:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L73:
	.align	2
.L72:
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	wave
	.word	data_array
	.word	wave+8
	.word	wave+12
	.word	wave+36
	.word	sizeOfEachSample
	.word	numSamples
	.word	.LC24
	.size	generate_decompressed_file, .-generate_decompressed_file
	.section	.rodata
	.align	2
.LC25:
	.ascii	"Generating compressed audio to compressed_output.wa"
	.ascii	"v\012\000"
	.align	2
.LC26:
	.ascii	"compressed_output.wav\000"
	.align	2
.LC27:
	.ascii	"Output Generated -- compressed_output.wav\012\000"
	.text
	.align	2
	.global	generate_compressed_file
	.type	generate_compressed_file, %function
generate_compressed_file:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L80
	bl	puts
	ldr	r0, .L80+4
	ldr	r1, .L80+8
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	bne	.L75
	ldr	r0, .L80+12
	bl	puts
	b	.L79
.L75:
	ldr	r0, .L80+16
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L80+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L80+24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L80+28
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldr	r3, [r3, #16]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L80+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldrb	r3, [r3, #20]	@ zero_extendqisi2
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L80+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldrh	r3, [r3, #22]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L80+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldr	r3, [r3, #24]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L80+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldr	r3, [r3, #28]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L80+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldrh	r3, [r3, #32]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L80+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldrh	r3, [r3, #34]
	mov	r0, r3
	bl	LE_format_16
	ldr	r0, .L80+20
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r0, .L80+32
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, .L80+16
	ldr	r3, [r3, #40]
	mov	r0, r3
	bl	LE_format_32
	ldr	r0, .L80+20
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L77
.L78:
	ldr	r3, .L80+36
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r0, r3
	bl	LE_format_16
	ldr	r3, .L80+40
	ldr	r3, [r3, #0]
	ldr	r0, .L80+20
	mov	r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-12]
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L77:
	ldr	r3, [fp, #-8]
	ldr	r2, .L80+44
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L78
	ldr	r0, [fp, #-12]
	bl	fclose
	ldr	r0, .L80+48
	bl	puts
.L79:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L81:
	.align	2
.L80:
	.word	.LC25
	.word	.LC26
	.word	.LC22
	.word	.LC23
	.word	wave
	.word	data_array
	.word	wave+8
	.word	wave+12
	.word	wave+36
	.word	cwave
	.word	sizeOfEachSample
	.word	numSamples
	.word	.LC27
	.size	generate_compressed_file, .-generate_compressed_file
	.align	2
	.global	LE_format_32
	.type	LE_format_32, %function
LE_format_32:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	and	r3, r3, #255
	ldr	r2, .L84
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-8]
	and	r3, r3, #65280
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	ldr	r2, .L84
	strb	r3, [r2, #1]
	ldr	r3, [fp, #-8]
	and	r3, r3, #16711680
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	ldr	r2, .L84
	strb	r3, [r2, #2]
	ldr	r3, [fp, #-8]
	mov	r3, r3, lsr #24
	and	r3, r3, #255
	ldr	r2, .L84
	strb	r3, [r2, #3]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L85:
	.align	2
.L84:
	.word	data_array
	.size	LE_format_32, .-LE_format_32
	.align	2
	.global	LE_format_16
	.type	LE_format_16, %function
LE_format_16:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]	@ movhi
	and	r3, r3, #255
	ldr	r2, .L88
	strb	r3, [r2, #0]
	ldrh	r3, [fp, #-6]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	ldr	r2, .L88
	strb	r3, [r2, #1]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L89:
	.align	2
.L88:
	.word	data_array
	.size	LE_format_16, .-LE_format_16
	.comm	fp,4,4
	.comm	wave,48,4
	.comm	dwave,48,4
	.comm	cwave,48,4
	.comm	data_array,4,1
	.comm	numSamples,4,4
	.comm	sizeOfEachSample,4,4
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
