test = False
def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_floor():
    current_floor = 0
    for i in get_input(test)[0]:
        if i == '(':
            current_floor += 1
        else:
            current_floor -= 1
    return current_floor

print(f'To what floor do the instructions take Santa?\n{get_floor()}')
