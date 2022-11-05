const HDWalletProvider = require('@truffle/hdwallet-provider')
const dotenv = require("dotenv")
dotenv.config()

const mnemonic = process.env.MNEMONIC;
const rpc_id = process.env.MATIC_RPC_ID;

module.exports = {
    networks: {
        development: {
            host: "127.0.0.1", // Ganache
            port: 7545,
            network_id: "*",
        },
        bsc: {
            provider: () => new HDWalletProvider(mnemonic, `https://bsc-testnet.public.blastapi.io`),
            network_id: 97, // Smart chain testnet id
            confirmations: 2,
            timeoutBlocks: 9999999,
            skipDryRun: true,
            networkCheckTimeout: 999999999,
            // from: '0xe2F06e559cDcB2E73cA6F8299E35ccE8B1FbD813'
        },
        mumbai: {
            provider: () => new HDWalletProvider(mnemonic, `https://rpc-mumbai.maticvigil.com/v1/${rpc_id}`),
            network_id: 80001, // Polygon chain testnet id
            confirmations: 2,
            timeoutBlocks: 9999999,
            skipDryRun: true,
            networkCheckTimeout: 999999999
        },
    },

    mocha: {},

    compilers: {
        solc: {
            version: "0.8.16",
            settings: {
                optimizer: {
                    enabled: true,
                    runs: 1500
                }
            }
        }
    },

    plugins: ["truffle-contract-size"],
};