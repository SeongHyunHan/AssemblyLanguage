Reverse Character Order

Created by Seong Hyun Han

Worked in emu8086

Program takes input from the user then reverse its order to print it out.

Rule1. All uppercase in input have to change to lowercase, and same for the other way
	ex) input: schiZopreNIA     output: SCHIzOPREnia
Rule2. All String have to print in reverse order
	ex) input: schizoprenia     output: ainerpozihcs
Rule3. None of symbol allowed to print except underscore(_) and space.
	ex) input: schi*zop ren_ia  output: schizop ren_ia
Rule4. If the string contain space the program have to reverse it first half first then reverse rest of it.
	ex) input: schizo prenia    output: ozihcs ainerp

This program start from back of the memory, it will go through the string to check spaces.
If it found the space it will push location of space to stack register.
Once, it went through whole string for checking all space. 
It will pop the location of the space(Since stack register use last in first out (LIFO), it will give first space location in string)
If there is no space, program will goes to end of the memory again and start print backward.
If there is a space, the program will print backward from the space location.
When it reaches DI register less then 0000h, it will check there is more space or not.
If they have more space (by using POP), The previous space location will be store in other register(in this case BP) then DI will set up with new space location.
It will start print backward from new space location until DI register locatiion is equal to BP register.
The program will looping until it there is no more space in stack register (This program push 20h before program check space in input
 to let program knows there is no more space in stack register).

The input size is 15 bits. (14 input space possible)