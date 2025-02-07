CC=arm-none-eabi-
CFLAGS=-mthumb -mcpu=cortex-m4 -gdwarf-2 -g
INCS=-I .
LIBS=
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
As = $(wildcard *.s)
AsOBJ = $(As:.s=.o)

Project_name=lab4-unit3-cortex-m4

all: $(Project_name).bin
	@echo "================================Build is Done================================"

%.o: %.c
	$(CC)gcc.exe -c $(INCS) $(CFLAGS) $< -o $@

$(Project_name).elf: $(OBJ) $(AsOBJ)
	$(CC)ld.exe -T linker-script.ld $(LIBS) $(OBJ) $(AsOBJ) -o $@ -Map=Map_file.map
	cp $(Project_name).elf  $(Project_name).axf
$(Project_name).bin: $(Project_name).elf
	$(CC)objcopy.exe -O binary $< $@
   
clean_all: 
	rm *.o *.elf *.bin *.map
	@echo "====================================CLEAN===================================="
clean:
	rm *.elf *.bin *.map