.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
 li $t0, WHITE
 sw $t0, 36($k0)
 li $t0, WHITE
 sw $t0, 68($k0)
 li $t0, WHITE
 sw $t0, 100($k0)
 li $t0, WHITE
 sw $t0, 132($k0)
 li $t0, WHITE
 sw $t0, 164($k0)
 li $t0, WHITE
 sw $t0, 196($k0)
li $t0, WHITE
sw $t0, 40($k0)
li $t0, WHITE
sw $t0, 44($k0)
li $t0, WHITE
sw $t0, 48($k0)
li $t0, WHITE
sw $t0, 84($k0)
li $t0, WHITE
sw $t0, 116($k0)
li $t0, WHITE
sw $t0, 144($k0)
li $t0, WHITE
sw $t0, 140($k0)
li $t0, WHITE
sw $t0, 136($k0)