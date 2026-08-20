.text
	li $t1,0
	li $s1,4
	li $s2,5
	sub $t0,$s1,$s2
	blez $t0,DO
	j END
DO:	
	li $t1,1
END:

