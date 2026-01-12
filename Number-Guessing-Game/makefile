# Makefile untuk Number Guessing Game
# Arch Linux x86-64 Assembly

ASM = nasm
LD = ld
ASMFLAGS = -f elf64
LDFLAGS = 

# Target executable
TARGET = guess_game

# Object files
OBJS = main.o random.o io.o game.o

# Default target
all: $(TARGET)

# Link semua object files
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJS)

# Compile main.asm
main.o: main.asm
	$(ASM) $(ASMFLAGS) main.asm -o main.o

# Compile random.asm
random.o: random.asm
	$(ASM) $(ASMFLAGS) random.asm -o random.o

# Compile io.asm
io.o: io.asm
	$(ASM) $(ASMFLAGS) io.asm -o io.o

# Compile game.asm
game.o: game.asm
	$(ASM) $(ASMFLAGS) game.asm -o game.o

# Clean build files
clean:
	rm -f $(OBJS) $(TARGET)

# Run the game
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run