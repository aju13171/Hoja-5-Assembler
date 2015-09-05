@Universidad del Valle de Guatemala
@Taller de Assembler
@Sección 21
@
@Laboratorio 5
@
@	subrutinas.s
@
@Jorge Manrique 13600
@
@Christopher Ajú 13171
@

.globl SetWait
SetWait:
	push {lr}
	
	cmp r8, #0
	ldreq r0, =750000
	
	cmp r8, #1
	ldreq r0, =500000
	
	pop {pc}

@@r8= tiempo en segundos
.globl Check2
Check2:
	push {lr}
	
	cmp r8, #0
	addeq r8, #1
	cmp r8, #1
	moveq r8, #0
	
	pop {pc}

@@r0 = viene ultimo valor de boton
.globl Check
Check:
	cmp r6, #0
	moveq r6, #1
	movne r6, #0
	@posible falla: mov pc, lr

@@
.globl Secuencia1
Secuencia1:

@ 1 encendido
@ 0 apagado

	push {lr}
	
@ o x x

	mov r0,#7
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
@ o o x	

	mov r0,#8
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
@ o o o
	
	mov r0,#10
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
	bl Apagado
	bl SetWait
	bl Wait
	pop {pc}
	

.globl Secuencia2
Secuencia2:

	push {lr}
@ o x x
	mov r0,#7
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
	bl Apagado

@ x o x	
	mov r0,#8
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
	bl Apagado

@ x x o		
	mov r0,#10
	mov r1,#1
	bl SetGpio
	
	bl SetWait
	bl Wait
	
	bl Apagado
	
	pop {pc}
	
.globl Apagado
Apagado:

	push {lr}

	mov r0, #7
	mov r1, #0
	bl SetGpio
	
	mov r0, #8
	mov r1, #0
	bl SetGpio
	
	mov r0, #10
	mov r1, #0
	bl SetGpio
	
	pop {pc}

.globl Encendido
Encendido:

	push {lr}

	mov r0, #7
	mov r1, #1
	bl SetGpio
	
	mov r0, #8
	mov r1, #1
	bl SetGpio
	
	mov r0, #10
	mov r1, #1
	bl SetGpio
	
	pop {pc}


.globl Asignar
Asignar:

	push {lr}
	
	/* Configuracion de puertos GPIO */
	@ boton de secuencia
	mov r0,#14
	mov r1,#0
	bl SetGpioFunction
	
	@ boton de velociadad
	mov r0,#15
	mov r1,#0
	bl SetGpioFunction
	
	@ primer led
	mov r0,#7
	mov r1,#1
	bl SetGpioFunction
	
	@ segundo led
	mov r0,#8
	mov r1,#1
	bl SetGpioFunction
	
	@ tercer led
	mov r0,#10
	mov r1,#1
	bl SetGpioFunction
	
	pop {pc}
