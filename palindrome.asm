.data
Message: .ascii "Nhap xau"
String: .space 100
.text
li $v0, 54
la $a0,Message
la $a1, String
la $a2, 100
syscall
