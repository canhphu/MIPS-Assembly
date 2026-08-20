.data
array:  .word 9, 5, 2, 7, 1, 8, 3, 6, 4    # Array to be sorted
length: .word 9                           # Length of the array

.text
.globl main

main:
    # Load the address of the array and its length
    la $t0, array
    lw $t1, length

    # Outer loop (i loop)
    li $t2, 1                    # Initialize i = 1
    j check_loop_condition

outer_loop:
    # Inner loop (j loop)
    move $t3, $t2                # Initialize j = i
    j check_inner_loop_condition

inner_loop:
    # Compare array[j] with array[j-1]
    lw $t4, 0($t0)               # array[j]
    lw $t5, -4($t0)              # array[j-1]

    ble $t4, $t5, end_inner_loop

    # Swap array[j] and array[j-1]
    sw $t4, -4($t0)              # array[j-1]
    sw $t5, 0($t0)               # array[j]

    subi $t3, $t3, 1             # Decrement j by 1

end_inner_loop:
    addi $t0, $t0, 4             # Increment the array pointer

check_inner_loop_condition:
    bgtz $t3, inner_loop         # Go to the inner loop if j > 0

    addi $t2, $t2, 1             # Increment i by 1

check_loop_condition:
    sub $t6, $t2, $t1            # Compare i >= length
    bgez $t6, end_outer_loop     # Exit the outer loop if i >= length

    j outer_loop

end_outer_loop:
    # Print the sorted array
    li $v0, 1                    # System call to print an integer
    la $a0, array
    li $a1, 36                   # Number of bytes to print (9 elements * 4 bytes each)
    syscall

    # Exit the program
    li $v0, 10                   # System call to exit
    syscall