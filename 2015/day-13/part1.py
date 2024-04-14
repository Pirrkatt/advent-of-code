import re
from itertools import permutations

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def calculate_happiness(people, arrangement):
    total_happiness = 0
    n = len(arrangement)

    for i, person in enumerate(arrangement):
        next_person = arrangement[(i + 1) % n]
        total_happiness += people[person][next_person]
        total_happiness += people[next_person][person]
    return total_happiness

def calculate_arrangement(people):
    happiness = 0
    optimal = None
    for h in permutations(people.keys()):
        # print(h)
        temp = calculate_happiness(people, h)
        if temp > happiness:
            happiness = temp
            optimal = h
    return happiness

def get_result(lines):
    people = dict()

    for line in lines:
        a, b, c, d = re.search(r'(^\w+) .* (lose|gain) (\d+).* (\w+).', line).groups()
        num = b == "lose" and int(c)*-1 or int(c)
        if not a in people:
            people[a] = {}
        people[a][d] = num

    return calculate_arrangement(people)

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    answer = get_result(input_data)
    print(f"What is the total change in happiness for the optimal seating arrangement of the actual guest list?\n{answer}")
