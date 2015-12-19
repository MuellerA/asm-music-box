;;; ========================================================================
;;; music-main.asm - common file
;;; ========================================================================

	.equ memIntTimer,    0x00
	.equ memIntTimerCnt, 0x01
	.equ memNextSongLo,  0x02
	.equ memNextSongHi,  0x03
	.equ memInt0Cnt,     0x04

	.equ MAX_SONGS,      0x03 ; max songs before sleep
	.equ IRQ_SLEEP_CNT,  0x02 ; min int0 intervals to sleep
	
;;; ========================================================================
;;; main
;;; ========================================================================

mainInt0:
	ldi r16, 0xff		; pause
	ldi r17, 0x08
	rcall INT0Disable
	sei
	rcall playNote		; wait for INT0 to go away
	cli
	rcall INT0Enable

	movw r28, r4		; memBase
	ldi r19, MAX_SONGS	; sleep count

	ldd r16, Y + memInt0Cnt ; irq cnt >= 3 -> sleep
	cpi r16, IRQ_SLEEP_CNT
	brge _mainInt00
	inc r16
	std Y + memInt0Cnt, r16
_mainInt00:	
	sei
	cpi r16, IRQ_SLEEP_CNT
	brlt _mainLoop

	ldi r16, 0x00
	std Y + memInt0Cnt, r16
	rjmp PowerDown

mainReset:
	movw r28, r4		; memBase

	ldi r16, 0x00		; init irq cnt
	std Y + memInt0Cnt, r16
	
	ldi r19, MAX_SONGS	; sleep count

_mainLoop0:	
	std Y + memNextSongLo, r10 ; *memSong = toc
	std Y + memNextSongHi, r11 
	;; no jump

_mainLoop:
	cli
	ldd r30, Y + memNextSongLo
	ldd r31, Y + memNextSongHi
	
	lpm r16, z+		; get next song
	lpm r17, z+
	mov r20, r17		; check if end of songs
	and r20, r16
	cp r20, r2		; 0xff
	breq _mainLoop0

	std Y + memNextSongLo, r30 ; set next song
	std Y + memNextSongHi, r31

	ldi r20, 0x00		; reset irq cnt
	std Y + memInt0Cnt, r20
	
	sei
	
	rcall playSong

	dec r19
	breq PowerDown
	
	ldi r16, 0xff		; pause
	ldi r17, 0x00
	rcall playNote
	rjmp _mainLoop

;;; ========================================================================
;;; playSong
;;; r17:r16 to musicToc
;;; ========================================================================

playSong:
	push r31
	push r30
	push r17
	push r16
	
	movw r30, r16
	lpm r16, z+
	sts OCRXA, r16		; set speed
	lpm r16, z+		; skip padding
_playSongLoop:	
	lpm r16, z+
	lpm r17, z+
	mov r20, r17
	and r20, r16
	cp r20, r2		; 0xff
	breq _playSongRet
	rcall playSection
	rjmp _playSongLoop
	
_playSongRet:		
	pop r16
	pop r17
	pop r30
	pop r31
	ret
	
;;; ========================================================================
;;; playSection
;;; r17:r16 is set to Song Data
;;; ========================================================================

playSection:
	push r31
	push r30
	push r17
	push r16
	
	movw r30, r16		; song addr
_playSectionLoop:
	lpm r16, z+
	lpm r17, z+
	cp r17, r2		; 0xff
	breq _playSectionRet
	rcall playNote
	rjmp _playSectionLoop
	
_playSectionRet:
	pop r16
	pop r17
	pop r30
	pop r31
	ret
	
;;; ========================================================================
;;; play note
;;; r16 is set to pitch Pitch[r16]
;;; r17 is set to duration Duration[r17]
;;; ========================================================================

playNote:
	push r31
	push r30
	push r17
	push r16
	
	cp r16, r2		; 0xff
	breq _playNotePause

_playNotePitch:
	lsl r16
	movw r30, r6		; Pitch
	add r30, r16
	adc r31, r0		; 0x00

	lpm r16, z+		; div
	out TCCR0B, r16
	lpm r16, z+		; cnt
	out OCR0A, r16

	rjmp _playNoteDuration

_playNotePause:
	mov r16, r0		; 0x00
	out TCCR0B, r16		; disable timer
	out OCR0A, r16

_playNoteDuration:
	lsl r17
	lsl r17
	movw r30, r8		; Duration
	add r30, r17
	adc r31, r0		; 0x00

	lpm r16, z+		; ON
	lpm r17, z+
	rcall waitForTimer		

	lpm r16, z+		; OFF
	lpm r17, z+

	mov r20, r16
	or  r20, r17
	breq _playNoteRet
	
	mov r20, r0		; 0x00
	out TCCR0B, r20		; disable timer
	out OCR0A, r20

	rcall waitForTimer
_playNoteRet:	
	pop r16
	pop r17
	pop r30
	pop r31
	ret

;;; ========================================================================
;;; wait for t2
;;; input r17:r16 tick counter
;;; ========================================================================

waitForTimer:	
	push r31
	push r30

	movw r24, r16
	mov r20, r24
	or r20, r25
	breq _waitForTimerRet

	movw r30, r4		; memBase
_waitForTimerLoop1:		; Timer interrupt but ctr not 0
	cli
	std Z + memIntTimer, r0 	; 0x00
_waitForTimerLoop2:		; non Timer interrupt received
	sei
	sleep
	cli
	ldd r20, Z + memIntTimer
	cp r20, r0		; 0x00
	breq _waitForTimerLoop2
	sei
	sbiw r24, 1
	brne _waitForTimerLoop1
	
_waitForTimerRet:
	pop r30
	pop r31
	ret
	
;;; ========================================================================
;;; EOF
;;; ========================================================================
