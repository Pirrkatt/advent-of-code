def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_result(lines):
    original_length = 0
    new_length = 0

    for line in lines:
        original_length += len(line)

        new_string = line.replace("\\", r'\\').replace("\"", r'\"')
        new_string = '"' + new_string + '"'

        new_length += len(new_string)

    return new_length - original_length

testing = False
input_data = get_input(testing)
answer = get_result(input_data)
print(f"Answer:\n{answer}")
