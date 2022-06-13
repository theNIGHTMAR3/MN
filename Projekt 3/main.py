from Lagrange_interpolation import lagrange_interpolation
from matplotlib import pyplot as plt
import os
import csv


# show plots containing only complete data of height profiles
from spline_interpolation import spline_interpolation


def print_height_profiles():
    print('Creating raw data plots\n')
    for file in os.listdir('./data'):
        current_file = open('./data/' + file, 'r')
        list_points = list(csv.reader(current_file))

        height = []
        distance = []

        for point in list_points[1:]:
            x, y = point
            distance.append(float(x))
            height.append(float(y))

        path_name = file.removesuffix('.csv')
        fig_name = 'plots/Height profiles/' + path_name + '_raw.png'

        # show plots
        plt.plot(distance, height, 'k.')
        plt.ylabel('Height [m]')
        plt.xlabel('Distance [m]')
        plt.title('Height profile')
        plt.grid()
        plt.suptitle(path_name)
        plt.savefig(fig_name)
        plt.show()


if __name__ == "__main__":
    print_height_profiles()

    # set number of nodes for interpolations
    nodes = 15
    lagrange_interpolation(nodes)
    spline_interpolation(nodes)

    # uncomment for time tests
    # print('\nComputing Lagrange interpolations\n')
    # lagrange_interpolation(6)
    # lagrange_interpolation(10)
    # lagrange_interpolation(15)
    # lagrange_interpolation(50)
    # lagrange_interpolation(100)
    #
    #
    # print('\nComputing Spline interpolations\n')
    # spline_interpolation(6)
    # spline_interpolation(10)
    # spline_interpolation(15)
    # spline_interpolation(50)
    # spline_interpolation(100)



