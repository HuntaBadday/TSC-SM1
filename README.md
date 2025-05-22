# TSC-SM1

The TSC-SM1 is a 16 bit CPU created in scrap mechanic.
<br>
If you encounter any bugs, or have questions about programming the CPU, message ``huntabadday`` on Discord.

## Links
- SM1 CPU: https://steamcommunity.com/sharedfiles/filedetails/?id=3484405324
- DS1 "Micro"Computer: https://steamcommunity.com/sharedfiles/filedetails/?id=3485562798
- SM1 documentation and assembly reference: https://huntabadday.com/docs/TSC-SM1.pdf

## More demo programs
If you wish for your program to be part of the DS1's demo, message me. If I like your program I may consider adding it to the demo.

### Program format and style
- The program must not interfere with the current demo's assembly labels.
- Use nesting where you can to avoid a mess of global labels.
- Proper indenting required.
- Please comment your code.

See demo program for suggested style.

## Features
- 16 bits
- 15 instructions
- 12 ALU operations
- 13 general purpose registers
- Stack
- Maskable interrupts
- Up to 64k words addressable memory

## Folder structure of this repo
- /src/ | Assembly programs
- /src/lib/ | Assembly libraries used by programs
- /src/sm1.asm | Assembly definitions for the [customasm](https://github.com/hlorenzi/customasm) assembler (Read the customasm wiki for assembler usage)
- /src/ds1-demo/ | Demo program used for the DS1

# DS1 "Micro"Computer
## Memory Structure
```
0x0000 - 0x0FFF : 4K RAM
0xD000 - 0xD0FF : Bitmap display
0xD100 - 0xD10F : Debug display
0xD110 -        : LFR random number generator
0xD120 -        : Score display
0xD121 -        : Controls input
0xF000 - 0xFFFF : 4K ROM
```
## Peripheral usage
### Bitmap
The bitmap display maps one pixel per address, where x00-x0F is line 0, x10-x1F is line 1, etc. The written pixel state will be the state of bit 0 when writing. First pixel is top-left

### Debug display
The debug display shows whole 16 bit values per line, first line is the top.

### Score display
The score display shows a decimal number from 0-255

### Controls
When pressing a button, it's state gets stored in a latch, so to read that value, first you must write any value to the controls to queue the input for reading, then the value can be read from the port. Bits 0-3 correspond to the buttons from left to right.

# Credits
- Control: CLA inside the SM1
- HerrVincling: Double dabble for score display