.data
    	arr: .word -5, 14, 6, 4, 5, -14, 10
.text
   	addi   $s1, $zero, 0    	# i = 0
	la     $s2, arr            	# loading array
	addi   $s3, $zero, 7    	# n = 7
	addi   $s4, $zero, 1    	# step = 1
loop:    
	slt    $t2, $s1, $s3    	# i < n
	beq    $t2, $zero, endloop
	add    $t1, $s1, $s1
	add    $t1, $t1, $t1    
	add    $t1, $t1, $s2
	lw     $t0, 0($t1)        	# load the value of A[i]
check:            			# Check if A[i] is negative or not
        slt    $t3, $t0, $zero     	# A[i] < 0
        beq    $t3, $zero, compare 	# if A[i] >=0, then branch. 
        sub    $t0 $zero, $t0    	# If A[i] < 0, calculate 0 - A[i] to get an positive integer
compare:            			# Find the greatest absolute value of A[i]
        slt    $t3, $t0, $s5         	# Check if A[i] < the greatest absolute value 
        bne    $t3, $zero, endif	# If the above statement is true, then branch.
        addi   $s5, $t0, 0		# Update the new greatest absolute value
        
endif:
        add    $s1, $s1, $s4   		# i = i + step  
    	j loop
endloop:



