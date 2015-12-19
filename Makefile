
AVRDIR	= d:\Programme\Arduino\hardware\tools\avr
MMCU328	= atmega328p
MMCU45	= attiny45
BAUD328 = 115200
#BAUD328 = 19200
BAUD45	= 19200
PORT	= COM3
PROG328 = arduino
#PROG328 = stk500v1
PROG45  = stk500v1

# nothing to be configured below

FILESCommon = music-data.asm music-main.asm
FILES328    = music-328.asm ATmega368-port.asm notes-328.asm $(FILESCommon)
FILES45     = music-45.asm  ATtiny45-port.asm  notes-45.asm  $(FILESCommon)

ALL:	music-328.328.hex music-45.45.hex

Upload328: music-328.328.hex
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU328) -c $(PROG328) -P $(PORT) -b $(BAUD328) -D -U flash:w:$<:i

Upload45: music-45.45.hex
	$(AVRDIR)\bin\avrdude -v -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU45) -c $(PROG45) -P $(PORT) -b $(BAUD45) -U flash:w:$<:i

ReadFuses328:
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU328) -c $(PROG328) -P $(PORT) -b $(BAUD328) -U lfuse:r:lfuse328.hex:i
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU328) -c $(PROG328) -P $(PORT) -b $(BAUD328) -U hfuse:r:hfuse328.hex:i
	$(AVRDIR)\bin\avrdude -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU328) -c $(PROG328) -P $(PORT) -b $(BAUD328) -U efuse:r:efuse328.hex:i

ReadFuses45:
	$(AVRDIR)\bin\avrdude -v -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU45) -c $(PROG45) -P $(PORT) -b $(BAUD45) -U lfuse:r:lfuse45.hex:i
	$(AVRDIR)\bin\avrdude -v -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU45) -c $(PROG45) -P $(PORT) -b $(BAUD45) -U hfuse:r:hfuse45.hex:i
	$(AVRDIR)\bin\avrdude -v -C $(AVRDIR)\etc\avrdude.conf -p $(MMCU45) -c $(PROG45) -P $(PORT) -b $(BAUD45) -U efuse:r:efuse45.hex:i

notes-328.asm: Notes.rb
	ruby Notes.rb 16000000 8000 > $@

notes-45.asm: Notes.rb
	ruby Notes.rb 1000000 4000 > $@

music-data.asm: Ly2Asm.rb
	ruby Ly2Asm.rb > $@

music-328.328.o: $(FILES328)
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MMCU328) -o $@ $<

music-45.45.o: $(FILES45)
	$(AVRDIR)\bin\avr-as -g -mmcu=$(MMCU45) -o $@ $<

%.328.elf: %.328.o 
	$(AVRDIR)\bin\avr-ld -o $@ $<

%.45.elf: %.45.o
	$(AVRDIR)\bin\avr-ld -o $@ $<

%.328.hex: %.328.elf
	$(AVRDIR)\bin\avr-objcopy -O ihex -R .eeporm $< $@

%.45.hex: %.45.elf
	$(AVRDIR)\bin\avr-objcopy -O ihex -R .eeporm $< $@

Clean:
	del *.o *.elf *.hex music-data.asm notes-328.asm notes-45.asm *~

Help:
	@echo 'make [UploadNNN] [Clean] [ReadFusesNNN] [Help]'
	@echo '  NNN=328|45'
