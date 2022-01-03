require("dotenv").config()

const API_URL = process.env.MAINNET_API_URL // change this based on the network
const PUBLIC_KEY = process.env.PUBLIC_KEY
const PRIVATE_KEY = process.env.PRIVATE_KEY

const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)

const contract = require("../artifacts/contracts/elf.sol/ElfDAO.json")
const { generateElfRoot } = require("./merkleTree")
const contractAddress = process.env.CONTRACT_ADDRESS

const nftContract = new web3.eth.Contract(contract.abi, contractAddress)

async function setElfMerkleRoot(root) {
  let nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, 'latest'); //get latest nonce
  //the transaction
  const tx = {
    'from': PUBLIC_KEY,
    'to': contractAddress,
    'nonce': nonce,
    'gasPrice': 55000000000, // 55 gwei
    'gas': 100000, // set the gas limit
    'data': nftContract.methods.setElfMerkleRoot(root).encodeABI()
  };

  const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY)
  signPromise
    .then((signedTx) => {
      web3.eth.sendSignedTransaction(
        signedTx.rawTransaction,
        function (err, hash) {
          if (!err) {
            console.log(
              "The hash of your transaction is: ",
              hash,
              "\nCheck Alchemy's Mempool to view the status of your transaction!"
            )
          } else {
            console.log(
              "Something went wrong when submitting your transaction:",
              err
            )
          }
        }
      )
      console.log(`setElfMerkleRoot is complete! Set root to ${root.toString('hex')}`);
    })
    .catch((err) => {
      console.log(" Promise failed:", err)
    })
}

const elfRoot = generateElfRoot();
setElfMerkleRoot(elfRoot)
