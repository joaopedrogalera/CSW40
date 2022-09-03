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
        IMPORT  SSD_Write
		IMPORT 	Habilita_unidade
		IMPORT 	Habilita_dezena
		IMPORT	Habilita_Leds
		IMPORT 	Acende_Leds
        IMPORT  PortJ_Input	


; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	
	
	MOV R12, #0 ;numero
	MOV R8, #1 ;Passo
	MOV R7, #0x0 ;LEDs
MainLoop

	CMP R7, #0xe
	IT HS
		MOVHS R7, #0x0 ;Retorna led para 0 ao chegar em 13

	BL PortJ_Input
	CMP R0, #2_10
	IT EQ
		ADDEQ R8, #1	
	CMP R0, #2_01
	IT EQ
		SUBEQ R8, #1 ;Soma ou subtrai o passo ao pressionar um bot�o

	CMP R8, #1
	IT LT
		MOVLT R8, #1 ;Limita passo inferiormente
		
	CMP R8, #9
	IT HI
		MOVHI R8, #9 ;Limita passo superiormente
		
	CMP R12, #99
	IT HI
		SUBHI R12, #100 ;Faz o n�mero ser ciclico
	BL SSDeLEDs ;Chama fun��o para controlar SSDs e LEDs

	ADD R12, R8 ;Adiciona o valor do passo ao n�mero
	ADD R7, #1 ;Adiciona 1 ao led
		
	B MainLoop

SSDeLEDs
	PUSH {LR}
	MOV R9, #0 ;Itera��es
	MOV R11, #10
	UDIV R10, R12, R11 ;R10 = dezenas no n�mero
	MLS R11, R10, R11, R12 ;R11 = Unidades no n�mero

SSDeLEDs_loop
	MOV R0, R10
	BL SSD_Write ;Chama fun��o do SSD com o valor das dezenas
	BL Habilita_dezena ;Chama fun��o que ativa SSD das dezenas e desativa unidades e LEDs
	MOV R0, #6
	BL SysTick_Wait1ms ;Espera 6ms
	
	MOV R0, R11
	BL SSD_Write ;Chama fun��o do SSD com o valor das unidades
	BL Habilita_unidade ;Chama fun��o que ativa SSD das unidades e desativa dezenas e LEDs
	
	MOV R0, #6
	BL SysTick_Wait1ms ;Espera 6ms
	
	BL Habilita_Leds ;Chama fun��o que ativa LEDs e desativa SSDs
	MOV R0, R7
	BL Acende_Leds ;Chama a fun��o que ativa o led espec�ficado e desativa os demais
	MOV R0, #6
	BL SysTick_Wait1ms ;Espera 6ms
	
	ADD R9, #1
	CMP R9, #50
	ITT HS
		POPHS {LR}
		BXHS LR ;Adiciona 1 ao n�mero de itera��es. Se chegar a 50, retorna 
	
	B SSDeLEDs_loop

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
