
AVRDIR	= d:\Programme\Arduino\hardware\tools\avr

#MMCU	?= atmega328p
MMCU	?= attiny45
PORT	?= COM6

ifeq ($(MMCU),attiny45)
PROG	= stk500v1
BAUD	= 19200
ERASE	= 
else
PROG	= arduino
BAUD	= 115200
ERASE	= -D
endif

# nothing to be configured below

ALL:	$(MMCU).hex

Upload: $(MMCU).hex
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU) -c $(PROG) -P $(PORT) -b $(BAUD) $(ERASE) -U flash:w:$<:i

ReadFuses:
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU) -c $(PROG) -P $(PORT) -b $(BAUD) -U lfuse:r:lfuse.$(MMCU).hex:i -U hfuse:r:hfuse.$(MMCU).hex:i -U efuse:r:efuse.$(MMCU).hex:i

notes.atmega328p.asm: Notes.rb
	ruby Notes.rb 16000000 8000 > $@

notes.attiny45.asm: Notes.rb
	ruby Notes.rb 1000000 4000 > $@

songs.asm: Ly2Asm.rb
	ruby Ly2Asm.rb > $@

$(MMCU).o: $(MMCU).inc

main.$(MMCU).o: main.asm main.inc
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MMCU) -defsym __$(MMCU)__=1 -o $@ $<

%.o:	%.asm
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MMCU) -defsym __$(MMCU)__=1 -o $@ $<

$(MMCU).elf: $(MMCU).o main.$(MMCU).o notes.$(MMCU).o songs.o
	$(AVRDIR)\bin\avr-ld -o $@ $(MMCU).o main.$(MMCU).o notes.$(MMCU).o songs.o

%.hex:	%.elf
	$(AVRDIR)\bin\avr-objcopy -O ihex -R .eeporm $< $@

Clean:
	del *.o *.elf *.hex songs.asm notes.*.asm *~

Help:
	@echo 'make [UploadNNN] [Clean] [ReadFusesNNN] [Help]'
	@echo '  NNN=328|45'
