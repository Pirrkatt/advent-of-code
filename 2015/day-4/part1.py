import hashlib

def get_input(demo):
    file_path = 'demo-input.txt' if demo else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

def calculate_md5(input_string):
    # Create an MD5 hash object
    md5 = hashlib.md5()

    # Update the hash object with the input string encoded as bytes
    md5.update(input_string.encode())

    # Get the hexadecimal representation of the hash digest
    md5_hash = md5.hexdigest()

    return md5_hash

def get_result(input_data):
    result = 0
    while True:
        string = calculate_md5(input_data + str(result))
        for i in string[:5]:
            if i != '0':
                result += 1
                break
        else:
            return result


testing = False
input_data = get_input(testing)
answer = get_result(input_data[0])
print(f"Answer:\n{answer}")
