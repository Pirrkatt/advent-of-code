import re
from itertools import combinations, permutations

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

class Ingredient():
    def __init__(self, name, capacity, durability, flavor, texture, calories):
        self.name = name
        self.capacity = int(capacity)
        self.durability = int(durability)
        self.flavor = int(flavor)
        self.texture = int(texture)
        self.calories = int(calories)

    def calculate_properties(self, mult):
        capacity = self.capacity * mult
        durability = self.durability * mult
        flavor = self.flavor * mult
        texture = self.texture * mult
        return (capacity, durability, flavor, texture)

    def get_calories(self, mult):
        return self.calories * mult

def calculate_total_score(perm, teaspoons):
    total_score = 1
    results = [0] * 4
    cals = list()

    for i, ingr in enumerate(perm):
        properties = ingr.calculate_properties(teaspoons[i])
        cals.append(ingr.get_calories(teaspoons[i]))
        for j in range(len(properties)):
            results[j] += properties[j]
    
    for result in results:
        if result < 0:
            total_score = 0
            break
        total_score *= result

    if sum(cals) != 500:
        return 0

    return total_score
        
def get_result(ingredients, teaspoons):
    total_score = 0

    for x in combinations(range(teaspoons), len(ingredients)):
        if sum(x) == teaspoons:
            for p in permutations(ingredients):
                test = calculate_total_score(p, x)
                total_score = max(test, total_score)

    return total_score

def parse_input(line):
    match = re.match(r'(\w+).*capacity (-?\d+).*durability (-?\d+).*flavor (-?\d+).*texture (-?\d+).*calories (-?\d+)', line)
    if match:
        return Ingredient(*match.groups())

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    teaspoons = 100
    ingredients = [parse_input(line) for line in input_data]
    answer = get_result(ingredients, teaspoons)
    print(f"What is the total score of the highest-scoring cookie you can make?\n{answer}")
