; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
; PORT L
GPIO_PORTL_AHB_LOCK_R    	EQU    0x40062520
GPIO_PORTL_AHB_CR_R      	EQU    0x40062524
GPIO_PORTL_AHB_AMSEL_R   	EQU    0x40062528
GPIO_PORTL_AHB_PCTL_R    	EQU    0x4006252C
GPIO_PORTL_AHB_DIR_R     	EQU    0x40062400
GPIO_PORTL_AHB_AFSEL_R   	EQU    0x40062420
GPIO_PORTL_AHB_DEN_R     	EQU    0x4006251C
GPIO_PORTL_AHB_PUR_R     	EQU    0x40062510	
GPIO_PORTL_AHB_DATA_R    	EQU    0x400623FC
GPIO_PORTL               	EQU    2_000010000000000
; PORT M
GPIO_PORTM_AHB_LOCK_R    	EQU    0x40063520
GPIO_PORTM_AHB_CR_R      	EQU    0x40063524
GPIO_PORTM_AHB_AMSEL_R   	EQU    0x40063528
GPIO_PORTM_AHB_PCTL_R    	EQU    0x4006352C
GPIO_PORTM_AHB_DIR_R     	EQU    0x40063400
GPIO_PORTM_AHB_AFSEL_R   	EQU    0x40063420
GPIO_PORTM_AHB_DEN_R     	EQU    0x4006351C
GPIO_PORTM_AHB_PUR_R     	EQU    0x40063510	
GPIO_PORTM_AHB_DATA_R    	EQU    0x400633FC
GPIO_PORTM               	EQU    2_000100000000000	
	
; PORT A
GPIO_PORTA_AHB_LOCK_R    	EQU    0x40058520
GPIO_PORTA_AHB_CR_R      	EQU    0x40058524
GPIO_PORTA_AHB_AMSEL_R   	EQU    0x40058528
GPIO_PORTA_AHB_PCTL_R    	EQU    0x4005852C
GPIO_PORTA_AHB_DIR_R     	EQU    0x40058400
GPIO_PORTA_AHB_AFSEL_R   	EQU    0x40058420
GPIO_PORTA_AHB_DEN_R     	EQU    0x4005851C
GPIO_PORTA_AHB_PUR_R     	EQU    0x40058510	
GPIO_PORTA_AHB_DATA_R    	EQU    0x400583FC
GPIO_PORTA               	EQU    2_000000000000001

; PORT Q
GPIO_PORTQ_AHB_LOCK_R    	EQU    0x40066520
GPIO_PORTQ_AHB_CR_R      	EQU    0x40066524
GPIO_PORTQ_AHB_AMSEL_R   	EQU    0x40066528
GPIO_PORTQ_AHB_PCTL_R    	EQU    0x4006652C
GPIO_PORTQ_AHB_DIR_R     	EQU    0x40066400
GPIO_PORTQ_AHB_AFSEL_R   	EQU    0x40066420
GPIO_PORTQ_AHB_DEN_R     	EQU    0x4006651C
GPIO_PORTQ_AHB_PUR_R     	EQU    0x40066510	
GPIO_PORTQ_AHB_DATA_R    	EQU    0x400663FC
GPIO_PORTQ               	EQU    2_100000000000000

; PORT P
GPIO_PORTP_AHB_LOCK_R    	EQU    0x40065520
GPIO_PORTP_AHB_CR_R      	EQU    0x40065524
GPIO_PORTP_AHB_AMSEL_R   	EQU    0x40065528
GPIO_PORTP_AHB_PCTL_R    	EQU    0x4006552C
GPIO_PORTP_AHB_DIR_R     	EQU    0x40065400
GPIO_PORTP_AHB_AFSEL_R   	EQU    0x40065420
GPIO_PORTP_AHB_DEN_R     	EQU    0x4006551C
GPIO_PORTP_AHB_PUR_R     	EQU    0x40065510	
GPIO_PORTP_AHB_DATA_R    	EQU    0x400653FC
GPIO_PORTP               	EQU    2_010000000000000

; PORT K
GPIO_PORTK_AHB_LOCK_R    	EQU    0x40061520
GPIO_PORTK_AHB_CR_R      	EQU    0x40061524
GPIO_PORTK_AHB_AMSEL_R   	EQU    0x40061528
GPIO_PORTK_AHB_PCTL_R    	EQU    0x4006152C
GPIO_PORTK_AHB_DIR_R     	EQU    0x40061400
GPIO_PORTK_AHB_AFSEL_R   	EQU    0x40061420
GPIO_PORTK_AHB_DEN_R     	EQU    0x4006151C
GPIO_PORTK_AHB_PUR_R     	EQU    0x40061510	
GPIO_PORTK_AHB_DATA_R    	EQU    0x400613FC
GPIO_PORTK               	EQU    2_000001000000000

; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ_AHB_IM_R			EQU	   0x40060410
GPIO_PORTJ_AHB_IS_R			EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R		EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R        EQU    0x4006040C
GPIO_PORTJ_AHB_ICR_R        EQU    0x4006041C
GPIO_PORTJ               	EQU    2_000000100000000
	
;NVIC
NVIC_EN1_R                  EQU    0xE000E104
NVIC_PRI12_R                EQU    0xE000E430
; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT Teclado_col1
		EXPORT Teclado_col2
		EXPORT Teclado_col3
		EXPORT Le_teclas
		EXPORT PiscaLeds
		EXPORT IniciaLCD
		EXPORT EscreveCaracter
		EXPORT CursorHome
		EXPORT GPIOPortJ_Handler
			
		IMPORT SysTick_Wait1ms
		IMPORT SysTick_Wait1us
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
            LDR     R0, =SYSCTL_RCGCGPIO_R  		
			MOV		R1, #GPIO_PORTL                 
			ORR     R1, #GPIO_PORTM					
			ORR     R1, #GPIO_PORTA
			ORR     R1, #GPIO_PORTP
			ORR     R1, #GPIO_PORTQ
			ORR     R1, #GPIO_PORTK
			ORR     R1, #GPIO_PORTJ
			STR     R1, [R0]						
 
            LDR     R0, =SYSCTL_PRGPIO_R			
EsperaGPIO  LDR     R1, [R0]						
			MOV     R2, #GPIO_PORTL                 
			ORR     R2, #GPIO_PORTM                 
			ORR     R1, #GPIO_PORTA
			ORR     R1, #GPIO_PORTP
			ORR     R1, #GPIO_PORTQ
			ORR     R1, #GPIO_PORTK
			ORR     R1, #GPIO_PORTJ
            TST     R1, R2							
            BEQ     EsperaGPIO
 
; 2. Limpar o AMSEL para desabilitar a anal�gica
            MOV     R1, #0x00						
            LDR     R0, =GPIO_PORTM_AHB_AMSEL_R     
            STR     R1, [R0]						
            LDR     R0, =GPIO_PORTL_AHB_AMSEL_R		
            STR     R1, [R0]					    
			LDR     R0, =GPIO_PORTA_AHB_AMSEL_R		
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTP_AHB_AMSEL_R		
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTQ_AHB_AMSEL_R		
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTK_AHB_AMSEL_R		
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R		
            STR     R1, [R0]
 
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    
            LDR     R0, =GPIO_PORTM_AHB_PCTL_R		
            STR     R1, [R0]                        
            LDR     R0, =GPIO_PORTL_AHB_PCTL_R      
            STR     R1, [R0] 					    
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R		
            STR     R1, [R0] 					    
            LDR     R0, =GPIO_PORTP_AHB_PCTL_R		
            STR     R1, [R0]                       
            LDR     R0, =GPIO_PORTQ_AHB_PCTL_R  
            STR     R1, [R0]                    
			LDR     R0, =GPIO_PORTK_AHB_PCTL_R  
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_PCTL_R  
            STR     R1, [R0]
; 4. DIR para 0 se for entrada, 1 se for sa�da
            LDR     R0, =GPIO_PORTL_AHB_DIR_R	
			MOV     R1, #0x0
            STR     R1, [R0]					
            LDR     R0, =GPIO_PORTM_AHB_DIR_R		
			MOV 	R1, #2_111
			STR     R1, [R0]						
			
			LDR     R0, =GPIO_PORTA_AHB_DIR_R
			MOV     R1, #2_11110000
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTP_AHB_DIR_R
			MOV     R1, #2_100000
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTQ_AHB_DIR_R
			MOV     R1, #2_1111
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTK_AHB_DIR_R
			MOV     R1, #0xFF
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_DIR_R
			MOV     R1, #0x0
            STR     R1, [R0]
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem fun��o alternativa
            MOV     R1, #0x00						
            LDR     R0, =GPIO_PORTL_AHB_AFSEL_R		
            STR     R1, [R0]						
            LDR     R0, =GPIO_PORTM_AHB_AFSEL_R     
            STR     R1, [R0]                        
			LDR     R0, =GPIO_PORTA_AHB_AFSEL_R     
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTP_AHB_AFSEL_R     
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTQ_AHB_AFSEL_R     
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTK_AHB_AFSEL_R     
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     
            STR     R1, [R0]
; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTL_AHB_DEN_R		
            MOV     R1, #2_00001111                 
            STR     R1, [R0]						 

            LDR     R0, =GPIO_PORTM_AHB_DEN_R		
			MOV     R1, #2_11110111                       
            STR     R1, [R0]                        

			LDR     R0, =GPIO_PORTA_AHB_DEN_R		
			MOV     R1, #2_11110000                       
            STR     R1, [R0]
			
			LDR     R0, =GPIO_PORTP_AHB_DEN_R		
			MOV     R1, #2_100000                         
            STR     R1, [R0]
			
			LDR     R0, =GPIO_PORTQ_AHB_DEN_R		
			MOV     R1, #2_1111                           
            STR     R1, [R0]
			
			LDR     R0, =GPIO_PORTK_AHB_DEN_R			
			MOV     R1, #0xFF                           
            STR     R1, [R0]
			
			LDR     R0, =GPIO_PORTJ_AHB_DEN_R			
			MOV     R1, #0x1                           
            STR     R1, [R0]
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			LDR     R0, =GPIO_PORTL_AHB_PUR_R			
			MOV     R1, #2_00001111						 
                                                        
            STR     R1, [R0]

			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			
			MOV     R1, #2_00000001						 
                                                        
            STR     R1, [R0]

; 8. J� deixamos os LEDs ligados e s� precisamos piscar o transistor
			LDR		R0, =GPIO_PORTA_AHB_DATA_R
			MOV		R1, #2_11110000
			STR		R1, [R0]
			
			LDR		R0, =GPIO_PORTQ_AHB_DATA_R
			MOV		R1, #2_1111
			STR		R1, [R0]
			
			LDR		R0, =GPIO_PORTP_AHB_DATA_R
			MOV		R1, #0x0
			STR		R1, [R0]
			
; 9. Configura interrup��es
			; 9.1 Desabilita interrup��o no pino
			LDR		R0, =GPIO_PORTJ_AHB_IM_R
			MOV		R1, #0x0
			STR		R1, [R0]
			; 9.2 Seta Interrup��o de borda
			LDR		R0, =GPIO_PORTJ_AHB_IS_R
			MOV		R1, #2_0
			STR		R1, [R0]
			
			; 9.3 Seta borda �nica
			LDR		R0, =GPIO_PORTJ_AHB_IBE_R
			MOV		R1, #2_0
			STR		R1, [R0]
			
			; 9.4 Seta borda descida
			LDR		R0, =GPIO_PORTJ_AHB_IEV_R
			MOV		R1, #2_0
			STR		R1, [R0]
			
			; 9.5 Limpa RIS e MIS
			LDR		R0, =GPIO_PORTJ_AHB_ICR_R
			MOV		R1, #2_1
			STR		R1, [R0]
			
			; 9.6 Ativa interrup��es
			LDR		R0, =GPIO_PORTJ_AHB_IM_R
			MOV		R1, #2_1
			STR		R1, [R0]
			
			; 9.7 Ativa fonte de interrup��es
			LDR		R0, =NVIC_EN1_R
			LDR		R1, [R0]
			
			MOV		R2, #0x0
			MOVT	R2, #2_0000000000001000
			ORR 	R1, R2
			STR		R1, [R0]
			
			; 9.8 Seta prioridade
			LDR		R0, =NVIC_PRI12_R
			MOV		R1, #0x0
			LSL		R1, #29
			STR		R1, [R0]
;retorno
			BX      LR

; -------------------------------------------------------------------------------

; -------------------------------------------------------------------------------
; Fun��es para habilitar as colunas do teclado
; Feito apenas para as colunas 1 a 3, j� que a 4 n�o ser� usada
; Par�metro de entrada: 
; Par�metro de sa�da: N�o tem
Teclado_col1
	;Define a coluna 1 (PM4) e os pinos do LCD (PM0-PM2) como sa�da e as demais como entrada
	LDR     R0, =GPIO_PORTM_AHB_DIR_R
	MOV 	R1, #2_00010111
	STR		R1, [R0]
	
	;Coloca 0 na porta M. O PM4 fica com o valor 0, os demais n�o s�o afetados
	LDR		R0, =GPIO_PORTM_AHB_DATA_R
	LDR		R1, [R0]
	AND		R1, #2_11101111
	STR		R1, [R0]
	
	BX LR
	
Teclado_col2
	;Define a coluna 2 (PM5) e os pinos do LCD (PM0-PM2) como sa�da e as demais como entrada
	LDR     R0, =GPIO_PORTM_AHB_DIR_R
	MOV 	R1, #2_00100111
	STR		R1, [R0]
	
	;Coloca 0 na porta M. O PM5 fica com o valor 0, os demais n�o s�o afetados
	LDR		R0, =GPIO_PORTM_AHB_DATA_R
	LDR		R1, [R0]
	AND		R1, #2_11011111
	STR		R1, [R0]
	
	BX LR
	
Teclado_col3
	;Define a coluna 3 (PM6) e os pinos do LCD (PM0-PM2) como sa�da e as demais como entrada
	LDR     R0, =GPIO_PORTM_AHB_DIR_R
	MOV 	R1, #2_01000111
	STR		R1, [R0]
	
	;Coloca 0 na porta M. O PM6 fica com o valor 0, os demais n�o s�o afetados
	LDR		R0, =GPIO_PORTM_AHB_DATA_R
	LDR		R1, [R0]
	AND		R1, #2_10111111
	STR		R1, [R0]
	
	BX LR
; -------------------------------------------------------------------------------
; Fun��o Le_teclas
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
Le_teclas
	LDR R1, =GPIO_PORTL_AHB_DATA_R
	LDR R0, [R1]
	
	BX LR

; -------------------------------------------------------------------------------
; Fun��o Que pisca os LEDs 5x
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
PiscaLeds
	LDR R1, =GPIO_PORTP_AHB_DATA_R
	MOV R2, #2_100000
	MOV R3, #0
	MOV R4, #0
	PUSH {LR}
PiscaLedLoop	
	STR R2, [R1]
	MOV R0, #500
	BL SysTick_Wait1ms
	STR R3, [R1]
	MOV R0, #500
	BL SysTick_Wait1ms
	
	ADD R4, #1
	CMP R4, #5
	BLT PiscaLedLoop

	POP {LR}
	BX LR
	
; -------------------------------------------------------------------------------
; Fun��o que inicia o LCD
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
IniciaLCD
	PUSH {LR}
	MOV R0, #0x38
	BL EnviaComando40
	
	MOV R0, #0x06
	BL EnviaComando40
	
	MOV R0, #0x0E
	BL EnviaComando40
	
	MOV R0, #0x01
	BL EnviaComando1640

	BL EscreveNome
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que escreve Joao Pedro na segunda linha do LCD
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
EscreveNome
	PUSH {LR}

	MOV R0, #0xC0
	BL EnviaComando1640
	
	MOV R0, #'J'
	BL EscreveCaracter
	MOV R0, #'o'
	BL EscreveCaracter
	MOV R0, #'a'
	BL EscreveCaracter
	MOV R0, #'o'
	BL EscreveCaracter
	MOV R0, #' '
	BL EscreveCaracter
	MOV R0, #'P'
	BL EscreveCaracter
	MOV R0, #'e'
	BL EscreveCaracter
	MOV R0, #'d'
	BL EscreveCaracter
	MOV R0, #'r'
	BL EscreveCaracter
	MOV R0, #'o'
	BL EscreveCaracter
	
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que seta EN do LCD para 0
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
DesabilitaLCD
	LDR R0, =GPIO_PORTM_AHB_DATA_R
	LDR R1, [R0]
	AND R1, #0xF0
	STR R1, [R0]
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que seta EN do LCD para 1, RS para comando e espera 10us
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
HabilitaLCDCmd
	PUSH {LR}
	LDR R1, =GPIO_PORTM_AHB_DATA_R
	LDR R2, [R1]
	AND R2, #0xF0
	ORR R2, #0x4
	STR R2, [R1]
	
	MOV R0, #10
	BL SysTick_Wait1us
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que seta EN do LCD para 1, RS para dado e espera 10us
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
HabilitaLCDDado
	PUSH {LR}
	LDR R1, =GPIO_PORTM_AHB_DATA_R
	LDR R2, [R1]
	AND R2, #0xF0
	ORR R2, #0x5
	STR R2, [R1]
	
	MOV R0, #10
	BL SysTick_Wait1us
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que excreve o caracter enviado na posi��o do cursor
; Par�metro de entrada: R0 -> C�digo ASCII do caracter
; Par�metro de sa�da: N�o tem
EscreveCaracter
	PUSH {LR}
	PUSH {R0}
	BL DesabilitaLCD
	
	POP {R0}
	LDR R1, =GPIO_PORTK_AHB_DATA_R
	STR	R0, [R1]
	
	BL HabilitaLCDDado
	BL DesabilitaLCD
	
	MOV R0, #40
	BL SysTick_Wait1us
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que envia comandos com espera de 40us
; Par�metro de entrada: R0 -> Comando
; Par�metro de sa�da: N�o tem
EnviaComando40
	PUSH {LR}
	PUSH {R0}
	BL DesabilitaLCD
	
	LDR R1, =GPIO_PORTK_AHB_DATA_R
	POP {R0}
	STR	R0, [R1]
	
	BL HabilitaLCDCmd
	
	BL DesabilitaLCD
	
	MOV R0, #40
	BL SysTick_Wait1us
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que envia comandos com espera de 1,64ms
; Par�metro de entrada: R0 -> Comando
; Par�metro de sa�da: N�o tem
EnviaComando1640
	PUSH {LR}
	PUSH {R0}
	BL DesabilitaLCD
	
	LDR R1, =GPIO_PORTK_AHB_DATA_R
	POP {R0}
	STR	R0, [R1]
	
	BL HabilitaLCDCmd
	
	BL DesabilitaLCD
	
	MOV R0, #1640
	BL SysTick_Wait1us
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o que envia o cursor para home
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
CursorHome
	PUSH {LR}
	MOV R0, #0x80
	BL EnviaComando1640
	POP {LR}
	BX LR

GPIOPortJ_Handler
	LDR R0, =GPIO_PORTJ_AHB_ICR_R
	MOV R1, #2_1
	STR	R1, [R0]

	MOV R0, #0x0
	MOVT R0, #0x2000
	MOV R1, #0x0
	STR R1, [R0], #4
	STR R1, [R0], #4
	STRH R1, [R0]
	BX LR

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo