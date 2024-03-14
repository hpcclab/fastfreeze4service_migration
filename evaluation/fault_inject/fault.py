#!/usr/bin/python3

import sys
import random
import time
def write_to_disk():
    memory_buffer = b'A' * (1024 ** 3)
    file_path = 'test_file.txt'
    with open(file_path, 'ab') as file:
        file.write(memory_buffer)

def consume_memory():
    memory_list = []
    try:
        while True:
            # Allocate 1 MB of memory in each iteration
            memory_list.append(bytearray(1024 ** 3))
            time.sleep(0.1)  # Adjust sleep time based on your requirements
    except KeyboardInterrupt:
        print("Memory consumption interrupted. Exiting.")

def simulate_bug():
    bug_probability = 0.3
    if random.random() < bug_probability:
        print("Simulating application bug. Exiting gracefully.")
        sys.exit(1)

def cleanup():
        # Clean up resources, close files, etc.
        file_path = 'test_file.txt'
        if os.path.exists(file_path):
            os.remove(file_path)

mode = int(sys.argv[1])
j = 1
if mode == 1:
#    while(True):
#        time.sleep(0.5)
    
    for i in range(53):
        write_to_disk()
        time.sleep(0.5)
        with open('/decider/ff_out', 'w') as file:
            file.write(f'{j}')
            j+=1

if mode == 2:
    consume_memory()
if mode == 3:
    while(True):
        simulate_bug()
        with open('/decider/ff_out', 'w') as file:
            file.write(f'{j}')
            j+=1
        time.sleep(1)
if mode == 4:
    i = 0
    while(True):
        time.sleep(1)
        with open('/decider/ff_out', 'w') as file:
            file.write(f'{i}')
        i+=1

