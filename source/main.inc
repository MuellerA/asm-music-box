;;; (c) 2015 Andreas Müller
;;;     see LICENSE.md

;;; ========================================================================
;;; main.inc
;;; ========================================================================

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
	;; scratch registers: r12-r15, r20-r25

	;; Memory Offsets
	.equ memIntTimer,    0x00
	.equ memIntTimerCnt, 0x01
	.equ memNextSongLo,  0x02
	.equ memNextSongHi,  0x03
	.equ memInt0Cnt,     0x04

;;; ========================================================================
;;; EOF
;;; ========================================================================
