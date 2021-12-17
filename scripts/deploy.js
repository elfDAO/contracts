async function main() {
  // update the name here
  const ElfNFT = await ethers.getContractFactory("ElfNFT")

  // Start deployment, returning a promise that resolves to a contract object
  const elfNFT = await ElfNFT.deploy(
    "", // baseURI
    "" // collectionURI
  );
  console.log("Contract deployed to address:", elfNFT.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })