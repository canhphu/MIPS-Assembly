#Laboratory Exercise 3, Home Assignment 1
addi $s2,$zero, 3 #j
addi $s1,$zero, 5 #i
addi $s3, $zero, 1 #m
addi $s4, $zero, 2 #n
start:
add $t0, $s2, $s1 #i+j
add $t4, $s3, $s4 # m+n
ble $t0, $t4, else #branch if i+j <= m+n
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip gelseh part
else: addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif:
