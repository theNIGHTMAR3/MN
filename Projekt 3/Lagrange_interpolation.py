import math
import os
import csv
import time

from matplotlib import pyplot as plt


def interpolation(path, x):
    n = len(path)
    result = 0
    for i in range(n):
        # coordinates of given point
        x_i, y_i = path[i]
        base = 1
        for j in range(n):
            # skip if diagonal
            if i == j:
                continue
            else:
                x_j, y_j = path[j]
                base *= (float(x) - float(x_j)) / float(float(x_i) - float(x_j))
        result += float(y_i) * base
    return result


def lagrange_interpolation(nodes):
    times = []
    print('Computing Lagrange interpolation\n')
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
            interpolation_data = list_points[::nodes_gap]
        else:
            nodes_gap = math.floor(size / (nodes - 1))
            interpolation_data = list_points[::nodes_gap]

        height = []
        distance = []
        interpolated_height = []

        for point in list_points:
            x, y = point
            distance.append(float(x))
            height.append(float(y))
            interpolated_height.append(interpolation(interpolation_data, float(x)))

        training_distance = []
        training_height = []
        for point in interpolation_data:
            x, y = point
            training_distance.append(float(x))
            training_height.append(float(y))

        times.append(time.time() - start_time)

        path_name = file.removesuffix('.csv')
        fig_name = 'plots/' + path_name + '_lagrange_' + str(nodes) + '.png'

        # show plots
        plt.plot(distance, height, 'k.', markersize='3', label='actual values')
        plt.plot(training_distance, training_height, 'b.', markersize='10', label='interpolation data')
        plt.plot(distance, interpolated_height, color='red', label='interpolation function')
        plt.legend()
        plt.ylabel('Height [m]')
        plt.xlabel('Distance [m]')
        plt.title('Lagrange interpolation approximation, ' + str(nodes) + ' nodes')
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

    print('Average time for Lagrange method for ' + str(nodes) + ' nodes: ' + str(average_time) + 'ms')
