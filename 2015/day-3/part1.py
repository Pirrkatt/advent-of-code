def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

moves = {'<': (-1, 0), '^': (0, -1), '>': (1, 0), 'v': (0, 1)}

class Grid:
    def __init__(self):
        self._visited = set()

    def set_value(self, pos):
        self._visited.add(pos)

    def get_value(self, pos):
        return pos in self._visited

def get_result(input_data):
    result = 1
    grid = Grid()
    pos = (0, 0)
    grid.set_value(pos)

    for i in input_data:
        move = moves.get(i)
        pos = (pos[0] + move[0], pos[1] + move[1])

        if not grid.get_value(pos):
            grid.set_value(pos)
            result += 1

    return result

testing = False
input_data = get_input(testing)
answer = get_result(input_data[0])
print(f"How many houses receive at least one present?\n{answer}")
