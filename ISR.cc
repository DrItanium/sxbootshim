//
// Created by jwscoggins on 3/27/21.
//
extern "C" void ISR0();
extern "C" void ISR1();
extern "C" void ISR2();
extern "C" void ISR3();
extern "C" void ISRBad();
extern "C" void ISR_NMI();

extern "C"
void
ISR0() {
}

extern "C"
void
ISR_NMI() {
}

extern "C"
void
ISR1() {
}
extern "C"
void
ISR2() {
}
extern "C"
void
ISR3() {
}

extern "C"
void
ISRBad() {
}
