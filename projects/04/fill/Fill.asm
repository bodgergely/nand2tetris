// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.



// either fills or clears the screen - R0 contains the screen val
// current screen word offset will be kept in R15
// R5 contains -1 which is the ffff
(READKEYBOARD)
	@KBD
	D=M
	@R0
	M=D
	@FILLSCREEN
	D;JEQ		// jump if no keyboard was pressed
	@0			// otherwise create bitmap of ffff as color value which will fill the screen black
	D=A-1		// 0-1 => ffff
	@R0			// store ffff to R0
	M=D

(FILLSCREEN)
	@R15		// init offset
	M=0			
			    // decide if we are past the last row
(PAINT)
	@R15
	D=M
	@8192
	D=D-A
	@READKEYBOARD
	D;JGE		

	@SCREEN
	D=A			// load screen
	@R15
	D=D+M		// add offset
	@R1
	M=D			// store final addr to R1
	@R0
	D=M			// store paint val to D
	@R1			// copy D to final addr
	A=M
	M=D

	@R15
	M=M+1		// increment offset
	@PAINT	
	0;JMP
	
