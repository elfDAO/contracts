import json

baseURI = "https://gateway.pinata.cloud/ipfs/QmeaYnpqtZQ4v3ywdBvzDyJuRQTs4TEGYg82jTeFhnGMg1/"

def generateMetadata(jsonFolderPath):
    # santa
    for idx in range(1, 6):
      data = {}
      attributes = []
      attributes.append(
        {
          "trait_type": "Type",
          "value": "Santa",
        }
      )
      data['attributes'] = attributes
      data['name'] = "elfDAO Santa"
      data['image'] = baseURI + "santa.png"
      data['description'] = "Ho ho ho! Congratulations on being one of the top 5 contributors to elfDAO!"
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # reindeer
    for idx in range(6, 506):
      data = {}
      attributes = []
      attributes.append(
        {
          "trait_type": "Type",
          "value": "Reindeer",
        }
      )
      data['attributes'] = attributes
      data['name'] = "elfDAO Reindeer"
      data['image'] = baseURI + "reindeer.png"
      data['description'] = ""
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # elf
    for idx in range(506, 1226):
      data = {}
      attributes = []
      attributes.append(
        {
          "trait_type": "Type",
          "value": "Elf",
        }
      )
      data['attributes'] = attributes
      data['name'] = "elfDAO Elf"
      data['image'] = baseURI + "elf.png"
      data['description'] = ""
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

    # TODO: generate metadata for worker elves
    for idx in range(1226, 1236):
      data = {}
      attributes = []
      attributes.append(
        {
          "trait_type": "Type",
          "value": "Worker Elf",
        }
      )
      data['attributes'] = attributes
      data['name'] = "elfDAO Worker Elf"
      data['image'] = baseURI + "elf.png"
      data['description'] = ""
      with open(jsonFolderPath+ str(idx) +'.json', 'w+', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))




filepath = "metadata/generated/"
generateMetadata(filepath)