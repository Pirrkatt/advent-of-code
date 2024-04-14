import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_result(lines):
    total_length = 0
    mem_length = 0

    for line in lines:
        total_length += len(line)

        line = line[1:-1]
        line = line.replace('\\"', "!").replace('\\\\', '!')
        # We don't really need to convert the hex to it's corresponding character since it can only become 1 character in length anyway
        line = re.sub(r'\\x\w\w', "!", line)
        
        mem_length += len(line)

    return total_length - mem_length

testing = False
input_data = get_input(testing)
answer = get_result(input_data)
print(f"Disregarding the whitespace in the file, what is the number of characters of code for string literals minus the number of characters in memory for the values of the strings in total for the entire file?\n{answer}")
