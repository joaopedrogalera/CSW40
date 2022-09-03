#include <stdint.h>

void PLL_Init(void);
void SysTick_Init(void);
void SysTick_Wait1ms(uint32_t delay);
void GPIO_Init(void);
void timer_init(void);

char leUART(void);
void escreveUART(char* c);

char oper = 0;

void escreveNum(int32_t n){
	char c[] = "x\0";
	uint32_t print = 0;
	if(n<0){
		escreveUART("-\0");
		n *= -1;
	}
	c[0] = (char) (n/100000)+48;
	n = n%100000;
	if(c[0]!='0'){
		escreveUART(c);
		print = 1;
	}
	
	c[0] = (char) (n/10000)+48;
	n = n%10000;
	if(c[0]!='0'||print){
		escreveUART(c);
		print = 1;
	}
	
	c[0] = (char) (n/1000)+48;
	n = n%1000;
	if(c[0]!='0'||print){
		escreveUART(c);
		print = 1;
	}
	
	c[0] = (char) (n/100)+48;
	n = n%100;
	if(c[0]!='0'||print){
		escreveUART(c);
		print = 1;
	}
	
	c[0] = (char) (n/10)+48;
	n = n%10;
	if(c[0]!='0'||print){
		escreveUART(c);
	}
	
	c[0] = n+48;
	escreveUART(c);
}

int main(void){
	//uint8_t c[] = "caracter recebido: x\r\n\0";
	char c[] = "x\0";    
	uint32_t a, b, i;
	char aux;
	
	
	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	timer_init();
		
	while(1){
		i = 0;
		a = 0;
		b = 0;
		do{
			aux = leUART();
			if(aux>='0'&&aux<='9'&&i<3){
				a = a*10 + (uint32_t)(aux-48);
				i++;
				c[0]=aux;
				escreveUART(c);
			}
			else if((aux=='+'||aux=='-'||aux=='*'||aux=='/')&&i>0){
				i=4;
				oper=aux;
				c[0]=aux;
				escreveUART(c);
			}
		}while(i<4);
		
		i = 0;
		do{
			aux = leUART();
			if(aux>='0'&&aux<='9'&&i<3){
				b = b*10 + (uint32_t)(aux-48);
				i++;
				c[0]=aux;
				escreveUART(c);
			}
			else if(aux=='='&&i>0){
				i=4;
				c[0]=aux;
				escreveUART(c);
			}
		}while(i<4);


		switch(oper){
			case '+':
				escreveNum((int32_t) a + b);
			break;
			case '-':
				escreveNum((int32_t) a - b);
			break;
			case '*':
				escreveNum((int32_t) a * b);
			break;
			case '/':
				if(b==0){
					escreveUART("Erro: divisao por zero\0");
					break;
				}
				escreveNum((int32_t) a / b);
			break;
		}
		escreveUART("\r\n\0");
		oper = '\0';
	}
}
