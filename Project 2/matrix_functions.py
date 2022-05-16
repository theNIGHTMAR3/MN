from vector_functions import vector_zero


def matrix_add(A,B):
    result=matrix_copy(A)

    for i in range(len(result)):
        for j in range(len(result[0])):
            result[i][j]+=B[i][j]

    return result

def matrix_subtract(A,B):
    result=matrix_copy(A)

    for i in range(len(result)):
        for j in range(len(result[0])):
            result[i][j]-=B[i][j]

    return result

def matrix_copy(M):
    result=[]

    for row in M:
        next_row=[]
        for element in row:
            next_row.append(element)
        result.append(next_row)
    return result

def matrix_zero(x,y):
    result=[]
    for i in range(y):
        row=[0]*x
        result.append(row)
    return result

def matrix_diagonal_to_square(diagonal):
    result=matrix_zero(len(diagonal),len(diagonal))

    for i in range(len(diagonal)):
        result[i][i]=diagonal[i]

    return result

#matrix x vector
def matrix_dot_product(A,b):
    matrix_A=A
    vector_b=b

    result=vector_zero(len(matrix_A))

    for i in range(len(matrix_A)):
        for j in range(len(matrix_A[0])):
            result[i]+=matrix_A[i][j]*vector_b[j]
    return result
    
