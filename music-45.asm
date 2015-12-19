;;; ========================================================================
;;; music-45.asm - main file for ATtiny45
;;; ========================================================================

	.include "ATtiny45-port.asm"

	.equ OCRXA, OCR1A+32
	.equ PIN_SPK, 0		; PB0/MOSI/DI/SDA/AIN0/OC0A/OC1A/AREF/PCINT0
	.equ PIN_BTN, 2		; PB2/SCK/USCK/SCL/ADC1/T0/INT0/PCINT2
	.equ PIN_LED, 4		; PB4
	
;;; ========================================================================
;;; interrupt table
;;; ========================================================================
.org 0
	rjmp RESET	; RESET External Pin, Power-on Reset, Brown-out Reset, Watchdog Reset
	rjmp INT_0	; INT0 External Interrupt Request 0
	reti		; PCINT0 Pin Change Interrupt Request 0
	rjmp INT_Timer	; TIMER1_COMPA Timer/Counter1 Compare Match A
	reti		; TIMER1_OVF Timer/Counter1 Overflow
	reti		; TIMER0_OVF Timer/Counter0 Overflow
	reti		; EE_RDY EEPROM Ready
	reti		; ANA_COMP Analog Comparator
	reti		; ADC ADC Conversion Complete
	reti		; TIMER1_COMPB Timer/Counter1 Compare Match B
	reti		; TIMER0_COMPA Timer/Counter0 Compare Match A
	reti		; TIMER0_COMPB Timer/Counter0 Compare Match B
	reti		; WDT Watchdog Time-out
	reti		; USI_START USI START
	reti		; USI_OVF USI Overflow

;;; ========================================================================
;;; ISRs
;;; ========================================================================
	
RESET:
	;; SP
	ldi r16,lo8(RAMEND)
	out SPL,r16 		; Stack Pointer Low ramend
	ldi r16,hi8(RAMEND)
	out SPH,r16 		; Stack Pointer high ramend

	;; enable INT0
	ldi r16, 0x40
	out GIMSK, r16

	;; clock prescale register: div8
	ldi r16, 1<<CLKPCE
	out CLKPR, r16
	ldi r16, (0<<CLKPS3)|(0<<CLKPS2)|(1<<CLKPS1)|(1<<CLKPS0)
	out CLKPR, r16

	;; Timer0: Clear Timer on Compare mode
	ldi r16, (0<<COM0A1)|(1<<COM0A0) | (1<<WGM01)|(0<<WGM00)
	out TCCR0A, r16
	ldi r16, 0
	out TCCR0B, r16

	;; Timer1: div1 prescale
	ldi r16, (0<<COM1A1)|(0<<COM1A0) | (0<<CS13)|(0<<CS12)|(0<<CS11)|(1<<CS10)
	out TCCR1, r16
	ldi r16, 250
	out OCR1A, r16
	
	;; disable Timer0 Counter A Interrupt
	ldi r16, (1 << OCIE1A)
	out TIMSK, r16

	;; set ports
	ldi r16, (1<<PIN_LED)|(1<<PIN_SPK)
	out DDRB, r16
	ldi r16, (1<<PIN_BTN)
	out PORTB, r16
	ldi r16, 0x00
	out PCMSK, r16

	;; power save
	ldi r16, (1<<PRUSI)|(1<<PRADC)
	out PRR, r16
	
	in r16, MCUCR
	andi r16, 0b11000111
	ori  r16, 0b00100000	; sleep mode: idle
	out MCUCR, r16

	;; statics, aliases
	eor r0, r0		; r0 == 0
	mov r1, r0
	inc r1			; r1 == 1
	mov r2, r0
	dec r2			; r2 == ff

	ldi r16, lo8(RAMSTART)	; r5:4 == RAMSTART
	ldi r17, hi8(RAMSTART)
	movw r4, r16
	ldi r16, lo8(pitch)	; r7:6 == Pitch
	ldi r17, hi8(pitch)
	movw r6, r16
	ldi r16, lo8(duration)	; r9:8 == Duration
	ldi r17, hi8(duration)
	movw r8, r16
	ldi r16, lo8(toc)	; r11:10 == toc
	ldi r17, hi8(toc)
	movw r10, r16
	;; scratch registers: r12-r15, r20-r25
	
	;; SREG
	ldi r16,0   	;
	out SREG,r16 	;

	rjmp mainReset

;;; ========================================================================
	
INT_0:				; ISR Button
	ldi r16, (1<<PIN_LED)|(1<<PIN_SPK)
	out DDRB, r16
	
	in r16, MCUCR
	andi r16, 0b11000111
	ori  r16, 0b00100000	; sleep mode: idle
	out MCUCR, r16

	;; SP
	ldi r16,lo8(RAMEND)
	out SPL,r16 		; Stack Pointer Low ramend
	ldi r16,hi8(RAMEND)
	out SPH,r16 		; Stack Pointer high ramend

	rjmp mainInt0

INT0Enable:
	push r16
	in r16, GIMSK
	sbr r16, 1<<INT0
	out GIMSK, r16
	pop r16
	ret
INT0Disable:
	push r16
	in r16, GIMSK
	cbr r16, 1<<INT0
	out GIMSK, r16
	pop r16
	ret
	
;;; ========================================================================

INT_Timer:			; ISR Duration Timer
	push r31
	push r30
	push r17
	push r16

	in r17, SREG
	out TCNT1, r0
	movw r30, r4		; memBase
	std Z + memIntTimer, r2	; 0xff
	ldd r16, Z + memIntTimerCnt
	inc r16
	std Z + memIntTimerCnt, r16
	brne _INT_TimerRet
	sbi PINB, PIN_LED

_INT_TimerRet:
	out SREG, r17

	pop r16
	pop r17
	pop r30
	pop r31
	reti

;;; ========================================================================
;;; SoC specific routines
;;; ========================================================================

PowerDown:	
	ldi r20, 0x00		; set all pins to input
	out DDRB, r20
	
	in r20, MCUCR
	cbr r20, 0b00111000
	sbr r20, 0b00110000	; sleep mode: power down
	out MCUCR, r20
_PowerDown0:
	sleep
	rjmp _PowerDown0	; only INT0 can wake up and reinitialize

;;; ========================================================================
;;; common routines
;;; ========================================================================

.include "music-main.asm"

;;; ========================================================================
;;; SoC specific generated data
;;; ========================================================================

.include "notes-45.asm"

;;; ========================================================================
;;; common generated data
;;; ========================================================================

.include "music-data.asm"
	
;;; ========================================================================
;;; EOF
;;; ========================================================================
