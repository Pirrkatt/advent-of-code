from string import ascii_lowercase

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

invalid_letters = {'i', 'o', 'l'}

class PasswordChecker:
    def __init__(self, string):
        self.password = string

    def increment(self):
        chars = list(self.password)
        index = len(chars) - 1

        while index >= 0:
            if chars[index] == 'z':
                chars[index] = 'a'
                index -= 1
            else:
                chars[index] = chr(ord(chars[index]) + 1)
                break
        self.password = ''.join(chars)

    def generate_password(self):
        while not self.validate():
            self.increment()
        return self.password

    def check_straight_three(self):
        for i in range(len(self.password) - 2):
            if self.password[i]+self.password[i+1]+self.password[i+2] in ascii_lowercase:
                return True
        # print('Failed First Req (Straight Three)')
        return False

    def check_invalid_letter(self):
        if bool([letter for letter in self.password if letter in invalid_letters]):
            # print('Failed Second Req (Invalid Letter)')
            return False
        return True

    def check_pairs(self):
        pair_count = 0
        i  = 0
        while i < len(self.password) - 1:
            if self.password[i] == self.password[i + 1]:
                pair_count += 1
                i += 2
                if pair_count >= 2:
                    return True
            else:
                i += 1
        # print('Failed Third Req (Pairs Check)')
        return False

    def validate(self):
        return bool(self.check_straight_three() and self.check_invalid_letter() and self.check_pairs())

def get_result(pw):
    return PasswordChecker(pw).generate_password()

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    answer = get_result(input_data[0])
    print(f"Given Santa's current password (your puzzle input), what should his next password be?\n{answer}")
