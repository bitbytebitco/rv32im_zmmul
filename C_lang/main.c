#include <stdint.h>

#define PERIPH_32              (volatile uint32_t*)
#define PORT_0_ADDR         (* (PERIPH_32 0x00000FF0 )) 

void gpio_test(){
    int a = 0;

    while(1){

        if(a >= 5){
            PORT_0_ADDR = 0xFFFFFFFF;
            a = 0;
        } else {
            PORT_0_ADDR = 0x00000000;
        }
        a++;
    }
}

int main() {


    return 0;
}
