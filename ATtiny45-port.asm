;;; ========================================================================
;;; ATtiny48 Ports
;;; ========================================================================

	.equ ROMEND, 0x7ff
	.equ RAMSTART, 0x060
	.equ RAMEND, 0x15f
	.equ SREG, 0x3f
	.equ SPH, 0x3e
	.equ SPL, 0x3d

	.equ GIMSK, 0x3b
	.equ INT0, 6
	.equ PCIE, 5

	.equ TIMSK, 0x39
	.equ OCIE1A, 6
	.equ OCIE1B, 5
	.equ OCIE0A, 4
	.equ OCIE0B, 3
	.equ TOIE1, 2
	.equ TOIE0, 1

	.equ MCUCR, 0x35
	.equ BODS, 7
	.equ PUD, 6
	.equ SE, 5
	.equ SM1, 4
	.equ SM0, 3
	.equ BODSE, 2
	.equ ISC01, 1
	.equ ISC00, 0

	.equ TCCR0B, 0x33
	.equ WGM02, 3
	.equ CS02, 2
	.equ CS01, 1
	.equ CS00, 0

	.equ TCCR1, 0x30
	.equ COM1A1, 5
	.equ COM1A0, 4
	.equ CS13, 3
	.equ CS12, 2
	.equ CS11, 1
	.equ CS10, 0

	.equ TCNT1, 0x2f
	
	.equ OCR1A, 0x2e

	.equ TCCR0A, 0x2a
	.equ COM0A1, 7
	.equ COM0A0, 6
	.equ COM0B1, 5
	.equ COM0B0, 4
	.equ WGM01, 1
	.equ WGM00, 0

	.equ OCR0A, 0x29

	.equ CLKPR, 0x26
	.equ CLKPCE, 7
	.equ CLKPS3, 3
	.equ CLKPS2, 2
	.equ CLKPS1, 1
	.equ CLKPS0, 0
	
	.equ PORTB, 0x18
	.equ DDRB, 0x17
	.equ PINB, 0x16

	.equ PCMSK, 0x15

	.equ PRR, 0x20	; Power Reduction Register
	.equ PRTIM1, 3  ; Power Reduction Timer/Counter1
	.equ PRTIM0, 2  ; Power Reduction Timer/Counter0
	.equ PRUSI,  1  ; Power Reduction USI
	.equ PRADC,  0  ; Power Reduction ADC
	
