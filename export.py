import json
import os
import sys

# Make sure to set the path correctly
# Linux
filepath = "/home/$USER/.steam/steam/steamapps/workshop/content/387990/3100500975/memoryBlockData/data.json"

# Windows
#filepath = r"C:\Program Files (x86)\Steam\steamapps\workshop\content\387990\3100500975\memoryBlockData\data.json"

# ================================================================

fileread = b""

with open(sys.argv[1], "rb") as f:
    fileread = f.read()

output = {"data":[]}
counter = 0
for i in range(0, len(fileread), 2):
    output["data"].append((fileread[i]<<8)|fileread[i+1])
    counter += 1

with open(os.path.expandvars(filepath), "w") as f:
    json.dump(output, f)
print("Finished exporting!")
print(json.dumps(output))