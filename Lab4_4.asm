.text
start:
	li $s1,-2147483647
	li $s2,2
	li $t0,0 	#No Overflow is default status
	addu $s3,$s1,$s2 # s3 = s1 + s2
	xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
	bltz $t1,EXIT 	#If not, exit
	xor $t2,$s1,$s3	#Check if $s1 and $s3 have the same sign
	bgtz $t2,EXIT	#If true,exit
	li $t0,1 	#the result is overflow
EXIT:


