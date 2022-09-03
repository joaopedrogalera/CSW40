; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usu�rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Defini��es de Valores


; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
		IMPORT  Teclado_col1
		IMPORT  Teclado_col2
		IMPORT  Teclado_col3
		IMPORT  Le_teclas
		IMPORT	PiscaLeds
		IMPORT  IniciaLCD
		IMPORT 	EscreveCaracter
		IMPORT	CursorHome

;Endere�os de mem�ria onde ser�o salvos as posi��es da tabuada
Tabuada0_mem	EQU		0x20000000
Tabuada1_mem	EQU		0x20000001
Tabuada2_mem	EQU		0x20000002
Tabuada3_mem	EQU		0x20000003
Tabuada4_mem	EQU		0x20000004
Tabuada5_mem	EQU		0x20000005
Tabuada6_mem	EQU		0x20000006
Tabuada7_mem	EQU		0x20000007
Tabuada8_mem	EQU		0x20000008
Tabuada9_mem	EQU		0x20000009


; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	BL IniciaLCD

;Inicializa mem�ria
	MOV R0, #0
	LDR R1, =Tabuada0_mem
	STRB R0, [R1], #1 ;0
	STRB R0, [R1], #1 ;1
	STRB R0, [R1], #1 ;2
	STRB R0, [R1], #1 ;3
	STRB R0, [R1], #1 ;4
	STRB R0, [R1], #1 ;5
	STRB R0, [R1], #1 ;6
	STRB R0, [R1], #1 ;7
	STRB R0, [R1], #1 ;8
	STRB R0, [R1] ;9


MainLoop
;Fun��o de varrer o teclado
	BL Teclado_col1
	MOV R0, #10
	BL SysTick_Wait1ms
	BL Le_teclas

	CMP R0, #2_1110
	BLEQ Tabuada1
	CMP R0, #2_1101
	BLEQ Tabuada4
	CMP R0, #2_1011
	BLEQ Tabuada7

	BL Teclado_col2
	MOV R0, #10
	BL SysTick_Wait1ms
	BL Le_teclas

	CMP R0, #2_1110
	BLEQ Tabuada2
	CMP R0, #2_1101
	BLEQ Tabuada5
	CMP R0, #2_1011
	BLEQ Tabuada8
	CMP R0, #2_0111
	BLEQ Tabuada0

	
	BL Teclado_col3
	MOV R0, #10
	BL SysTick_Wait1ms
	BL Le_teclas

	CMP R0, #2_1110
	BLEQ Tabuada3
	CMP R0, #2_1101
	BLEQ Tabuada6
	CMP R0, #2_1011
	BLEQ Tabuada9

	MOV R0, #500
	BL SysTick_Wait1ms

	B MainLoop

;Fun��es que executam cata tabuada
Tabuada0
	LDR R11, =Tabuada0_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #0
	BL Multiplica

	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada1
	LDR R11, =Tabuada1_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #1
	BL Multiplica

	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada2
	LDR R11, =Tabuada2_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #2
	BL Multiplica

	BL AdicionaFator
	POP {LR}

	BX LR
Tabuada3
	LDR R11, =Tabuada3_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #3
	BL Multiplica

	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada4
	LDR R11, =Tabuada4_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #4
	BL Multiplica
	
	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada5
	LDR R11, =Tabuada5_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #5
	BL Multiplica
	
	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada6
	LDR R11, =Tabuada6_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #6
	BL Multiplica
	
	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada7
	LDR R11, =Tabuada7_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #7
	BL Multiplica
	
	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada8
	LDR R11, =Tabuada8_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #8
	BL Multiplica

	BL AdicionaFator
	POP {LR}
	
	BX LR
Tabuada9
	LDR R11, =Tabuada9_mem
	LDRB R12, [R11]
	PUSH {LR}

	MOV R10, #9
	BL Multiplica

	BL AdicionaFator
	POP {LR}
	
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que adiciona um ao multiplicador da tabuada. Ao chegar a 10, reseta e pisca os LEDs
; Par�metro de entrada: R11 -> Endere�o da mem�ria da tabuada, R12 -> valor
; Par�metro de sa�da: N�o tem
AdicionaFator
	ADD R12, #1
	CMP R12, #0xa
	IT EQ
		MOVEQ R12, #0
	STRB R12, [R11]
	
	IT EQ
		PUSHEQ {LR}
	BLEQ PiscaLeds
	IT EQ
		POPEQ {LR}
	
	BX LR
	
; -------------------------------------------------------------------------------
; Fun��o que Multiplica e imprime no LCD
; Par�metro de entrada: R10 -> Tabuada, R12 -> multiplicador
; Par�metro de sa�da: N�o tem
Multiplica
	PUSH {LR}

	BL CursorHome
	MUL R9, R12, R10
	
	ADD R0, R10, #48
	BL EscreveCaracter

	MOV R0, #'x'
	BL EscreveCaracter

	ADD R0, R12, #48
	BL EscreveCaracter

	MOV R0, #'='
	BL EscreveCaracter

	MOV R7, #10
	UDIV R8, R9, R7
	ADD R0, R8, #48
	BL EscreveCaracter
	
	MLS R0, R7, R8, R9
	ADD R0, #48
	BL EscreveCaracter

	POP {LR}
	BX LR
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
