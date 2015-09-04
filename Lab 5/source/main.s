

.section .init
.globl _start
_start:
	mov sp, #0x8000

	bl Asignar
	
	
	/* Direccion GPIO base */
	bl GetGpioAddress
	mov r4,r0	
	
	@ tiempo inicial de 2 segundos
	ldr r2, =2000000
	
	@bandera
	mov r6, #0
	@bandera2
	mov r8, #0
	
infinito:
	@ en r2 el tiempo 500000 = 0.5 s
	@ en r3 bandera de secuencia (0 sec1, 1 sec2)
	@ en r6 bandera de tiempo
	
	/* Revision del boton
	 * Para revisar si el nivel de un GPIO esta en alto o bajo se revisa 
	 * la direccion 0x2020 0034 para los GPIO 0 - 31 */
	ldr r5,[r4,#0x34]
	mov r0,#1
	lsl r0,#15
	and r5,r0 
	
	@Si el boton esta en nivel alto se enciende el GPIO 8, y se apaga el GPIO 7 > ne -- alto
	teq r5,#0
	blne Check2
	
	/* Revision del boton
	 * Para revisar si el nivel de un GPIO esta en alto o bajo se revisa 
	 * la direccion 0x2020 0034 para los GPIO 0 - 31 */
	ldr r5,[r4,#0x34]
	mov r0,#1
	lsl r0,#14
	and r5,r0 
	
	@Si el boton esta en nivel alto se enciende el GPIO 8, y se apaga el GPIO 7 > ne -- alto
	teq r5,#0
	blne Check
	
	cmp r6, #0
	bleq Secuencia1
	
	cmp r6, #1
	bleq Secuencia2
	

	/* Loop infinito */
	b infinito

