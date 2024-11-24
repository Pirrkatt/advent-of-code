import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def parse_input(lines):
    replacements = {}
    for line in lines:
        match = re.match(r'(\w+) => (\w+)', line)
        if match:
            key, value = match.group(1), match.group(2)
            if key in replacements:
                replacements[key].add(value)
            else:
                replacements[key] = {value}
    return replacements

def get_result(calibrate, replacements):
    molecules = {
        calibrate[:match.start()] + replace + calibrate[match.end():]
        for key, values in replacements.items()
        for replace in values
        for match in re.finditer(re.escape(key), calibrate)
    }

    return len(molecules)

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    calibrate_molecule = input_data[len(input_data) - 1]
    replacements = parse_input(input_data)

    answer = get_result(calibrate_molecule, replacements)
    print(f"How many distinct molecules can be created after all the different ways you can do one replacement on the medicine molecule?\n{answer}")
