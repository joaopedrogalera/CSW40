#include <stdint.h>
#include "tm4c1294ncpdt.h"

#define GPIO_PORTA  (0x1) //bit 1
#define GPIO_PORTF  (0x0020) //bit 6
#define GPIO_PORTN  (0x1000) //bit 12

void timer_init(void);
void SysTick_Wait1ms(uint32_t delay);
void EscreveCaracter(char carac);
void EnviaComando1640(uint32_t);

extern char oper;

void GPIO_Init(void){
		uint32_t aux;
		//Inicia clock UART0
		SYSCTL_RCGCUART_R = 0x1;
		
		while((SYSCTL_PRUART_R & 0x1) != 0x1){}
			
		UART0_CTL_R = UART0_CTL_R & 0xFFFFFFFE;
			
		UART0_IBRD_R = 520;
		UART0_FBRD_R = 0;
			
		UART0_LCRH_R = (0x3 << 5)|(0x1<<4);
		UART0_CC_R = 0x0;
			
		UART0_CTL_R = (0x1 << 9)|(0x1 << 8)|0x1;
			
		SYSCTL_RCGCGPIO_R = SYSCTL_RCGCGPIO_R | GPIO_PORTA | GPIO_PORTF | GPIO_PORTN;
			
		while((SYSCTL_RCGCGPIO_R&(GPIO_PORTA | GPIO_PORTF | GPIO_PORTN))!=(GPIO_PORTA | GPIO_PORTF | GPIO_PORTN)){}
			
		GPIO_PORTA_AHB_AMSEL_R = 0x00;
			
		aux = GPIO_PORTA_AHB_PCTL_R & 0xFFFFFF00;
		GPIO_PORTA_AHB_PCTL_R = aux | 0x11;
			
		aux = GPIO_PORTA_AHB_AFSEL_R & 0xFFFFFF00;
		GPIO_PORTA_AHB_AFSEL_R = aux | 0x3;
			
		aux = GPIO_PORTA_AHB_DEN_R & 0xFFFFFF00;
		GPIO_PORTA_AHB_DEN_R = aux | 0x3;
			
			
		//LEDs
		// 2. Limpar o AMSEL para desabilitar a analógica
		GPIO_PORTF_AHB_AMSEL_R = 0x00;
		GPIO_PORTN_AMSEL_R = 0x00;
		
		// 3. Limpar PCTL para selecionar o GPIO
		GPIO_PORTF_AHB_PCTL_R = 0x00;
		GPIO_PORTN_PCTL_R = 0x00;

		// 4. DIR para 0 se for entrada, 1 se for saída
		GPIO_PORTF_AHB_DIR_R = 0x11; //BIT0 e 4
		GPIO_PORTN_DIR_R = 0x03; //BIT0 e 1
		
		// 5. Limpar os bits AFSEL para 0 para selecionar GPIO sem função alternativa	
		GPIO_PORTF_AHB_AFSEL_R = 0x00; 
		GPIO_PORTN_AFSEL_R = 0x00; 
		
		// 6. Setar os bits de DEN para habilitar I/O digital	
		GPIO_PORTF_AHB_DEN_R = 0x11; //Bit0 e 4
		GPIO_PORTN_DEN_R = 0x03; 		   //Bit0 e 1
		
}

void timer_init(void){
	uint32_t aux;
	SYSCTL_RCGCTIMER_R = SYSCTL_RCGCTIMER_R | 0x4;
	while((SYSCTL_RCGCTIMER_R & 0x4) != 0x4 ){}
	TIMER2_CTL_R = TIMER2_CTL_R & 0xfffffffe;
	TIMER2_CFG_R = 0x00;
	aux = TIMER2_TAMR_R & 0xfffffffc;
	TIMER2_TAMR_R = aux | 0x02;
	TIMER2_TAILR_R = 39999999;
	TIMER2_TAPR_R = 0x00;
	TIMER2_ICR_R = TIMER2_ICR_R | 0x1;
	TIMER2_IMR_R = TIMER2_IMR_R | 0x1;
	NVIC_PRI5_R = 4 << 29;
	NVIC_EN0_R = 1 << 23;
	TIMER2_CTL_R = TIMER2_CTL_R | 0x1;
}

char leUART(void){
	//espera fila ter alguma coisa
	while(UART0_FR_R & (0x1 << 4)){}
		
	return((uint8_t)UART0_DR_R&0xFF);
}

void escreveUART(char* c){
	uint32_t i;
	
	for(i=0;c[i]!='\0';i++){
		while(UART0_FR_R & (0x1 << 5)){}
		UART0_DR_R = c[i];
	}
}

void ledAdd(){
	GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R & 0xffffffee;
	if(GPIO_PORTN_DATA_R&0x02){
		GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R & 0xfffffffd;
	}
	else{
		GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R | 0x02;
	}
}

void ledSub(){
	GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R & 0xffffffee;
	if(GPIO_PORTN_DATA_R&0x01){
		GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R & 0xfffffffe;
	}
	else{
		GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R | 0x01;
	}
}

void ledMul(){
	GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R & 0xfffffffc;
	if(GPIO_PORTF_AHB_DATA_R&0x10){
		GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R & 0xffffffef;
	}
	else{
		GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R | 0x10;
	}
}

void ledDiv(){
	GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R & 0xfffffffc;
	if(GPIO_PORTF_AHB_DATA_R&0x01){
		GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R & 0xfffffffe;
	}
	else{
		GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R | 0x01;
	}
}

void ledOff(){
	GPIO_PORTF_AHB_DATA_R = GPIO_PORTF_AHB_DATA_R & 0xffffffee;
	GPIO_PORTN_DATA_R = GPIO_PORTN_DATA_R & 0xfffffffc;
}

void Timer2A_Handler(void){
	TIMER2_ICR_R = 0x1;
	switch(oper){
		case '+':
			ledAdd();
		break;
		case '-':
			ledSub();
		break;
		case '*':
			ledMul();
		break;
		case '/':
			ledDiv();
		break;
		default:
			ledOff();
		break;
	}
}
