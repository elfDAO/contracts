/**
* @type import('hardhat/config').HardhatUserConfig
*/
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
const { RINKEBY_API_URL, ROPSTEN_API_URL, POLYGON_API_URL, MUMBAI_API_URL, MAINNET_API_URL, PRIVATE_KEY } = process.env;
module.exports = {
   solidity: "0.8.0",
   defaultNetwork: "rinkeby",
   networks: {
      hardhat: {},
      rinkeby: {
         url: RINKEBY_API_URL,
         accounts: [`0x${PRIVATE_KEY}`],
         gasPrice: 1000000000, // 1 gwei
      },
      mainnet: {
         url: MAINNET_API_URL,
         accounts: [`0x${PRIVATE_KEY}`],
         gasPrice: 51500000000, // 51.5 gwei
      },
      polygon: {
         url: POLYGON_API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      },
      mumbai: {
         url: MUMBAI_API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      },
      ropsten: {
         url: ROPSTEN_API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      }
   },
}
