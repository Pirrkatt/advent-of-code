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
        self.distance = 0
        self.points = 0

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

        self.distance = distance

    def get_distance(self):
        return self.distance

    def add_point(self):
        self.points += 1

    def get_points(self):
        return self.points

def parse_input(line):
    fly_speed, flight_duration, rest_duration = map(int, re.findall(r'\d+', line))
    return Reindeer(fly_speed, flight_duration, rest_duration)

def get_result(reindeers, travel_time):
    for t in range(1, travel_time + 1):
        for reindeer in reindeers:
            reindeer.calculate_distance(t)
        
        leading_distance = max(reindeer.get_distance() for reindeer in reindeers)
        
        for reindeer in reindeers:
            if reindeer.get_distance() == leading_distance:
                reindeer.add_point()

    return max(reindeer.get_points() for reindeer in reindeers)

if __name__ == "__main__":
    testing = False
    input_data = get_input(testing)

    reindeers = [parse_input(line) for line in input_data]
    # travel_time = 1000 # Seconds
    travel_time = 2503 # Seconds

    answer = get_result(reindeers, travel_time)
    print(f"How many points does the winning reindeer have?\n{answer}")

# One point to the Reindeer in the lead at the END of each second (multiple can be tied)
# Calculate who is the leader every second