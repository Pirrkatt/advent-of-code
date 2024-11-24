import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_result(lines):
    return sum(int(num) for num in re.findall(r'-?\d+', lines))

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    answer = get_result(input_data[0])
    print(f"What is the sum of all numbers in the document?\n{answer}")
