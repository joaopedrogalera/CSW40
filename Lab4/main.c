#include <stdint.h>

void PLL_Init(void);
void SysTick_Init(void);
void SysTick_Wait1ms(uint32_t delay);
void GPIO_Init(void);
void timer_init(void);

char leUART(void);
void escreveUART(char* c);

char velocidade, comando;
uint8_t sentido, velOrigem;

int main(void){
	char charAux[] = "x\0";
	PLL_Init();
	SysTick_Init();
	GPIO_Init();

	escreveUART("\n\n\n\n\n\0");
	escreveUART("888     888 88888888888 8888888888 8888888b.  8888888b.\r\n\0");  
	escreveUART("888     888     888     888        888   Y88b 888   Y88b \r\n\0");
	escreveUART("888     888     888     888        888    888 888    888 \r\n\0");
	escreveUART("888     888     888     8888888    888   d88P 888   d88P \r\n\0");
	escreveUART("888     888     888     888        8888888P\"  8888888P\"  \r\n\0");
	escreveUART("888     888     888     888        888        888 T88b   \r\n\0");
	escreveUART("Y88b. .d88P     888     888        888        888  T88b  \r\n\0");
	escreveUART(" \"Y88888P\"      888     888        888        888   T88b \r\n\0");
	escreveUART("\n\n\n\n\0");
	
	escreveUART("MOTOR PARADO\r\n\0");
	escreveUART("Insira o sentido de rotacao: h -> horario, a -> anti-horario\r\n\0");

	do{
		sentido = leUART();
	}while(!(sentido=='a'||sentido=='h'));
	
	if(sentido=='h'){
		escreveUART("\r\nSentido horario\r\n\0");
	}
	else{
		escreveUART("\r\nSentido anti-horario\r\n\0");
	}	
	
	escreveUART("Como deseja controlar a velocidade?: t -> terminal, p -> potenciometro\r\n\0");

	do{
		velOrigem = leUART();
	}while(!(velOrigem=='t'||velOrigem=='p'));
	
	if(velOrigem=='t'){
		escreveUART("\r\nControlando pelo terminal\r\n\0");
		escreveUART("Comandos disponiveis:\r\n\t 0 -> Motor Parado\r\n\t 1 -> 50% da velocidade maxima\r\n\t 2 -> 60% da velocidade maxima\r\n\t 3 -> 70% da velocidade maxima\r\n\t 4 -> 80% da velocidade maxima\r\n\t 5 -> 90% da velocidade maxima\r\n\t 6 -> 100% da velocidade maxima\r\n\0");
		
		do{
			velocidade = leUART();
		}while(!(velocidade>='0'&&velocidade<='6'));
		
		escreveUART("Velocidade \0");
		charAux[0] = velocidade;
		escreveUART(charAux);
		escreveUART(" selecionada\r\n\0");
	}
	else{
		escreveUART("\r\nControlando pelo potenciometro\r\n\0");
	}	
	
	timer_init();
	
	while(1){
		comando = leUART();
		if(velOrigem=='t'&&comando>='0'&&comando<='6'){
			velocidade = comando;
			escreveUART("Velocidade \0");
			charAux[0] = velocidade;
			escreveUART(charAux);
			escreveUART(" selecionada\r\n\0");
		}
		else if(comando=='h'||comando=='a'){
			sentido = comando;
			if(sentido=='h'){
				escreveUART("\r\nSentido horario\r\n\0");
			}
			else{
				escreveUART("\r\nSentido anti-horario\r\n\0");
			}	
		}
	}
}
