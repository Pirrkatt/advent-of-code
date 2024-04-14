import re

def get_input(demo_input):
    file_path = 'demo-input.txt' if demo_input else 'input.txt'
    with open(file_path, 'r') as file:
        return file.read().splitlines()

class Reindeer:
    def __init__(self, fly_speed, flight_duration, rest_duration):
        self.fly_speed = fly_speed
        self.flight_duration = flight_duration
        self.rest_duration = rest_duration

    def calculate_distance(self, travel_time):
        distance = 0
        time_traveled = 0
        resting = False
        next_rest = self.flight_duration

        while time_traveled < travel_time:
            if resting:
                time_traveled += self.rest_duration
                next_rest = time_traveled + self.flight_duration
                resting = False
                continue
        
            time_traveled += 1
            distance += self.fly_speed

            if time_traveled == next_rest:
                resting = True

        return distance

def get_result(lines, travel_time):
    winning_distance = 0
    for line in lines:
        speed, time, rest = map(int, re.search(r'fly (\d+).*for (\d+).*for (\d+) seconds.', line).groups())
        reindeer = Reindeer(speed, time, rest).calculate_distance(travel_time)

        winning_distance = max(winning_distance, reindeer)

    return str(winning_distance) + " km"

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    # travel_time = 1000 # Seconds
    travel_time = 2503 # Seconds

    answer = get_result(input_data, travel_time)
    print(f"What distance has the winning reindeer traveled?\n{answer}")
