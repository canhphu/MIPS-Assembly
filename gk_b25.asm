.data
	Message1: .asciiz "Nhap n: "
	Message2: .asciiz "Nhap mang: "
	Message3: .asciiz "Mang duoc sap xep la: "
	Errormsg: .asciiz "So luong nhap khong hop le"
	Errormsg2: .asciiz "So luong nhap qua gioi han"
	space:  .asciiz " "
	
	length: .space 10
	first_half: .space 40
	second_half: .space 40
	first_half_sorted: .space 40
	second_half_sorted: .space 40
	
.text
main:
	li $v0, 4
	la $a0, Message1 
	syscall 
	li $v0, 8 #Nhap n
	la $a0, length
	li $a1, 10
	syscall
	lb $t1, 1($a0)
convert_loop:
	lb $t0, 0($a0)
	beq $t0, 10, end_convert
	subi $t0, $t0, 48 #Convert into int
	bltz $t0, exit_message
	bge $t0, 23, exit_message
	mul $t2, $t2, 10
	add $t2, $t2, $t0
	addi $a0, $a0, 1
	beq $t1, 10, end_convert
	j convert_loop
end_convert:
	move $s0, $t2
	blez $s0, exit_message
	bgt $s0, 20, exit_message_2
read_info:
	li $v0, 4
	la $a0, Message2
	syscall
	li $t0, 0 #i=0 (Bien dem i theo n )
	li $t1, 0 #Bien tro vao dia chi phan tu cua mang
	srl $t2, $s0, 1 # m = n/2
	la $t1, first_half
read_loop:
first_loop:
	beq $t0, $t2,second_info
	li $v0, 5
	syscall
	sb $v0, 0($t1)
	addi $t1, $t1, 4 #Tro den dia chi tiep theo
	addi $t0, $t0, 1 #i=i+1
	j first_loop
second_info:
	li $t1, 0 #Reset dia chi
	la $t1, second_half
second_loop:
	beq $t0, $s0, sort
	li $v0, 5
	syscall
	sb $v0, 0($t1)
	addi $t1, $t1, 4 #Tro toi dia chi tiep theo
	addi $t0, $t0, 1 #i=i+1
	j second_loop
sort:
	li $t0, 0
	li $t1, 0
compare_couple_first_half:
	blt $t2, 2, sort_2 #Neu nhu mang first_half co nho hon 2 phan tu thi khong can so sanh
	#Kiem tra xem t2 co phai so le khong
	srl $t3, $t2, 1
	sub $t4, $t2, $t3
	bne $t3, $t4, change_first
	bge $t0, $t2, sort_2 # i >= m, ket thuc vong lap
	lb $t3, first_half($t1) #first_half[i]
	lb $t4, first_half+4($t1) #first_half{i+1}
	slt $t5, $t3, $t4 #first_half[i} < first_half[i+1] ? 1 : 0
	beqz $t5, swap_couple_first
	addi $t0, $t0, 2 #i=i+2
	addi $t1, $t1, 8 #Tro toi vi tri first_half[i+2]
	j compare_couple_first_half
change_first:
	subi $t2, $t2, 1
	j compare_couple_first_half
swap_couple_first:
	sb $t3, first_half+4($t1)
	sb $t4, first_half($t1)
	addi $t0, $t0, 2
	addi $t1, $t1, 8
	j compare_couple_first_half
sort_2:
	li $t0, 0
	li $t1, 0
	srl $t2, $s0, 1 #Khoi tao lai gia tri m 
	sub $s1, $s0, $t2 #s1 = n-m
compare_couple_second_half:
	blt $s1, 2, sort_3 #Neu nhu mang second_half co nho hon 2 phan tu thi khong can so sanh
	#Kiem tra xem s1 co phai so le khong
	srl $t3, $s1, 1
	sub $t4, $s1, $t3
	bne $t3, $t4, change_second
	bge $t0, $s1, sort_3 #i >= n-m, ket thuc vong lap
	lb $t3, second_half($t1) #second_half[i]
	lb $t4, second_half+4($t1) #second_half{i+1}
	slt $t5, $t3, $t4 #second_half[i} < second_half[i+1] ? 1 : 0
	beqz $t5, swap_couple_second
	addi $t0, $t0, 2
	addi $t1, $t1, 8
	j compare_couple_second_half
change_second:
	subi $s1, $s1, 1
	j compare_couple_second_half
swap_couple_second:
	sb $t3, second_half+4($t1)
	sb $t4, second_half($t1)
	addi $t0, $t0, 2
	addi $t1, $t1, 8
	j compare_couple_second_half
sort_3:
	li $t0,0
	li $t1,0
	sub $s1, $s0, $t2 #Khoi phuc gia tri s1 = n-m
merge_couple_first_half:
	addi $t6, $t1, 8 #i=i+2
load_the_first_element:
	blt $t2, 2, sorted_first_half
	sll $s6, $t2, 2 
	subi $s6, $s6, 4 #(Dia chi cua phan tu cuoi cung)
	lb $t3, first_half($t1) #first_half[i]
	lb $t4, first_half($t6) #first_half[i+2]
	bgt $t6, $s6, sorted_first_half #Neu nhu dia chi vuot qua phan tu cuoi cung thi ket thuc vong lap
	bgt $t1, $s6, sorted_first_half 
	slt $t5, $t3, $t4 # Neu nhu gia tri o i < i+2 ? 1:0
	beqz $t5, smallest
	addi $t6, $t6, 4 #Tro toi vi tri tiep theo sau i+2
	move $s2, $t3 #min = first_half[i]
	move $s4, $t1 #Luu dia chi cua min
	addi $t0, $t0, 1 #i=i+1
	j load_the_first_element
smallest:
	addi $t1, $t1, 4
	addi $t0, $t0, 1 #i=i+1
	move $s2, $t4 #min = first_half[i+2]
	move $s4, $t6 #Luu dia chi cua min
	j load_the_first_element
sorted_first_half:
	addi $s5, $zero, 100  #Dat gia tri cua phan tu nho nhat thanh mot so lon nhat de tranh bi lap
	sb $s5, first_half($s4) 
	addi $s3, $s3, 1  # Dem so luong phan tu trong mang moi
	sb $s2, first_half_sorted($t7) #first_half_sorted[i]
	addi $t7, $t7, 4
	bgt $s3, $t2, before_sort
	j sort_3
before_sort:
	li $s3, 0 #Reset bien dem 
sort_4:
	li $t0,0
	li $t1,0
merge_couple_second_half:
	addi $t6, $t1, 8 #i=i+2
load_the_first_element_second:
	blt $s1, 2, sorted_second_half
	sll $s6, $s1, 2 
	subi $s6, $s6, 4 #(Dia chi cua phan tu cuoi cung)
	lb $t3, second_half($t1) #second_half[i]
	lb $t4, second_half($t6) #second_half[i+2]
	bgt $t6, $s6, sorted_second_half #Neu nhu dia chi vuot qua phan tu cuoi cung thi ket thuc vong lap
	bgt $t1, $s6, sorted_second_half 
	slt $t5, $t3, $t4 # Neu nhu gia tri o i < i+2 ? 1:0
	beqz $t5, smallest_second
	addi $t6, $t6, 4 #Tro toi vi tri tiep theo sau i+2
	move $s2, $t3 #min = second_half[i]
	move $s4, $t1 #Luu dia chi cua min
	addi $t0, $t0, 1 #i=i+1
	j load_the_first_element_second
smallest_second:
	addi $t1, $t1, 4
	addi $t0, $t0, 1 #i=i+1
	move $s2, $t4 #min = second_half[i+2]
	move $s4, $t6 #Luu dia chi cua min
	j load_the_first_element_second
sorted_second_half:
	addi $s5, $zero, 100
	sb $s5, second_half($s4)
	addi $s3, $s3, 1
	sb $s2, second_half_sorted($t8)
	addi $t8, $t8, 4
	bgt $s3, $s1, done
	j sort_4
done:
print_array:
	li $t0, 0
	li $t1, 0 #Bien tro dia chi trong mang first_half_sorted
	li $t2, 0 #Bien tro dia chi trong mang second_half_sorted
	li $v0, 4
	la $a0, Message3 #Thong bao mang duoc sap xep
	syscall
print_loop:
	beq $t0, $s0, exit
	lb $t3, first_half_sorted($t1)
	lb $t4, second_half_sorted($t2)
	slt $t5, $t3, $t4 #first_half_sorted[i] < second_half_sorted[j] => t5 = 1
	beqz $t5, print_loop_second
	li $v0, 1
	la $a0, ($t3)
	syscall
	addi $t0, $t0, 1 #i=i+1
	addi $t1, $t1, 4 #Tro toi phan tu tiep theo cua mang first_half
	j print_space
print_space:
	li $v0, 4
	la $a0, space
	syscall
	j print_loop
print_loop_second:
	li $v0, 1
	la $a0, ($t4)
	syscall
	addi $t0, $t0,1 #i= i+1
	addi $t2, $t2, 4 #Tro toi phan tu tiep theo cua mang second_half
	j print_space

exit: 
	li $v0, 10
	syscall
exit_message:
	li $v0, 4
	la $a0, Errormsg
	syscall
	j exit
exit_message_2:
	li $v0, 4
	la $a0, Errormsg2
	syscall
	j exit
