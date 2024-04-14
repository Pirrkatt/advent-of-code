import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

class Aunt:
    def __init__(self, number):
        self.number = number
        self.attributes = {}

    def set_attribute(self, attribute, value):
        self.attributes[attribute] = value

    def get_attribute(self, attribute):
        return self.attributes.get(attribute)

def get_result(aunts, message):
    for aunt in aunts[:]:
        for attribute, value in message.items():
            attr = aunt.get_attribute(attribute)

            if attr is not None:
                if attribute in ['cats', 'trees']:
                    if attr <= value:
                        aunts.remove(aunt)
                        break
                elif attribute in ['pomeranians' , 'goldfish']:
                    if attr >= value:
                        aunts.remove(aunt)
                        break
                elif attr != value:
                    aunts.remove(aunt)
                    break

    return aunts[0].number

def parse_input(line):
    match = re.match(r'\w+ (\d+)', line)
    aunt_number = int(match.group(1))
    aunt = Aunt(aunt_number)

    line = line.replace(match.group() + ': ', '')
    for i in re.finditer(r'(\w+): (\d+)', line):
        attribute, value = i.group(1), i.group(2)
        aunt.set_attribute(attribute, int(value))

    return aunt

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    message = {
        'children': 3,
        'cats': 7,
        'samoyeds': 2,
        'pomeranians': 3,
        'akitas': 0,
        'vizslas': 0,
        'goldfish': 5,
        'trees': 3,
        'cars': 2,
        'perfumes': 1
    }
    aunts = [parse_input(line) for line in input_data]
    answer = get_result(aunts, message)
    print(f"What is the number of the real Aunt Sue?\n{answer}")
