import math
import os
import csv
import time
from utils.matrix_functions import *
from utils.vector_functions import *

from matplotlib import pyplot as plt


def interpolation(path):
    # set_params executes once and gives data to interpolation function to speed up process
    def set_params():
        n = len(path)
        # n point
        # n-1 intervals
        # 4*(n-1) equations

        # matrix 4*(n-1) x 4*(n-1) and vector with same length
        A = matrix_zero(4 * (n - 1), 4 * (n - 1))
        b = vector_zero(4 * (n - 1))

        # 1) S(x_j)=f(x_J), n-1 equations
        for i in range(n - 1):
            x, y = path[i]
            row = vector_zero(4 * (n - 1))
            index = 4 * i + 3
            row[index] = 1
            A[index] = row
            b[index] = float(y)

        # 2) Sj(X_j+1) = f(X_j+1)
        # n-1 equations, total : 2n-2 equations
        for i in range(n - 1):
            x_1, y_1 = path[i + 1]
            x_0, y_0 = path[i]
            height = float(x_1) - float(x_0)
            index = 4 * i
            row = vector_zero(4 * (n - 1))
            row[index] = height ** 3
            row[index + 1] = height ** 2
            row[index + 2] = height ** 1
            row[index + 3] = 1
            A[index + 2] = row
            b[index + 2] = float(y_1)

        # 3) inner points, S_j-1'(x_j) = S_j'(x_j)
        # n-2 equations, total : 3n-4 equations
        for i in range(n - 2):
            x_1, y_1 = path[i + 1]
            x_0, y_0 = path[i]
            height = float(x_1) - float(x_0)
            row = vector_zero(4 * (n - 1))
            index = 4 * i
            row[index] = 3 * (height ** 2)
            row[index + 1] = 2 * height
            row[index + 2] = 1
            row[4 * (i + 1) + 2] = -1
            A[index] = row
            b[index] = float(0)

        # 4) inner points, S_j-1''(x_j) = S_j''(x_j)
        # n-2 equations, total : 4n-6 equations
        for i in range(n - 2):
            x_1, y_1 = path[i + 1]
            x_0, y_0 = path[i]
            height = float(x_1) - float(x_0)
            row = vector_zero(4 * (n - 1))
            row[4 * i] = 6 * height
            row[4 * i + 1] = 2
            row[4 * (i + 1) + 1] = -2
            A[4 * (i + 1) + 1] = row
            b[4 * (i + 1) + 1] = float(0)

        # 5) edges: S_0''(x_0) = 0 and S_n-1''(x_n-1) = 0
        # 2 equations, total : 4n-4 equations

        # first point
        row = vector_zero(4 * (n - 1))
        row[1] = 2
        A[1] = row
        b[1] = float(0)

        # last point
        row = vector_zero(4 * (n - 1))
        x_1, y_1 = path[-1]
        x_0, y_0 = path[-2]
        height = float(x_1) - float(x_0)
        row[1] = 2
        row[-4] = 6 * height
        A[-4] = row
        b[-4] = float(0)

        # final params set for interpolation
        # using LU decomposition from previous project
        params = LU_decomposition(A, b)
        return params

    params = set_params()

    def F(x):
        row = []
        params_array = []

        for param in params:
            row.append(param)
            if len(row) == 4:
                params_array.append(row.copy())
                row.clear()

        # ignore sting headline
        for i in range(1, len(path)):
            x_i, y_i = path[i - 1]
            x_j, y_j = path[i]
            if float(x_i) <= float(x) <= float(x_j):
                a, b, c, d = params_array[i - 1]
                h = float(x) - float(x_i)
                return a * (h ** 3) + b * (h ** 2) + c * h + d

        return None

    return F


def spline_interpolation(nodes):
    print('Computing Spline interpolation\n')
    times = []

    # read all csv files in data folder
    for file in os.listdir('./data'):
        current_file = open('./data/' + file, 'r')
        start_time = time.time()
        list_points = list(csv.reader(current_file))
        # cut string headline
        list_points = list_points[1:]

        # prepare data for interpolation with gaps
        # function gets only 'nodes' points
        # calculates gap between interpolation_data points
        size = len(list_points)
        if size % nodes == 0:
            nodes_gap = size / nodes
            interpolation_data = list_points[1::nodes_gap]
        else:
            nodes_gap = math.floor(size / (nodes - 1))
            interpolation_data = list_points[1::nodes_gap]

        height = []
        distance = []
        interpolated_height = []

        # function which calculates approximation
        F = interpolation(interpolation_data)

        for point in list_points[1:]:
            x, y = point
            distance.append(float(x))
            height.append(float(y))
            interpolated_height.append(F(float(x)))

        training_distance = []
        training_height = []
        for point in interpolation_data:
            x, y = point
            training_distance.append(float(x))
            training_height.append(float(y))

        times.append(time.time() - start_time)

        path_name = file.removesuffix('.csv')
        fig_name = 'plots/' + path_name + '_spline_' + str(nodes) + '.png'

        # show plots
        plt.plot(distance, height, 'k.', markersize='3', label='actual values')
        plt.plot(training_distance, training_height, 'b.', markersize='10', label='interpolation data')
        plt.plot(distance, interpolated_height, color='red', label='interpolation function')
        plt.legend()
        plt.ylabel('Height [m]')
        plt.xlabel('Distance [m]')
        plt.title('Spline interpolation approximation, ' + str(nodes) + ' nodes')
        plt.grid()
        plt.suptitle(path_name)
        plt.savefig(fig_name)
        plt.show()

    sum = 0
    for i in range(len(times)):
        sum += times[i]

    average_time = float(sum / len(times))
    # s to ms and round
    average_time *= 1000
    average_time = round(average_time, 2)

    print('Average time for spline method for ' + str(nodes) + ' nodes: ' + str(average_time) + 'ms')
