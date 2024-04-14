test = False
def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_floor():
    current_floor = 0
    for i, e in enumerate(get_input(test)[0]):
        if e == '(':
            current_floor += 1
        else:
            current_floor -= 1

        if current_floor < 0:
            return i + 1
    return None

print(f'What is the position of the character that causes Santa to first enter the basement?\n{get_floor()}')
