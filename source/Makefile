
#AVRBIN	= d:\Programme\Arduino\hardware\tools\avr\bin
#AVRETC	= d:\Programme\Arduino\hardware\tools\avr\etc
#RM	= del
AVRBIN	= /usr/bin
AVRETC	= /etc
RM	= rm -f

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
	$(AVRBIN)/avrdude -C $(AVRETC)/avrdude.conf -p $(MCU) -c $(PROG) -P $(PORT) -b $(BAUD) $(ERASE) -U flash:w:$<:i

notes.atmega328p.asm: Notes.rb
	ruby Notes.rb 16000000 8000 > $@

notes.attiny45.asm: Notes.rb
	ruby Notes.rb 1000000 4000 > $@

songs.asm: Ly2Asm.rb
	ruby Ly2Asm.rb > $@

$(MCU).o: $(MCU).inc

main.$(MCU).o: main.asm main.inc
	$(AVRBIN)/avr-as -g -mmcu=$(MCU) -defsym MCU=$(DEFSYM) -o $@ $<

%.o:	%.asm
	$(AVRBIN)/avr-as -g -mmcu=$(MCU) -defsym MCU=$(DEFSYM) -o $@ $<

$(MCU).elf: $(MCU).o main.$(MCU).o notes.$(MCU).o songs.o
	$(AVRBIN)/avr-ld -o $@ $(MCU).o main.$(MCU).o notes.$(MCU).o songs.o

%.hex:	%.elf
	$(AVRBIN)/avr-objcopy -O ihex -R .eeporm $< $@

Clean:
	$(RM) *.o *.elf *.hex songs.asm notes.*.asm *~

Help:
	@echo 'make [MCU=atmega328p|attiny45] [Upload] [Clean] [Help]'
