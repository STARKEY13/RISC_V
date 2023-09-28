  .data     	# declare and initialize variables
arr: .float -6.0,4.0,6.0,-8.0,-3.0,-5.352671,-4.0,3.0,4.0,-4.0,-9.0,11.252345,-3.0,-1.0,-1.0,-6.0,2.0,-29.341213,-2.0,-4.0,6.0,-5.0,7.0,-53.686889,-7.0,-9.0,-10.0,5.0,9.0,12.366598
sol: .float 0.0, 0.0, 0.0, 0.0, 0.0

no_solution_msg: .asciiz "No solution exists.\n"
solu: .asciiz "x\n"
unique_solution_msg: .asciiz "Unique solution exists.\n"
Infinite_solution_msg: .asciiz "Infinite solution exists.\n"
Echelon: .asciiz "Upper Triangular Matrix : \n"
  .text
  .globl main    	# code starts here
.main:
	la x1,arr
	la x2,sol
	#input N value
	li x3,5 #m
	li x4,6 #n
	j Partial_Pivoting
  

printMatrix:
    addi a0,x0,4
  	la   a1,Echelon
  	ecall
	addi a0,x0,11	# ASCII code for newline
   	addi a1,x0,10  	# Print character system call
   	ecall
	#load i=0
   	li x5,0
	i_loop:
	#check if i<m
   	bge x5,x3,done_i

	#initialize j=0
   	li x6,0
	j_loop:
	#check if j<n
   	bge x6,x4,done_j

	# Calculate the address of matrix[i][j]
   	mul x7,x5,x4
   	add x7,x7,x6
   	slli x7,x7,2
   	add x7,x7,x1
   	flw f1,0(x7)

	# Print hexadecimal value
   	addi a0,x0,34
   	lw a1,0(x7)
   	ecall
    
	#print a tab
   	addi a0,x0,11
   	addi a1,x0,0x09
   	ecall

	# Increment j
   	addi x6,x6,1
   	j j_loop

	done_j:
	# Print a newline
   	addi a0,x0,11	# ASCII code for newline
   	addi a1,x0,10  	# Print character system call
   	ecall
    
	# Increment i
   	addi x5, x5, 1
   	j i_loop

	done_i:
  	j begin_back_subsititution
    
	end:
   	li a0,10
   	ecall

Partial_Pivoting:
   # Initialize i = 0
	li x5,0
	outer_loop:
   # Check if i >= m - 1
  	addi x6,x3,-1
  	bge x5,x6,done_outer_i

   # Partial Pivoting
   # k = i+1
  	addi x7,x5,1
	pivot_loop:
  	bge x7,x3,begin_guass
   # Load absolute values of a[i][i] and a[k][i]
   #a[i][i]
  	mul x8,x5,x4
  	add x8,x8,x5
  	slli x8,x8,2
  	add x8,x8,x1
  	flw f1,0(x8)
   
   #a[k][i]
  	mul x9,x7,x4
  	add x9,x9,x5
  	slli x9,x9,2
  	add x9,x9,x1
  	flw f2,0(x9)

  	fabs.s f2,f2   	# fabs(a[i][i])
  	fabs.s f1,f1   	# fabs(a[k][i])

	# Compare fabs(a[i][i]) < fabs(a[k][i])
  	flt.s x27, f1, f2

	# Branch to swap_rows if fabs(a[i][i]) < fabs(a[k][i])
  	bnez x27, swap_rows

	# Continue to next iteration of pivot_loop
  	j done_swap_rows
	swap_rows:
	#initialize j=0
	li x28,0
	swap_rows_loop:
  	bge x28,x4,done_swap_rows
	#a[i][j]
  	mul x29,x5,x4
  	add x29,x29,x28
  	slli x29,x29,2
  	add x29,x29,x1
  	flw f4,0(x29)

	#a[k][j]
  	mul x12,x7,x4
  	add x12,x12,x28
  	slli x12,x12,2
  	add x12,x12,x1
  	flw f5,0(x12)

	# temp = a[i][j];
	#a[i][j] = a[k][j];
	#a[k][j] = temp;
	# Swap the values using a temporary register
	#fsgnjx.s f20, f4, f5   # f2 = f0 with the sign of f1
  	fsw f4,0(x12)
 	 
  	fsw f5,0(x29)
  	flw f5,0(x12)
  	flw f4,0(x29)
	# Increment j
  	addi x28,x28, 1
  	j swap_rows_loop

	done_swap_rows:
  	addi x7,x7,1
  	j pivot_loop

	begin_guass:
	# Initialize k = i + 1
  	add x7,x0,x5
  	addi x7,x7,1
	outer_k_loop:
  	bge x7,x3,done_outer_k
	# Load a[i][i]
  	mul x13,x5,x4
  	add x13,x13,x5
  	slli x13,x13,2
  	add x13,x13,x1
  	flw f6,0(x13)
    
	# Compare a[i][i] == 0
  	feq.s x14, f6, f0  # Compare f0 with itself
  	bnez x14, done_outer_k

	# Load a[k][i]
  	mul x15,x7,x4
  	add x15,x15,x5
  	slli x15,x15,2
  	add x15,x15,x1
  	flw f7,0(x15)
	# Divide a[k][i] by a[i][i]
  	fdiv.s f8, f7, f6
	# Initialize j = 0
  	li x27,0
	inner_j_loop:
  	bge x27,x4,done_inner_j
	# Load a[k][j]
  	mul x16,x7,x4
  	add x16,x16,x27
  	slli x16,x16,2
  	add x16,x16,x1
  	flw f9,0(x16)
 	# Load a[i][j]
  	mul x17,x5,x4
  	add x17,x17,x27
  	slli x17,x17,2
  	add x17,x17,x1
  	flw f10,0(x17)

	# Multiply term with a[i][j]
  	fmul.s f11, f8, f10

	# Subtract term * a[i][j] from a[k][j]
  	fsub.s f11, f9, f11
  	fsw f11,0(x16)
  	flw f11,0(x16)


	# Increment j
  	addi x27, x27, 1
  	j inner_j_loop

	done_inner_j:
	# Increment k
  	addi x7, x7, 1
  	j outer_k_loop
	done_outer_k:
	# Continue to the next iteration of the outer loop
  	addi x5, x5, 1
  	j outer_loop
	done_outer_i:
   	 j printMatrix
begin_back_subsititution:
    addi a0,x0,11	# ASCII code for newline
   	addi a1,x0,10  	# Print character system call
   	ecall
#initialize i=m-1
  	add x5,x0,x3
  	addi x5,x5,-1
	back_sub:
  	blt x5,x0,done_backSub
	# Load a[i][n-1]
  	addi x30,x4,-1
  	mul x18,x5,x4
  	add x18,x18,x30
  	slli x18,x18,2
  	add x18,x18,x1
  	flw f12,0(x18)

	# Load x[i]
  	add x19,x5,x0
  	slli x19,x19,2
  	add x19,x19,x2
  	#flw f13,0(x19)
	#x[i] = a[i][n - 1]
	
  	fsw f12,0(x19)
	flw f13,0(x19)
	# Initialize j = i + 1
  	addi x20,x5,1
  	#addi x20,x20,1
  	addi x27,x4,-1
	back_substitution_inner_j_loop:
  	bge x20, x27, done_back_substitution_inner_j  # Check if j >= n
   #load a[i][j]
  	mul x21,x5,x4
  	add x21,x21,x20
  	slli x21,x21,2
  	add x21,x21,x1
  	flw f14,0(x21)
 
	# Load x[j]
  	add x22,x20,x0
  	slli x22,x22,2
  	add x22,x22,x2
  	flw f15,0(x22)

	
	# Multiply a[i][j] * x[j] and subtract from x[i]

  	fmul.s f16, f14, f15
  	fsub.s f13, f13, f16

  	fsw f13,0(x19)
	
	# Increment j
  	addi x20, x20, 1
  	j back_substitution_inner_j_loop

	done_back_substitution_inner_j:
  	#check a[i][i]==0
  	mul x25,x5,x4
  	add x25,x25,x5
  	slli x25,x25,2
  	add x25,x25,x1
  	flw f16,0(x25)
  	feq.s x26,f16,f0

  	#addi a0,x0,1
  	#add   a1, x0,x26
  	#ecall
  	#addi a0,x0,11
  	#addi a1,x0,0x09
  	#ecall

  	bnez  x26,check_x_i_zero

 	 
	# Load a[i][i] into f11
  	mul x24,x5,x4
  	add x24,x24,x5
  	slli x24,x24,2
  	add x24,x24,x1
  	flw f17,0(x24)

	# Divide x[i] by a[i][i]
  	fdiv.s f13, f13, f17
	# Store x[i] back to memory
  	fsw f13,0(x19)

 	 
	# Decrement i
  	addi x5, x5, -1
  	j back_sub

	check_x_i_zero:
	# Check if x[i] is zero
  	addi a0,x0,1
  	add   a1, x0,x26
  	ecall
  	addi a0,x0,11
  	addi a1,x0,0x09
  	ecall
  	add x25,x0,x5
  	slli x25,x25,2
  	add x25,x25,x2
  	flw f16,0(x25)

  	feq.s x26,f16,f0
  	addi a0,x0,1
  	add   a1, x0,x26
  	ecall
  	addi a0,x0,11
  	addi a1,x0,0x09
  	ecall

  	bnez x26,infinte_solution

	no_solution:
  	addi a0,x0,4
  	la   a1,no_solution_msg
  	ecall

  	j end

	infinte_solution:
  	addi a0,x0,4
  	la   a1,Infinite_solution_msg
  	ecall
  	j end
	done_backSub:
  	j print_sol
	print_sol:
    li x5,0
  	add x6,x0,x3
	print:
  	bge x5,x6,end

  	addi a0,x0,11
  	addi   a1,x0,88
  	ecall
    
	addi a0,x0,11	# ASCII code for [
   	addi a1,x0,91 	# Print character system call
   	ecall
    #print a tab
  	#addi a0,x0,11
    #addi a1,x0,0x09
  	#ecall
    
	addi a0,x0,1	# ASCII code 
   	add a1,x0,x5 	# Print character system call
   	ecall


	addi a0,x0,11	# ASCII code for ]
   	addi a1,x0,93 	# Print character system call
   	ecall

	addi a0,x0,11	# ASCII code for =
   	addi a1,x0,61 	# Print character system call
   	ecall

	add x19,x0,x5
  	slli x19,x19,2
  	add x19,x19,x2
  	flw f13,0(x19)

  	addi a0,x0,34
  	lw a1,0(x19)
  	ecall

    addi a0,x0,11	# ASCII code for newline
   	addi a1,x0,10  	# Print character system call
   	ecall
    
  	addi x5, x5, 1
  	j print



