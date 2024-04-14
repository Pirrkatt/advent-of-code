def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_result(sequence):
    res = []
    i = 0
    while i < len(sequence):
        count = 1
        while i + 1 < len(sequence) and sequence[i] == sequence[i + 1]:
            i += 1
            count += 1
        res.append(str(count) + sequence[i])
        i += 1
    return ''.join(res)

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    answer = input_data[0]
    for _ in range(50):
        answer = get_result(answer)

    print(f"What is the length of the result?\n{len(answer)}")

# Optimized by ChatGPT, Part1 solution takes too long to run with 50 loops