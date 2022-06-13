from math import sqrt


def vector_copy(vec):
    result = []

    for i in range(len(vec)):
        result.append(vec[i])
    return result


def vector_zero(x):
    result = [0] * x
    return result


def vector_one(x):
    result = [1] * x
    return result


def vector_diagonal(a):
    result = []
    for i in range(len(a)):
        result.append(a[i][i])

    return result


def vector_add(a, b):
    result = vector_copy(a)

    for i in range(len(b)):
        result[i] += b[i]
    return result


def vector_subtract(a, b):
    result = vector_copy(a)

    for i in range(len(b)):
        result[i] -= b[i]
    return result


def vector_norm(vector):
    sum = 0
    for element in vector:
        sum += pow(element, 2)
    return sqrt(sum)


def vector_scalar_product(a, b):
    sum = 0
    for i in range(len(a)):
        sum += a[i] * b[i]

    return sum
