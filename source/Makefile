
AVRDIR	= d:\Programme\Arduino\hardware\tools\avr

#MCU	?= atmega328p
MCU	?= attiny45
PORT	?= COM4

ifeq ($(MCU),attiny45)
PROG	= stk500v1
BAUD	= 19200
ERASE	=
DEFSYM  = 45
else
PROG	= arduino
BAUD	= 115200
ERASE	= -D
DEFSYM  = 328
endif

# nothing to be configured below

ALL:	$(MCU).hex

Upload: $(MCU).hex
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MCU) -c $(PROG) -P $(PORT) -b $(BAUD) $(ERASE) -U flash:w:$<:i

notes.atmega328p.asm: Notes.rb
	ruby Notes.rb 16000000 8000 > $@

notes.attiny45.asm: Notes.rb
	ruby Notes.rb 1000000 4000 > $@

songs.asm: Ly2Asm.rb
	ruby Ly2Asm.rb > $@

$(MCU).o: $(MCU).inc

main.$(MCU).o: main.asm main.inc
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MCU) -defsym MCU=$(DEFSYM) -o $@ $<

%.o:	%.asm
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MCU) -defsym MCU=$(DEFSYM) -o $@ $<

$(MCU).elf: $(MCU).o main.$(MCU).o notes.$(MCU).o songs.o
	$(AVRDIR)\bin\avr-ld -o $@ $(MCU).o main.$(MCU).o notes.$(MCU).o songs.o

%.hex:	%.elf
	$(AVRDIR)\bin\avr-objcopy -O ihex -R .eeporm $< $@

Clean:
	del *.o *.elf *.hex songs.asm notes.*.asm *~

Help:
	@echo 'make [MCU=atmega328p|attiny45] [Upload] [Clean] [Help]'
