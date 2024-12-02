def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return [list(map(int, line.split())) for line in file.read().splitlines()]

def check_safety(report):
    sorted_list = sorted(report)
    reverse_list = sorted(report, reverse=True)

    if (sorted_list != report and reverse_list != report):
        return False

    for i in range(len(report)-1):
        diff = abs(report[i] - report[i+1])
        if diff < 1 or diff > 3:
            return False

    return True

def safe_reports(input_data):
    result = 0
    for report in input_data:
        if check_safety(report):
            result += 1
        else:
            for i in range(len(report)):
                copy = report.copy()
                copy.pop(i)
                if check_safety(copy):
                    result += 1
                    break

    return result

input_data = get_input(False)
answer = safe_reports(input_data)
print(f"How many reports are now safe?\n{answer}")
