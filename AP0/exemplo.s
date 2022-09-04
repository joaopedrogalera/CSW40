; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
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

; -------------------------------------------------------------------------------
; Fun��o main()
Aleatorios EQU 0x20000A00
Primos EQU 0x20000B00
Start  
; Comece o c�digo aqui <======================================================
CarregaNums
	LDR R0, =Aleatorios
	
	MOV R1, #193
	STRB R1, [R0], #1
	MOV R1, #63
	STRB R1, [R0], #1
	MOV R1, #176
	STRB R1, [R0], #1
	MOV R1, #127
	STRB R1, [R0], #1
	MOV R1, #43
	STRB R1, [R0], #1
	MOV R1, #13
	STRB R1, [R0], #1
	MOV R1, #211
	STRB R1, [R0], #1
	MOV R1, #3
	STRB R1, [R0], #1
	MOV R1, #203
	STRB R1, [R0], #1
	MOV R1, #5
	STRB R1, [R0], #1
	MOV R1, #21
	STRB R1, [R0], #1
	MOV R1, #7
	STRB R1, [R0], #1
	MOV R1, #206
	STRB R1, [R0], #1
	MOV R1, #245
	STRB R1, [R0], #1
	MOV R1, #157
	STRB R1, [R0], #1
	MOV R1, #237
	STRB R1, [R0], #1
	MOV R1, #241
	STRB R1, [R0], #1
	MOV R1, #105
	STRB R1, [R0], #1
	MOV R1, #252
	STRB R1, [R0], #1
	MOV R1, #19
	STRB R1, [R0], #1


	LDR R1, =Aleatorios ;Registrador com a posi��o de leitura
	LDR R2, =Primos ;Registrador com a posi��o de gravar
	MOV R4, #0 ;Guarda tamanho da lista de primos

TestaNumero
	CMP R0, R1
	BEQ FimPrimos ;Se posi��o de leitura igua a de grava��o, acabou a lista
	
	LDRB R12, [R1], #1 ;Coloca n�mero a ser testado no registrador R12
	
	CMP R12, #1
	BEQ CopiaPrimo ;Se n�mero igual a 1, copia o primo
	
	MOV R3, #2 ;Coloca primeiro divisor a ser testado no R3
Divisao
	CMP R12, R3
	BEQ CopiaPrimo ;Se numero igual ao divisor atual, Copia primo
	UDIV R11, R12, R3
	MLS R11, R11, R3, R12
	CMP R11, #0
	BEQ TestaNumero ;Se resto da divis�o for 0, vai para o pr�ximo n�mero da mem�ria
	ADD R3, #1
	B Divisao
	
CopiaPrimo
	STRB R12, [R2], #1 ;Copia n�mero primo para a mem�ria
	ADD R4, #1 ;Atualiza tamanho lista de primos
	B TestaNumero

FimPrimos

Ordenar
	LDR R0, =Primos
	CMP R4, #1
	BLS Fim
	MOV R5, #0
	SUB R4, #1

LoopInterno
	CMP R5, R4
	BEQ Ordenar
	ADD R5, #1
	
	LDRB R11, [R0], #1
	LDRB R12, [R0]
	
	CMP R11, R12
	BLS LoopInterno
	STRB R12, [R0,#-1]
	STRB R11, [R0]
	B LoopInterno
	
Fim
	NOP
	ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo
