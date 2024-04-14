import re
from itertools import permutations

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def calculate_distance(locations, path):
    total_distance = 0
    for i in range(len(path) - 1):
        total_distance += locations[path[i]][path[i+1]]
    return total_distance

def find_longest_path(locations):
    longest_distance = -1
    shortest_path = None
    for path in permutations(locations.keys()):
        distance = calculate_distance(locations, path)
        if distance > longest_distance:
            longest_distance = distance
            shortest_path = path
    return longest_distance

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    locations = dict()

    for line in input_data:
        fr, to, dist = re.search(r'(\w+) to (\w+) = (\d+)', line).groups()
        dist = int(dist)
        if fr not in locations:
            locations[fr] = {}
        locations[fr][to] = dist
        if to not in locations:
            locations[to] = {}
        locations[to][fr] = dist

    answer = find_longest_path(locations)
    print(f"What is the distance of the shortest route?\n{answer}")
