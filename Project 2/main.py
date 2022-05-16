import time
from Matrix import*
from matrix_functions import*
from vector_functions import*

import matplotlib.pyplot as plt

#indeks - 184631
residuum_norm=pow(10,-9) #10^(-9)

#jacobi method
def jacobi(A,b):  
    print("Started Jacobi method\n") 
    #initialize starting values
    #matrixes
    matrix_A=matrix_copy(A)
    vector_b=vector_copy(b)
    #iteration counter
    iterations=0

    #vextor x and its temp form
    #zero guess
    vector_x=vector_zero(len(matrix_A))
    temp_x=vector_copy(vector_x)

    start_time=time.time()

    #main loop
    while True:
        
        for i in range(len(matrix_A)):
            #next values from vector b, result of this eqation
            value=vector_b[i]

            for j in range(len(matrix_A)):
                #not diagonal
                if i!=j:
                    #initially x=0, denominator
                    value-=matrix_A[i][j]*vector_x[j]

            #value divided by element on diagonal
            value/=matrix_A[i][i]
            #save that value
            temp_x[i]=value

        #copy temp x to x
        vector_x=vector_copy(temp_x)

        #calculate residuum
        dot=matrix_dot_product(matrix_A,vector_x)
        res=vector_subtract(dot,vector_b)
        
        #if error is small enough
        if vector_norm(res)<residuum_norm:
            break

    


        iterations+=1


    #end of loop
    finish_time=time.time()-start_time
    print("---Jacobi---")
    print("Time needed [s]: ",finish_time)
    print("Number of iterations: ",iterations)
    print("Residuum: ",vector_norm(res))
    print("\n")
    return finish_time


def gauss_seidl(A,b): 
    print("Started Gauss-Seidl method\n") 

    #initialize starting values
    #matrixes
    matrix_A=matrix_copy(A)
    vector_b=vector_copy(b)
    #iteration counter
    iterations=0


    #vextor x 
    #zero guess
    vector_x=vector_zero(len(matrix_A[0]))

    start_time=time.time()

    #main loop
    while True:
        
        for i in range(len(matrix_A)):
            #next values from vector b, result of this eqation
            value=vector_b[i]

            for j in range(len(matrix_A)):
                #not diagonal
                if i!=j:
                    #initially x=0, denominator
                    value-=matrix_A[i][j]*vector_x[j]

            #value divided by element on diagonal
            value/=matrix_A[i][i]
            #save that value to x
            vector_x[i]=value

        #calculate residuum
        dot=matrix_dot_product(matrix_A,vector_x)
        res=vector_subtract(dot,vector_b)
        
        #if error is small enough
        if vector_norm(res)<residuum_norm:
            break


        iterations+=1


    #end of loop
    finish_time=time.time()-start_time
    print("---Gauss Seidl---")
    print("Time needed [s]: ",finish_time)
    print("Number of iterations: ",iterations)
    print("Residuum: ",vector_norm(res))
    print("\n")
    return finish_time


def LU_decomposition(A,b): 
    print("Started LU decomposition method\n") 

    #initialize starting values
    #matrixes
    matrix_A=matrix_copy(A)
    vector_b=vector_copy(b)

    size=len(A)
    #initial values of matrices
    #lower 1s on diagonal
    matrix_L=matrix_diagonal_to_square(vector_one(size))
    #upper all zero
    matrix_U=matrix_zero(size,size)

    #vectors
    vector_b=vector_copy(b)
    vector_x=vector_one(size)
    vector_y=vector_zero(size)

    start_time=time.time()

    #fill matrices U and L
    #LUx = b
    for j in range(size):
        for i in range(j+1):
            matrix_U[i][j]+=matrix_A[i][j]

            for k in range(i):
                matrix_U[i][j]-=matrix_L[i][k]*matrix_U[k][j]
        
        for i in range(j+1,size):
            for k in range(j):
                matrix_L[i][j]-=matrix_L[i][k]*matrix_U[k][j]

            matrix_L[i][j]+=matrix_A[i][j]
            matrix_L[i][j]/=matrix_U[j][j]

    #forward substitution
    #Ly=b
    for i in range(size):
        value=vector_b[i]
        for j in range(i):
            #not diagonal
            if i!=j:
                value-=matrix_L[i][j]*vector_y[j]
        vector_y[i]=value/matrix_L[i][i]

    #backwards substitution
    #Ux=y
    for  i in range(size-1,-1,-1):
        value=vector_y[i]
        for j in range(i+1,size):
            if i!=j:
                value-=matrix_U[i][j]*vector_x[j]
        vector_x[i]=value/matrix_U[i][i]

    #calculate residuum
    dot=matrix_dot_product(matrix_A,vector_x)
    res=vector_subtract(dot,vector_b)
    
    finish_time=time.time()-start_time
    print("---LU decomposition---")
    print("Time needed [s]: ",finish_time)
    print("Residuum: ",vector_norm(res))
    print("\n")
    return finish_time


#----------MAIN----------

#task A
main_matrix=Matrix(184631)

A=main_matrix.generate_matrix_task_A()   #matrix A
b=main_matrix.generate_vector_b()   #vector b


#task B
jacobi(A,b)
gauss_seidl(A,b)

#task C

C=main_matrix.generate_matrix_task_C()

#error, methods do not converge
try:
    jacobi(C,b)
except OverflowError as oe:
    print("error, method do not converge")
    print(oe)
    print("\n")
    pass

try:
    gauss_seidl(C,b)
except OverflowError as oe:
    print("error, method do not converge")
    print(oe)
    print("\n")
    pass

#task D

LU_decomposition(C,b)


#task E
N=[100,500,1000,2000,3000]

jacobi_time=[]
gauss_seidle_time=[]
lu_time=[]

for matrix_size in N:
    print("Matrix size:",matrix_size)

    temp_matrix=Matrix(184631,matrix_size)

    A_matrix=temp_matrix.generate_matrix_task_A()
    b_vector=temp_matrix.generate_vector_b()

    #calculate methods for all matrices sizes and save time results
    jacobi_time.append(jacobi(A_matrix,b_vector))
    gauss_seidle_time.append(gauss_seidl(A_matrix,b_vector))
    lu_time.append(LU_decomposition(A_matrix,b_vector))

#prepare the plot
plt.plot(N,lu_time,label="LU Decomposition",color="black")
plt.plot(N,jacobi_time,label="Jacobi",color="red")
plt.plot(N,gauss_seidle_time,label="Gauss-Seidle",color="green")
plt.legend()
plt.title('Zależność czasu wykonania od liczby niewiadomych')
plt.xlabel("liczby niewiadomych(rozmiar macierzy)")
plt.ylabel("Czas [s]")
plt.savefig('Method_comparison.png')
plt.show()





