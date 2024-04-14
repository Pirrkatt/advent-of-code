def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def calculate_ribbon(input_data):
    ribbon = 0
    for i in input_data:
        arr = i.split("x")
        arr = [int(num) for num in arr]
        arr.sort()
        length = (arr[0] + arr[0] + arr[1] + arr[1]) + (arr[0] * arr[1] * arr[2])
        ribbon += length
    return ribbon

test = False
input_data = get_input(test)
total_ribbon = calculate_ribbon(get_input(test))
print(f"How many total feet of ribbon should they order?\n{total_ribbon}")

# l * w * h
# 2*l*w + 2*w*h + 2*h*l