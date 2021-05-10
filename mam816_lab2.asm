# Makayla Miles
# mam816

# preserves a0, v0
.macro print_str %str
	.data
	print_str_message: .asciiz %str
	.text
	push a0
	push v0
	la a0, print_str_message
	li v0, 4
	syscall
	pop v0
	pop a0
.end_macro

        .data
	display: .word 0 
	operation: .byte 0
        .text
	
.globl main
main:
	
	#while(true) {
      _loop:
            lw a0, display 
            li v0, 1
            syscall
            print_str "\nOperation(=,+,-,*,/,c,q): "
            li v0, 12
            syscall
            sb v0, operation
         # switch(operation) {
            lb t0, operation
            beq t0, 'q', _quit
            beq t0, 'c', _clear
            beq t0, '+', _get_operand
            beq t0, '-', _get_operand
            beq t0, '*', _get_operand
            beq t0, '/', _get_operand
            beq t0, '=', _get_operand
            j _default
            
            
            _quit:
            	    print_str " \n"
            	    li v0, 10
            	    syscall
            	   # j _break
            	    
            _clear:
            	    print_str " \n"    	   
            	    sw zero, display     	    
            	    j _break
            	    
            _get_operand:
                    li v0, 5
                    syscall
                    # switch(operand) {
                    beq t0, '+', _case_add
                    beq t0, '-', _case_sub
                    beq t0, '*', _case_mul
                    beq t0, '/', _case_div
                    beq t0, '=', _case_eq
                    
                          _case_add:
                                  lw a0, display
                                  add a0, v0, a0
                                  sw a0, display
                         
                          j _break
                          _case_sub:
                                  lw a0, display
                                  sub a0, a0 , v0
                                  sw a0, display
                    
                          j _break
                          _case_mul:
                                  lw a0, display
                                  mul a0, a0, v0
                                  sw a0, display
                       
                          j _break
                          _case_div:
                                  bne v0, 0, _reg_div
                                  beq v0, 0, _else
                                       _reg_div:
                                        
                                              lw, a0, display
                                              div a0, a0, v0
                                              sw a0, display 
                                              j _endif           
                                      # j _break
                                       _else:
                                               print_str "Trying to divide by 0!\n"   
                                      
                                       _endif:              
                                               j _break
                          _case_eq:
                                  sw v0, display
                              
                                  j _break
                    	  
                        #}    	    	    
            _default:  
                    print_str " Huh? Please reenter\n"
                                      
_break:
        #}           		        
      j _loop  
