def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

class StringCheck:
    @staticmethod
    def check_pairs(string):
        for i in range(len(string) - 1):
            current_pair = string[i] + string[i + 1]
            start_index = i + 2
            for index, char in enumerate(string[start_index:len(string) - 1]):
                check = char + string[start_index + index + 1]
                if check == current_pair:
                    return True
        return False

    @staticmethod
    def check_repeat(string):
        for i in range(len(string) - 2):
            if string[i] == string[i+2]:
                return True
        return False
    
def get_result(input_data):
    result = 0
    for string in input_data:
        if StringCheck.check_pairs(string) and StringCheck.check_repeat(string):
            result += 1
    return result

testing = False
input_data = get_input(testing)
answer = get_result(input_data)
print(f"How many strings are nice under these new rules?\n{answer}")

# Rules:
# Pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
# One letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.