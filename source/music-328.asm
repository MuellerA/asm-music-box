;;; (c) 2015 Andreas Müller
;;;     see LICENSE.md

;;; ========================================================================
;;; music-328.asm - main file for ATmega328
;;; ========================================================================

	.include "ATmega368-port.asm"

	.equ OCRXA, OCR2A
	.equ PIN_SPK, 6		; OC0A / Port D #6 / ARDUINO 6
	.equ PIN_BTN, 2		; Int0 / Port D #2 / ARDUINO 2
	.equ PIN_LED, 4		; Port B #4 / ARDUINO 12

	;; Register statics, aliases
	.equ Val00, 0
	.equ Val01, 1
	.equ ValFF, 2
	.equ MemBase, 4
	.equ MemPitch, 6
	.equ MemDuration, 8
	.equ MemTOC, 10
	.equ MemTOCLo, 10
	.equ MemTOCHi, 11
	
;;; ========================================================================
;;; interrupt table
;;; ========================================================================
.org 0
	rjmp RESET	; Reset Handler
	nop
	rjmp INT_0 	; IRQ0 Handler
	nop
	reti		; IRQ1 Handler
	nop
	reti 		; PCINT0 Handler
	nop
	reti 		; PCINT1 Handler
	nop
	reti 		; PCINT2 Handler
	nop
	reti 		; Watchdog Timer Handler
	nop
	rjmp INT_Timer	; Timer2 Compare A Handler
	nop
	reti 		; Timer2 Compare B Handler
	nop
	reti 		; Timer2 Overflow Handler
	nop
	reti 		; Timer1 Capture Handler
	nop
	reti		; Timer1 Compare A Handler
	nop
	reti 		; Timer1 Compare B Handler
	nop
	reti		; Timer1 Overflow Handler
	nop
	reti	 	; Timer0 Compare A Handler
	nop
	reti	 	; Timer0 Compare B Handler
	nop
	reti		; Timer0 Overflow Handler
	nop
	reti 		; SPI Transfer Complete Handler
	nop
	reti 		; USART, RX Complete Handler
	nop
	reti 		; USART, UDR Empty Handler
	nop
	reti 		; USART, TX Complete Handler
	nop
	reti		; ADC Conversion Complete Handler
	nop
	reti 		; EEPROM Ready Handler
	nop
	reti 		; Analog Comparator Handler
	nop
	reti 		; 2-wire Serial Interface Handler
	nop
	reti	 	; Store Program Memory Ready Handler
	nop

;;; ========================================================================
;;; ISRs
;;; ========================================================================
	
RESET:
	;; SP
	ldi r16,lo8(RAMEND)
	out SPL,r16 		; Stack Pointer Low ramend
	ldi r16,hi8(RAMEND)
	out SPH,r16 		; Stack Pointer high ramend

	;; set interrupt table to 0x0002
	in r16, MCUCR
	ldi r17, 1 << IVCE
	ldi r18, ~(1 << IVSEL)
	or r17, r16
	and r18, r16
	out MCUCR, r17
	out MCUCR, r18

	;; enable INT0, disable INT1
	ldi r16, 0x00
	sts EICRA, r16		; raise on low level
	ldi r16, 0x01
	out EIMSK, r16		; enable INT0, disable INT1  	

	;; set clock prescale register
	ldi r16, 0x80
	sts CLKPR, r16
	ldi r16, 0x00
	sts CLKPR, r16
	
	;; disable Timer0 Counter A Interrupt, Clear Timer on Compare mode
	ldi r16, (0<<COM0A1)|(1<<COM0A0) | (1<<WGM01)|(0<<WGM00)
	out TCCR0A, r16
	ldi r16, 0
	out TCCR0B, r16
	sts TIMSK0, r16

	;; disable PCINTx
	ldi r16, 0
	;sts PCMSK2, r16	; disable pcint23:16
	;sts PCMSK1, r16	; disable pcint14:8
	;sts PCMSK0, r16	; disable pcint 7:0
	sts PCICR, r16		; disable all
	
	;; disable Watchdog

	;; disable Timer1
	ldi r16, 0
	sts TCCR1A, r16
	sts TCCR1B, r16
	sts TCCR1C, r16
	sts TIMSK1, r16

	;; enable Timer2, div8 prescale, ctc mode
	ldi r16, 0x02
	sts TCCR2A, r16
	sts TCCR2B, r16
	sts TIMSK2, r16
	ldi r16, 250
	sts OCR2A, r16
	
	;; disable spi
	;; disable usart
	;; disable adc
	;; disable eeprom
	;; disable ac
	;; disable si
	;; disable spm

	;; set ports
	ldi r16, (1 << PIN_LED)
	out DDRB, r16
	ldi r16, 0x00
	out PORTB, r16
	out DDRC, r16
	out PORTC, r16

	ldi r16, 1<<PIN_SPK
	out DDRD, r16
	ldi r16, 1<<PIN_BTN
	out PORTD, r16

	;; power save
	ldi r16, (1<<PRTWI)|(1<<PRTIM1)|(1<<PRSPI)|(1<<PRUSART0)|(1<<PRADC)
	sts PRR, r16
	
	ldi r16, 0x01
	out SMCR, r16		; sleep mode: idle

	;; init statics
	clr Val00		; r0 = 00
	clr Val01
	inc Val01		; r1 = 01
	clr ValFF
	dec ValFF		; r2 = ff

	ldi r16, lo8(RAMSTART)	; r5:4 == RAMSTART
	ldi r17, hi8(RAMSTART)
	movw MemBase, r16
	ldi r16, lo8(pitch)	; r7:6 == Pitch
	ldi r17, hi8(pitch)
	movw MemPitch, r16
	ldi r16, lo8(duration)	; r9:8 == Duration
	ldi r17, hi8(duration)
	movw MemDuration, r16
	ldi r16, lo8(toc)	; r11:10 == toc
	ldi r17, hi8(toc)
	movw MemTOC, r16

	ldi r16, 0x00		; SREG = 0x00
	out SREG,r16

	rjmp mainReset

;;; ========================================================================

INT_0:				; ISR Button
	ldi r16, (1 << PIN_LED)
	out DDRB, r16
	ldi r16, 1<<PIN_SPK
	out DDRD, r16

	ldi r16, 0x01
	out SMCR, r16		; sleep mode: idle

	;; SP
	ldi r16,lo8(RAMEND)
	out SPL,r16 		; Stack Pointer Low ramend
	ldi r16,hi8(RAMEND)
	out SPH,r16 		; Stack Pointer high ramend

	rjmp mainInt0

INT0Enable:
	out EIMSK, Val01
	ret
INT0Disable:
	out EIMSK, Val00
	ret

;;; ========================================================================
	
INT_Timer:			; ISR Duration Timer
	push r31
	push r30
	push r17
	push r16

	in r17, SREG
	movw r30, MemBase
	std Z + memIntTimer, ValFF
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
	out DDRD, r20
	
	ldi r20, 0x05
	out SMCR, r20		; sleep mode: power down mode
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

.include "notes-328.asm"

;;; ========================================================================
;;; common generated data
;;; ========================================================================

.include "music-data.asm"
	
;;; ========================================================================
;;; EOF
;;; ========================================================================
