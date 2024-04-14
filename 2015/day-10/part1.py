def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def get_amount(sequence, num, index):
    amount = 0
    while sequence[index] == num:
        amount += 1
        index +=1
        if index == len(sequence):
            break
    return amount, num

def get_result(sequence):
    res = ''
    numbers_counted = 0
    skip = 0
    for index, num in enumerate(sequence):
        if skip > index:
            continue
        count, digit = get_amount(sequence, num, index)
        skip += count
        numbers_counted += count

        res = f'{res}{count}{digit}'
        if numbers_counted >= len(sequence):
            break
    return res

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    answer = input_data[0]
    for _ in range(40):
        answer = get_result(answer)

    print(f"What is the length of the result?\n{len(answer)}")
