import os

def custom_logic(log_json):
    n = int(os.environ.get("N","1"))
    count = 0
    for i in range(n):
        count += 1
      #If it exit with nothing wrong we may try to restore first
     # if exit_code == 0:
      #  dec = 1
      #If Exit occur by some signal(This also include the checkpoint scenario), we will continue to standby mode
      #elif exit_code >= 128 and exit_code <= 159:
      #  dec = 2
      #Else something can be wrong, we will start it from scratch.
      #else:
      #  dec = 0

      #file = open('/decider.txt', 'w')
      #file.write(str(dec))
      #file.close()
