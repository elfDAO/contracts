# contracts
## Prerequisites
1. Have access to the public and private key to your Ethereum account.
2. Have an alchemy account set-up

## Steps to Deploy
1. Make a copy of `.sample-env` and fill it out
    ```
    cp .sample-env .env
    ```
2. Make any modifications the smart contract in `./contract` and deploy script in `./script/deploy.js`
3. Compile the contract
    ```
    npx hardhat compile
    ```
4. Deploy the contract
    ```
    npx hardhat run scripts/deploy.js --network rinkeby
    ```

## Set Base URI
```
node scripts/setBaseURI.js
```

## Set Merkle Root
```
node scripts/setElfMerkleRoot.js
node scripts/setReindeerMerkleRoot.js
node scripts/setWorkerElfMerkleRoot.js
```
