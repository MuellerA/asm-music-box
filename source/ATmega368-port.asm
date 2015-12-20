;;; (c) 2015 Andreas Müller
;;;     see LICENSE.md

;;; ========================================================================
;;; ATmega368 Ports
;;; ========================================================================

	.equ ROMEND, 0x3fff
	.equ RAMSTART, 0x100	; y - register 29 28
	.equ RAMEND, 0x8ff	; EOSRAM
	
	.equ SREG, 0x3f 	; Status Register
	.equ SPH, 0x3e 		; Stack Pointer High Register
	.equ SPL, 0x3d		; Stack Pointer Low Register

	.equ MCUCR, 0x35	; MCU control register
	.equ IVSEL, 1		; MCUCR #1: Interrupt Vector Select
	.equ IVCE, 0
	
	.equ PORTB, 0x05	; Port B Data Register
	.equ DDRB, 0x04		; Port B data direction register 1=output 0=input
	.equ PINB, 0x03		; Port B Input pins address

	.equ PORTC, 0x08        ; Port C Data Register
	.equ DDRC, 0x07		; Port C data direction register 1=output 0=input
	.equ PINC, 0x06		; Port C Input pins address

	.equ PORTD, 0x0b        ; Port D Data Register
	.equ DDRD, 0x0a		; Port D data direction register 1=output 0=input
	.equ PIND, 0x09		; Port D Input pins address

	;; INT0, INT1
	.equ PCMSK2, 0x6d	; pin change interrupts
	.equ PCMSK1, 0x6c
	.equ PCMSK0, 0x6b
	.equ PCICR, 0x68	; Pin Change Interrupt Control Register

	.equ EICRA, 0x69	; External Interrupt Control Register A / INT1:0
	.equ EIMSK, 0x1d	; External Interrupt Mask Register / PININT23:0
	.equ SPMCSR, 0x37	; Store Program Memory Control and Status Register
	.equ SPMEM, 0x00	; Store Program Memory
	.equ BLBSET, 0x03	; Boot Lock Bit Set

	;; TIMER 0
	.equ TCCR0A, 0x24	; Timer/Counter Control Register A
	.equ COM0A1, 7		; Compare Output Mode
	.equ COM0A0, 6
	.equ COM0B1, 5
	.equ COM0B0, 4
	.equ WGM01, 1		; Waveform Generation Mode Bit
	.equ WGM00, 0

	.equ TCCR0B, 0x25	; Timer/Counter Control Register B
	.equ FOC0A, 7		; Force Output Compare A
	.equ FOC0B, 6		; Force Output Compare B
	.equ WGM02, 3		; Waveform Generation Mode Bit
	.equ CS02, 2		; Clock Select Bit Description
	.equ CS01, 1
	.equ CS00, 0

	.equ TCNT0, 0x26	; Timer/Counter Register
	.equ OCR0A, 0x27	; Output Compare Register A
	.equ OCR0B, 0x28	; Output Compare Register B
	.equ TIMSK0, 0x6e	; Timer/Counter Interrupt Mask Register

	;; TIMER 1
	.equ TCCR1A, 0x80	; Timer/Counter Control Register A
	.equ COM1A1, 7		; Compare Output Mode
	.equ COM1A0, 6
	.equ COM1B1, 5
	.equ COM1B0, 4
	.equ WGM11, 1		; Waveform Generation Mode Bit
	.equ WGM10, 0

	.equ TCCR1B, 0x81	; Timer/Counter Control Register B
	.equ INC1, 7		; Force Output Compare A
	.equ WGM13, 4		; Waveform Generation Mode Bit
	.equ WGM12, 3
	.equ CS12, 2		; Clock Select Bit Description
	.equ CS11, 1
	.equ CS10, 0

	.equ TCCR1C, 0x82	; Timer/Counter1 Control Register C
	.equ FOC1A, 7
	.equ FOC1B, 6
	
	.equ TCNT1H, 0x85	; Timer/Counter1
	.equ TCNT1L, 0x84
	.equ OCR1AH, 0x89	; Output Compare Register 1 A
	.equ OCR1AL, 0x88
	.equ OCR1BH, 0x8b	; Output Compare Register 1 B
	.equ OCR1BL, 0x8a
	.equ ICR1H, 0x87	; Input Capture Register 1
	.equ ICR1L, 0x88
	.equ TIMSK1, 0x6f	; Timer/Counter1 Interrupt Mask Register
	
	;; TIMER 2
	.equ TCCR2A, 0xb0
	.equ COM2A1, 7		; Compare Output Mode
	.equ COM2A0, 6
	.equ COM2B1, 5
	.equ COM2B0, 4
	.equ WGM21, 1		; Waveform Generation Mode Bit
	.equ WGM20, 0
	
	.equ TCCR2B, 0xb1	; Timer/Counter Control Register B
	.equ FOC2A, 7		; Force Output Compare A
	.equ FOC2B, 6		; Force Output Compare B
	.equ WGM22, 3		; Waveform Generation Mode Bit
	.equ CS22, 2		; Clock Select Bit Description
	.equ CS21, 1
	.equ CS20, 0

	.equ TCNT2, 0xb2	; Timer/Counter Register
	.equ OCR2A, 0xb3	; Output Compare Register A
;;; ========================================================================
;;; ATmega368 Ports
;;; ========================================================================

	.equ ROMEND, 0x3fff
	.equ RAMSTART, 0x100	; y - register 29 28
	.equ RAMEND, 0x8ff	; EOSRAM
	
	.equ SREG, 0x3f 	; Status Register
	.equ SPH, 0x3e 		; Stack Pointer High Register
	.equ SPL, 0x3d		; Stack Pointer Low Register

	.equ MCUCR, 0x35	; MCU control register
	.equ IVSEL, 1		; MCUCR #1: Interrupt Vector Select
	.equ IVCE, 0
	
	.equ PORTB, 0x05	; Port B Data Register
	.equ DDRB, 0x04		; Port B data direction register 1=output 0=input
	.equ PINB, 0x03		; Port B Input pins address

	.equ PORTC, 0x08        ; Port C Data Register
	.equ DDRC, 0x07		; Port C data direction register 1=output 0=input
	.equ PINC, 0x06		; Port C Input pins address

	.equ PORTD, 0x0b        ; Port D Data Register
	.equ DDRD, 0x0a		; Port D data direction register 1=output 0=input
	.equ PIND, 0x09		; Port D Input pins address

	;; INT0, INT1
	.equ PCMSK2, 0x6d	; pin change interrupts
	.equ PCMSK1, 0x6c
	.equ PCMSK0, 0x6b
	.equ PCICR, 0x68	; Pin Change Interrupt Control Register

	.equ EICRA, 0x69	; External Interrupt Control Register A / INT1:0
	.equ EIMSK, 0x1d	; External Interrupt Mask Register / PININT23:0
	.equ SPMCSR, 0x37	; Store Program Memory Control and Status Register
	.equ SPMEM, 0x00	; Store Program Memory
	.equ BLBSET, 0x03	; Boot Lock Bit Set

	;; TIMER 0
	.equ TCCR0A, 0x24	; Timer/Counter Control Register A
	.equ COM0A1, 7		; Compare Output Mode
	.equ COM0A0, 6
	.equ COM0B1, 5
	.equ COM0B0, 4
	.equ WGM01, 1		; Waveform Generation Mode Bit
	.equ WGM00, 0

	.equ TCCR0B, 0x25	; Timer/Counter Control Register B
	.equ FOC0A, 7		; Force Output Compare A
	.equ FOC0B, 6		; Force Output Compare B
	.equ WGM02, 3		; Waveform Generation Mode Bit
	.equ CS02, 2		; Clock Select Bit Description
	.equ CS01, 1
	.equ CS00, 0

	.equ TCNT0, 0x26	; Timer/Counter Register
	.equ OCR0A, 0x27	; Output Compare Register A
	.equ OCR0B, 0x28	; Output Compare Register B
	.equ TIMSK0, 0x6e	; Timer/Counter Interrupt Mask Register

	;; TIMER 1
	.equ TCCR1A, 0x80	; Timer/Counter Control Register A
	.equ COM1A1, 7		; Compare Output Mode
	.equ COM1A0, 6
	.equ COM1B1, 5
	.equ COM1B0, 4
	.equ WGM11, 1		; Waveform Generation Mode Bit
	.equ WGM10, 0

	.equ TCCR1B, 0x81	; Timer/Counter Control Register B
	.equ INC1, 7		; Force Output Compare A
	.equ WGM13, 4		; Waveform Generation Mode Bit
	.equ WGM12, 3
	.equ CS12, 2		; Clock Select Bit Description
	.equ CS11, 1
	.equ CS10, 0

	.equ TCCR1C, 0x82	; Timer/Counter1 Control Register C
	.equ FOC1A, 7
	.equ FOC1B, 6
	
	.equ TCNT1H, 0x85	; Timer/Counter1
	.equ TCNT1L, 0x84
	.equ OCR1AH, 0x89	; Output Compare Register 1 A
	.equ OCR1AL, 0x88
	.equ OCR1BH, 0x8b	; Output Compare Register 1 B
	.equ OCR1BL, 0x8a
	.equ ICR1H, 0x87	; Input Capture Register 1
	.equ ICR1L, 0x88
	.equ TIMSK1, 0x6f	; Timer/Counter1 Interrupt Mask Register
	
	;; TIMER 2
	.equ TCCR2A, 0xb0
	.equ COM2A1, 7		; Compare Output Mode
	.equ COM2A0, 6
	.equ COM2B1, 5
	.equ COM2B0, 4
	.equ WGM21, 1		; Waveform Generation Mode Bit
	.equ WGM20, 0
	
	.equ TCCR2B, 0xb1	; Timer/Counter Control Register B
	.equ FOC2A, 7		; Force Output Compare A
	.equ FOC2B, 6		; Force Output Compare B
	.equ WGM22, 3		; Waveform Generation Mode Bit
	.equ CS22, 2		; Clock Select Bit Description
	.equ CS21, 1
	.equ CS20, 0

	.equ TCNT2, 0xb2	; Timer/Counter Register
	.equ OCR2A, 0xb3	; Output Compare Register A
	.equ OCR2B, 0xb4	; Output Compare Register B
	.equ TIMSK2, 0x70	; Timer/Counter Interrupt Mask Register

	.equ SMCR, 0x33		; Sleep Mode Control Register
	
	.equ CLKPR, 0x61	; Clock Prescale Register
	.equ CLKPCE, 7
	.equ CLKPS3, 3
	.equ CLKPS2, 2
	.equ CLKPS1, 1
	.equ CLKPS0, 0
	
	.equ PRR, 0x64		; Power Reduction Register
	.equ PRTWI, 7		; Power Reduction TWI
	.equ PRTIM2, 6		; Power Reduction Timer/Counter2
	.equ PRTIM0, 5		; Power Reduction Timer/Counter0
	.equ PRTIM1, 3		; Power Reduction Timer/Counter1
	.equ PRSPI, 2		; Power Reduction Serial Peripheral Interface
	.equ PRUSART0, 1	; Power Reduction USART0
	.equ PRADC, 0		; Power Reduction ADC
	.equ OCR2B, 0xb4	; Output Compare Register B
	.equ TIMSK2, 0x70	; Timer/Counter Interrupt Mask Register

	.equ SMCR, 0x33		; Sleep Mode Control Register
	
	.equ CLKPR, 0x61	; Clock Prescale Register
	.equ CLKPCE, 7
	.equ CLKPS3, 3
	.equ CLKPS2, 2
	.equ CLKPS1, 1
	.equ CLKPS0, 0
	
	.equ PRR, 0x64		; Power Reduction Register
	.equ PRTWI, 7		; Power Reduction TWI
	.equ PRTIM2, 6		; Power Reduction Timer/Counter2
	.equ PRTIM0, 5		; Power Reduction Timer/Counter0
	.equ PRTIM1, 3		; Power Reduction Timer/Counter1
	.equ PRSPI, 2		; Power Reduction Serial Peripheral Interface
	.equ PRUSART0, 1	; Power Reduction USART0
	.equ PRADC, 0		; Power Reduction ADC
