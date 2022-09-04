; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>

; -------------------------------------------------------------------------------
; Função main()
Aleatorios EQU 0x20000A00
Primos EQU 0x20000B00
Start  
; Comece o código aqui <======================================================
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


	LDR R1, =Aleatorios ;Registrador com a posição de leitura
	LDR R2, =Primos ;Registrador com a posição de gravar
	MOV R4, #0 ;Guarda tamanho da lista de primos

TestaNumero
	CMP R0, R1
	BEQ FimPrimos ;Se posição de leitura igua a de gravação, acabou a lista
	
	LDRB R12, [R1], #1 ;Coloca número a ser testado no registrador R12
	
	CMP R12, #1
	BEQ CopiaPrimo ;Se número igual a 1, copia o primo
	
	MOV R3, #2 ;Coloca primeiro divisor a ser testado no R3
Divisao
	CMP R12, R3
	BEQ CopiaPrimo ;Se numero igual ao divisor atual, Copia primo
	UDIV R11, R12, R3
	MLS R11, R11, R3, R12
	CMP R11, #0
	BEQ TestaNumero ;Se resto da divisão for 0, vai para o próximo número da memória
	ADD R3, #1
	B Divisao
	
CopiaPrimo
	STRB R12, [R2], #1 ;Copia número primo para a memória
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
	ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
