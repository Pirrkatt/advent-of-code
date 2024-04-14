def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def parse_input(lines, stuck_lights):
    rows = len(lines)
    cols = len(lines[0])
    grid = Grid(rows, cols)
    for i, row in enumerate(lines):
        for j, col in enumerate(row):
            if (i, j) in stuck_lights or col == "#":
                grid.grid[i][j] = True
    return grid

class Grid:
    def __init__(self, rows, cols):
        self.grid = [[False] * cols for _ in range(rows)]

    def __str__(self):
        return str(self.grid)

    def get_values(self, value=True):
        return sum(row.count(value) for row in self.grid)

def check_adjacent(grid, row_index, col_index):
    neighboring_lights_on = 0

    for i in range(max(0, row_index - 1), min(len(grid.grid), row_index + 2)):
        for j in range(max(0, col_index - 1), min(len(grid.grid[0]), col_index + 2)):
            if (i, j) == (row_index, col_index):
                continue
            neighboring_lights_on += grid.grid[i][j]

    currently_on = grid.grid[row_index][col_index]
    if currently_on:
        return neighboring_lights_on in [2, 3]
    else:
        return neighboring_lights_on == 3

def get_result(grid, steps, stuck_lights):
    for _ in range(steps):
        new_grid = []
        for i in range(len(grid.grid)):
            new_row = []
            for j in range(len(grid.grid[i])):
                if (i, j) in stuck_lights:
                    new_row.append(True)
                else:
                    new_row.append(check_adjacent(grid, i, j))
            new_grid.append(new_row)

        grid.grid = new_grid

    return grid.get_values(True)

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)
    stuck_lights = {(0, 0), (0, len(input_data[0]) - 1), (len(input_data) - 1, 0), (len(input_data) - 1, len(input_data[0]) - 1)}
    grid = parse_input(input_data, stuck_lights)

    steps = 100
    answer = get_result(grid, steps, stuck_lights)
    print(f"In your grid of 100x100 lights, given your initial configuration, but with the four corners always in the on state, how many lights are on after 100 steps?\n{answer}")
