require('dotenv').config();
const { HardhatUserConfig } = require("hardhat/config");
require("@nomicfoundation/hardhat-toolbox");

const { RPC_OPAL, PRIVATE_KEY } = process.env;

const config = {
  solidity: {
    version: "0.8.17",
    settings: {
      metadata: {
        // Not including the metadata hash
        // https://github.com/paulrberg/solidity-template/issues/31
        bytecodeHash: "none",
      },
      optimizer: {
        enabled: true,
        runs: 800,
      },
      viaIR: true,
    },
  },
  networks: {
    hardhat: {},
    opal: {
      url: RPC_OPAL,
      accounts: [PRIVATE_KEY],
    },
  },
};

module.exports = config;


// require('dotenv').config();

// module.exports = {
//   solidity: "0.8.18",
//   networks: {
//     hardhat: {},
//     opal: {
//       url: process.env.RPC_OPAL,
//       accounts: [process.env.PRIVATE_KEY],
//     },
//   },
// };
