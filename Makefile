#
# Makefile for the Head Over Heels reverse-engineering.
#

ASM_FILES = $(shell find src/ -type f -name '*.asm')
BIN_FILES = $(wildcard bin/*)

.PHONY: all
all: diss_check check graphics

########################################################################
# Rules to disassemble the memory image.
#

# Build a memory image from the .z80 game file.
out/memimage.bin: memimage/unz80.lua memimage/memimage.z80
	mkdir -p out/
	lua memimage/unz80.lua memimage/memimage.z80 > out/memimage.bin

# Build the disassembler used to pull the memory image apart.
out/diss: memimage/diss.c
	cc $< -o $@

# Dissassemble the memory image. This generates the .asm file from
# which the reversing was done.
out/memimage.asm: out/diss out/memimage.bin
	cd out && ./diss

# Recompile it back to a binary for a check...
out/memimage.rom: out/memimage.asm
	zasm $< -o $@

# And perform the check
.PHONY: diss_check
diss_check: out/memimage.bin out/memimage.rom
	diff out/memimage.bin out/memimage.rom

########################################################################
# Build the image from source, and compare it against the one from the
# memory image.

# Build the image from source.
out/HOH.bin: $(ASM_FILES) $(BIN_FILES)
	mkdir -p out/
	zasm src/HOH.asm -o out/HOH.bin -l out/HOH.list -w

# Check the binary built from the sources matches the one from the
# memory image.
.PHONY: check
check: out/HOH.bin
	diff out/memimage.bin out/HOH.bin

########################################################################
# Extract graphics images from the binary files.
#
# Somewhat messy as Makefile entries.

out/img_3x56.xbm: graphics/xbmify.lua bin/img_3x56.bin
	mkdir -p out/
	lua graphics/xbmify.lua 3 bin/img_3x56.bin > out/img_3x56.xbm

out/img_3x32.xbm: graphics/xbmify.lua bin/img_3x32.bin
	mkdir -p out/
	lua graphics/xbmify.lua 3 bin/img_3x32.bin > out/img_3x32.xbm

out/img_3x24.xbm: graphics/xbmify.lua bin/img_3x24.bin
	mkdir -p out/
	lua graphics/xbmify.lua 3 bin/img_3x24.bin > out/img_3x24.xbm

out/img_4x28.xbm: graphics/xbmify.lua bin/img_4x28.bin
	mkdir -p out/
	lua graphics/xbmify.lua 4 bin/img_4x28.bin > out/img_4x28.xbm

out/img_2x24.xbm: graphics/xbmify.lua bin/img_2x24.bin
	mkdir -p out/
	lua graphics/xbmify.lua 2 bin/img_2x24.bin > out/img_2x24.xbm

out/img_chars.xbm: graphics/xbmify.lua bin/img_chars.bin
	mkdir -p out/
	lua graphics/xbmify.lua 1 bin/img_chars.bin > out/img_chars.xbm

out/img_walls.xbm: graphics/xbmify.lua bin/img_walls.bin
	mkdir -p out/
	lua graphics/xbmify.lua 2 bin/img_walls.bin > out/img_walls.xbm

out/img_2x6.xbm: graphics/xbmify.lua bin/img_2x6.bin
	mkdir -p out/
	lua graphics/xbmify.lua 2 bin/img_2x6.bin > out/img_2x6.xbm

out/screen.gif: bin/screen.scr
	mkdir -p out/
	scr2gif bin/screen.scr
	mv bin/screen.gif out/screen.gif

.PHONY: graphics
graphics: out/img_3x56.xbm out/img_3x32.xbm out/img_3x24.xbm \
          out/img_4x28.xbm out/img_2x24.xbm out/img_chars.xbm \
          out/img_walls.xbm out/img_2x6.xbm out/screen.gif