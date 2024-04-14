def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

vowels = ['a', 'e', 'i', 'o', 'u']
forbidden = ['ab', 'cd', 'pq', 'xy']

class StringCheck:
    @staticmethod
    def check_vowels(string):
        v = sum(1 for char in string if char in vowels)
        return v >= 3

    @staticmethod
    def check_twice(string):
        for i in range(len(string) - 1):
            if string[i] == string[i + 1]:
                return True
        return False
    
    @staticmethod
    def check_forbidden(string):
        for pattern in forbidden:
            if pattern in string:
                return True
        return False
    
def get_result(input_data):
    result = 0
    for string in input_data:
        if StringCheck.check_vowels(string) and StringCheck.check_twice(string) and not StringCheck.check_forbidden(string):
            result += 1

    return result

testing = False
input_data = get_input(testing)
answer = get_result(input_data)
print(f"How many strings are nice?\n{answer}")

# Rules:
# Three Vowels
# One Letter Twice in a Row
# Forbidden Strings: 'ab', 'cd', 'pq', 'xy'