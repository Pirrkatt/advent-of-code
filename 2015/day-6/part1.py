import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

class LightGrid:
    def __init__(self, rows, cols):
        self.lit = 0
        self.rows = rows
        self.cols = cols
        self.grid = [[False] * cols for _ in range(rows)]

    def turn_on(self, row, col):
        if self.grid[row][col]:
            return None

        self.grid[row][col] = True
        self.lit += 1

    def turn_off(self, row, col):
        if not self.grid[row][col]:
            return None

        self.grid[row][col] = False
        self.lit -= 1

    def toggle(self, row, col):
        self.grid[row][col] = not self.grid[row][col]
        self.lit += 1 if self.grid[row][col] else -1


def get_result(input_data):
    lights = LightGrid(1000, 1000)

    for line in input_data:
        number_list = re.findall(r'\d+', line)
        number_list = [int(num) for num in number_list]

        if line.startswith('turn on'):
            do_action = lights.turn_on
        elif line.startswith('turn off'):
            do_action = lights.turn_off
        elif line.startswith('toggle'):
            do_action = lights.toggle

        for row in range(number_list[0], number_list[2]+1):
            for col in range(number_list[1], number_list[3]+1):
                do_action(row, col)

    return lights.lit

testing = False
input_data = get_input(testing)
answer = get_result(input_data)
print(f"After following the instructions, how many lights are lit?\n{answer}")
