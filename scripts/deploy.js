async function main() {
  // update the name here
  const ElfNFT = await ethers.getContractFactory("ElfNFT")

  // Start deployment, returning a promise that resolves to a contract object
  const elfNFT = await ElfNFT.deploy(
    "https://gateway.pinata.cloud/ipfs/QmSA59xQeyaa5i1gUqhSiyMiBgamZqwb5BW6UbLypqmjrB/", // baseURI include the /
    "https://gateway.pinata.cloud/ipfs/QmT3T5zbTZy1n7ERPgScZk8NiG1F9Zyva7dUtHGvSdFEiK" // collectionURI
  );
  console.log("Contract deployed to address:", elfNFT.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })