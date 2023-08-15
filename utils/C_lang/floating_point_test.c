#include <stdint.h>

#define PERIPH_32              (volatile uint32_t*)
#define PORT_0_ADDR         (* (PERIPH_32 0x00000FF0 )) 

#define F_A         (* (PERIPH_32 0x00000FF1 )) 
#define F_B         (* (PERIPH_32 0x00000FF2 )) 
#define F_C         (* (PERIPH_32 0x00000FF5 )) 
#define F_R         (* (PERIPH_32 0x00000FE1 )) 
#define F_STAT         (* (PERIPH_32 0x00000FE2 )) 
#define F_CTRL         (* (PERIPH_32 0x00000FF3 )) 
#define F_CYCLES         (* (PERIPH_32 0x00000FF4 )) 

int get_result(int A, int B, int C){

    if((F_STAT && 0x01) == 1){
        while((F_STAT && 0x02) != 1){ }
    }

    F_A = A;
    F_B = B;
    F_C = C;
    
    // set enable
    F_CTRL = 0x00000001;
    int poll = 1;
    int stat, result;

    while(poll == 1) {
        stat = F_STAT && 0b00000001; // o_done HIGH?
        if(stat == 1){
            result = F_R;
            poll = 0;
        }
    }
    PORT_0_ADDR = result;
    F_CTRL = 0x00000002;
    F_CTRL = 0x00000000;
    
    return 0;
}

int main() {

    F_CYCLES = 0x00000008; 

    int a, b, c, result;

    while(1){
        // P1 
        a = 0x41A40000;
        b = 0x420F0000;
        c = 0x40200000;
        get_result(a, b, c);

        // P2
        a = 0xC20F0000;
        b = 0x41A40000;
        c = 0x40200000;
        get_result(a, b, c);

        // P3
        a = 0x420F0000;
        b = 0x41B40000;
        c = 0x40200000;
        get_result(a, b, c);

        // P4
        a = 0x41460000;
        b = 0xC0B00000;
        c = 0x40200000;
        get_result(a, b, c);

        // P5 
        a = 0xC1460000;
        b = 0x40B00000;
        c = 0x40200000;
        get_result(a, b, c);
    }

    return 0;
}



/*
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
*/
