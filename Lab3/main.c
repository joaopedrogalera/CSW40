#include <stdint.h>

void PLL_Init(void);
void SysTick_Init(void);
void SysTick_Wait1ms(uint32_t delay);
void GPIO_Init(void);
void motorPassoInteiroHorario(uint32_t voltas);
void motorPassoInteiroAntiHorario(uint32_t voltas);
void motorMeioPassoHorario(uint32_t voltas);
void motorMeioPassoAntiHorario(uint32_t voltas);

void IniciaLCD(void);
void CursorHome(void);
void EscreveCaracter(char carac);
uint32_t leTeclado(void);
void EnviaComando1640(uint32_t);
void timer_init(void);

extern int8_t aborted;
extern int8_t running;

int main(void){
	char textVoltas[] = "N voltas (0=10)\0";
	char textSent1[] = "Sentido\0";
	char textSent2[] = "A horario/B anti\0";
	char textVel1[] = "Velocidade\0";
	char textVel2[] = "C meio/D compl\0";
	char textRst[] = "FIM\0";
	
	uint32_t i, nVoltas, sentido, veloc;
	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	timer_init();
	IniciaLCD();
	CursorHome();

	//Inicio
	while(1){
		aborted = 0;
		EnviaComando1640(0x01);
		for(i=0;textVoltas[i]!='\0';i++){
			EscreveCaracter(textVoltas[i]);
		}

		do{
			nVoltas = leTeclado();
		}while(nVoltas>9);
	
		if(nVoltas==0){
			nVoltas=10;
		}
		EnviaComando1640(0x01);
		for(i=0;textSent1[i]!='\0';i++){
			EscreveCaracter(textSent1[i]);
		}
		EnviaComando1640(0xC0);
		for(i=0;textSent2[i]!='\0';i++){
			EscreveCaracter(textSent2[i]);
		}
		
		do{
			sentido = leTeclado();
		}while(!(sentido=='A'||sentido=='B'));
	
		EnviaComando1640(0x01);
		for(i=0;textVel1[i]!='\0';i++){
			EscreveCaracter(textVel1[i]);
		}
		EnviaComando1640(0xC0);
		for(i=0;textVel2[i]!='\0';i++){
			EscreveCaracter(textVel2[i]);
		}
		do{
			veloc = leTeclado();
		}while(!(veloc=='C'||veloc=='D'));
		EnviaComando1640(0x01);
		
		running = 1;
		if(sentido=='A'){
			if(veloc=='C'){
				motorMeioPassoHorario(nVoltas);
			}
			else{
				motorPassoInteiroHorario(nVoltas);
			}
		}
		else{
			if(veloc=='C'){
				motorMeioPassoAntiHorario(nVoltas);
			}
			else{
				motorPassoInteiroAntiHorario(nVoltas);
			}
		}
		running = 0;
	
		EnviaComando1640(0x01);
		for(i=0;textRst[i]!='\0';i++){
			EscreveCaracter(textRst[i]);
		}
		while(leTeclado()!='*'){}
		
	}
}
