import json

baseURI = "https://gateway.pinata.cloud/ipfs/QmcuDmd571ntKgW1qnMVrD6LwX1MoR9dYSFeH3nMnLbxco/"

def generateMetadata(jsonFolderPath):
    # santa
    for idx in range(1, 6):
      data = {}
      data['name'] = "elfDAO Santa #" + str(idx)
      data['image'] = baseURI + "santa.svg"
      data['description'] = "Ho ho ho! Thank you for being one of the top 5 contributors to elfDAO! Santas are the givers of holiday cheer. Filled with endless joy, they are always ready to envelope you in big, warm hugs. Thank you, our most generous contributors, for fueling this holiday season with bountiful love."
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # workerElf
    for idx in range(6, 30):
      data = {}
      attributes = []
      data['attributes'] = attributes
      data['name'] = "elfDAO Worker Elf #" + str(idx - 5)
      data['image'] = baseURI + "worker-elf.svg"
      data['description'] = "Thank you for your generous contributions to elfDAO. Worker elves are the backbone of the project – assembling the magic and working together to spread holiday joy."
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # reindeer
    for idx in range(31, 1000):
      data = {}
      data['name'] = "elfDAO Reindeer #" + str(idx - 30)
      data['image'] = baseURI + "reindeer.svg"
      data['description'] = "Reindeers are the bearers of holiday cheer. Springing high and far into the skies, they deliver presents to kids in every corner of the world. Be sure to give the elves a nod before launching off!"
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # elf
    for idx in range(1001, 3001):
      data = {}
      data['name'] = "elfDAO Elf #" + str(idx - 1000)
      data['image'] = baseURI + "elf.svg"
      data['description'] = "Elves are the builders of holiday cheer. Always tinkering with their toolboxes and crafting new surprises, they make every present with love. They are delighted to have you join their cohort! The more the merrier, it is with Santa’s little helpers always."
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))


filepath = "metadata/generated/"
generateMetadata(filepath)