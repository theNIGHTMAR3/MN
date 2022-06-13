
from utils.vector_functions import *


def matrix_add(A, B):
    result = matrix_copy(A)

    for i in range(len(result)):
        for j in range(len(result[0])):
            result[i][j] += B[i][j]

    return result


def matrix_subtract(A, B):
    result = matrix_copy(A)

    for i in range(len(result)):
        for j in range(len(result[0])):
            result[i][j] -= B[i][j]

    return result


def matrix_copy(M):
    result = []

    for row in M:
        next_row = []
        for element in row:
            next_row.append(element)
        result.append(next_row)
    return result


def matrix_zero(x, y):
    result = []
    for i in range(y):
        row = [0] * x
        result.append(row)
    return result


def matrix_diagonal_to_square(diagonal):
    result = matrix_zero(len(diagonal), len(diagonal))

    for i in range(len(diagonal)):
        result[i][i] = diagonal[i]

    return result


# matrix x vector
def matrix_dot_product(A, b):
    matrix_A = A
    vector_b = b

    result = vector_zero(len(matrix_A))

    for i in range(len(matrix_A)):
        for j in range(len(matrix_A[0])):
            result[i] += matrix_A[i][j] * vector_b[j]
    return result


# straight from 2nd project
def LU_decomposition(A, b):
    # initialize starting values
    matrix_A = matrix_copy(A)
    vector_b = vector_copy(b)

    size = len(A)
    # initial values of matrices
    # lower 1s on diagonal
    matrix_L = matrix_diagonal_to_square(vector_one(size))
    # upper all zero
    matrix_U = matrix_zero(size, size)

    # vectors
    vector_b = vector_copy(b)
    vector_x = vector_one(size)
    vector_y = vector_zero(size)

    # fill matrices U and L
    # LUx = b
    for j in range(size):
        for i in range(j + 1):
            matrix_U[i][j] += matrix_A[i][j]

            for k in range(i):
                matrix_U[i][j] -= matrix_L[i][k] * matrix_U[k][j]

        for i in range(j + 1, size):
            for k in range(j):
                matrix_L[i][j] -= matrix_L[i][k] * matrix_U[k][j]

            matrix_L[i][j] += matrix_A[i][j]
            matrix_L[i][j] /= matrix_U[j][j]

    # forward substitution
    # Ly=b
    for i in range(size):
        value = vector_b[i]
        for j in range(i):
            # not diagonal
            if i != j:
                value -= matrix_L[i][j] * vector_y[j]
        vector_y[i] = value / matrix_L[i][i]

    # backwards substitution
    # Ux=y
    for i in range(size - 1, -1, -1):
        value = vector_y[i]
        for j in range(i + 1, size):
            if i != j:
                value -= matrix_U[i][j] * vector_x[j]
        vector_x[i] = value / matrix_U[i][i]

    # calculate residuum
    dot = matrix_dot_product(matrix_A, vector_x)
    res = vector_subtract(dot, vector_b)

    return vector_x
