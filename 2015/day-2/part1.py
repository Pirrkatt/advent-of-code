def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def wrapping_paper(input_data):
    total_paper = 0
    for dimensions in input_data:
        try:
            length, width, height = map(int, dimensions.split("x"))
        except ValueError:
            print(f"Error: Invalid input format - {dimensions}")
            continue

        surface_area = (2 * length * width) + (2 * width * height) + (2 * height * length)
        smallest_side = min(length * width, width * height, height * length)
        total_paper += surface_area + smallest_side
    return total_paper

test = False
input_data = get_input(test)
total_wrapping_paper = wrapping_paper(input_data)
print(f"All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?\n{total_wrapping_paper}")

# l * w * h
# 2*l*w + 2*w*h + 2*h*l