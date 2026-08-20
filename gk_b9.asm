.data
	Message1:  .asciiz "Nhap so luong sinh vien: "
	Message2: .asciiz "Nhap ten sinh vien: "
	Message3: .asciiz "Nhap diem Toan cua sinh vien: "
	Message4: .asciiz "Nhung sinh vien khong qua mon Toan: "
	Newline: .asciiz "\n"
	ErrorMessage: .asciiz "So luong sinh vien khong hop le"
	ten: .space 200 #Mang de luu tru ten sinh vien (gioi han voi 10 sinh vien) (20*10)
	diem: .space 40 #Mang de luu tru diem sinh vien (gioi han voi 10 sinh vien) (4*10)

.text
main:
	li $v0, 4
	la $a0, Message1 #Thong bao nhap so luong sinh vien
	syscall
	
	li $v0, 5 #Nhap so luong sinh vien 
	syscall
	
	add $s0, $v0, $zero #Luu so luong sinh vien vao s0
	bltz $s0, exit_error #Kiem tra so luong sinh vien hop le
read_info:
	addi $t0, $t0, 0 # i = 0 (Bien dem so luong sinh vien)
	addi $t1, $t1, 0 # j = 0 (Bien dem so luong phan tu trong mang diem)
	addi $s1, $s1, 0 # j = 0 (Bien dem so luong phan tu trong mang ten)
read_loop: 
	beq $t0, $s0, result #i = n, ket thuc vong lap
	
	li $v0, 4
	la $a0, Message2 #Thong bao nhap ten sinh vien
	syscall
	
	li $v0, 8
	la $a0, ten #Nhap ten sinh vien
	add $a0, $a0, $s1
	li $a1, 20 #Moi ten chiem 20 khoang trong
	syscall
	
	li $v0, 4
	la $a0, Message3 #Thong bao nhap diem Toan cua sinh vien
	syscall
	
	li $v0, 5 #Nhap diem Toan cua sinh vien
	syscall
	
	sb $v0, diem($t1)
	
	addi $t0, $t0, 1 #i = i+1
	addi $t1, $t1, 4 #j=j+4 (tang j cua mang diem)
	addi $s1, $s1, 20 # j = j+20 (tang j cua mang ten)
	j read_loop #tiep tuc vong lap
result:
	li $v0, 4
	la $a0, Message4 #Thong bao nhung sinh vien khong qua mon Toan
	syscall
	li $v0, 4
	la $a0, Newline
	syscall
	
	li $t0, 0 #Bien dem so luong phan tu trong mang diem
	li $s1, 0 #Bien dem cua mang ten
print_loop:
	lb $t2, diem($t0)
	blt $t2, 4, print_name
	addi $t0, $t0, 4 #Tro den phan tu tiep theo cua mang diem
	addi $s1, $s1, 20 #Tro den phan tu tiep theo cua mang ten
	blt $t0, $t1, print_loop
	j exit
print_name:
	li $v0, 4
	la $a0, ten($s1)
	syscall
	addi $t0, $t0, 4
	addi $s1, $s1, 20
	blt $t0, $t1, print_loop
exit:
	li $v0, 10       # Thoat chuong trinh
        syscall
exit_error:
	li $v0, 4
	la $a0, ErrorMessage #Thong bao so luong khong hop le
	syscall
	j exit
