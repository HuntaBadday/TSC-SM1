# TSC-SM1

## Features
- 16 bits
- 15 instructions
- 12 ALU operations
- 13 general purpose registers
- Stack
- Maskable interrupts
- Up to 64k words addressable memory

## Links
- SM1: https://steamcommunity.com/sharedfiles/filedetails/?id=3484405324
- DS1 Demo computer: 
- SM1 Documentation and assembly reference: https://huntabadday.com/docs/TSC-SM1.pdf

## Folder structure of this repo
- /src/ | Assembly programs
- /src/lib/ | Assembly libraries
- /src/sm1.asm | Assembly definitions for the [customasm](https://github.com/hlorenzi/customasm) assembler
- /src/ds1-demo/ | Demo program used for the DS1

## DS1 Memory Structure
```
0x0000 - 0x0FFF : 4K RAM
0xD000 - 0xD00F : Bitmap display
0xD010 -        : LFR random number generator
0xF000 - 0xFFFF : 4K ROM
```