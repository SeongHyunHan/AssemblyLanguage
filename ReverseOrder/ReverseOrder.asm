include emu8086.inc

ORG 100h
mov ax,1000
mov ds,ax 

begin:
mov ax,7000h
mov ds,ax
mov di, 0000
mov si, 000eh
call pthis
db "Enter a String: ",0  

mov dx,15 
call GET_STRING
   
putc 0dh
putc 0ah
call pthis
db "Output: ", 0  

mov cx,dx
mov di, 000Dh
push 20h       ;push 20 indicated that there are no more space

spaceCheck:   ;This label loop through entire string to find a location of space
    mov bl, [di]
    cmp bl, 20h
    je spaceFound
    cmp di, 0000h
    je prepareForPrint
    sub di, 1
Loop spaceCheck

spaceFound:    ;This label push the location of space to stack register
    push DI   
    sub di, 1
    cmp dx, 0
    jnz spaceCheck
    
prepareForPrint: ;This will check to see if the string have space or not
    pop DI
    cmp DI, 20h
    je noSpace
    mov BP, DI
    cmp dx, 0
    jnz StringProcess
    
noSpace:            ;If there is no space in string it will send register location to the end of memory
    mov SI, DI
    mov DI, 000dh  

StringProcess: 
    mov bl,[di]
        
    cmp di, 0000
        jl checkStop
        
    cmp di, si
        je checkStop    
    
    cmp bl, 2Fh
        jle not_a_symbol
    
    cmp bl, 39h
        jle number_underscore 
        
    cmp bl, 40h
        jle not_a_symbol
        
    cmp bl,5Ah	
        jle convert_to_lower
    
    cmp bl, 5Fh
        je  number_underscore
    
    cmp bl, 60h
        jle not_a_symbol
    
    cmp bl,7ah	
        jle convert_to_upper
        
    cmp bl, 7bh 
        jge not_a_symbol
        
    cmp bl, 20h
        call pthis
    
    Loop StringProcess 

not_a_symbol:
    sub DI, 1
    cmp Dx, 0
    jnz StringProcess

number_underscore:
    putc bl
    sub DI, 1
    cmp Dx, 0
    jnz StringProcess

convert_to_lower: 
    add bl,20h
    putc bl
    sub DI,1
    cmp Dx, 0
    jnz StringProcess 

convert_to_upper: 
    sub bl,20h
    putc bl
    sub DI,1
    cmp Dx, 0
    jnz StringProcess  

checkStop:
    pop DI 
    cmp DI, 0000h
    jle stop
    cmp SI, 20h
    je stop  
    mov bl, 20h     ;print out space
    putc bl
    mov SI, BP
    mov BP, DI
    cmp dx, 0
    jnz StringProcess 
    
lastString: 
    mov bl, 20h     ;print out space
    putc bl
    mov SI, BP
    mov DI, 000dh
    cmp dx, 0
    jnz StringProcess  

stop:
    putc 0dh
    putc 0ah
    call pthis
    db "Goodbye", 0
    hlt 
    
DEFINE_PTHIS
DEFINE_GET_STRING
end