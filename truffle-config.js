const HDWalletProvider = require('@truffle/hdwallet-provider')
const dotenv = require("dotenv")
dotenv.config()

const mnemonic = process.env.MNEMONIC;

module.exports = {
    networks: {
        development: {
            host: "127.0.0.1", // Ganache
            port: 7545,
            network_id: "*",
        },
        bsc: {
            provider: () => new HDWalletProvider(mnemonic, `https://data-seed-prebsc-1-s2.binance.org:8545`),
            network_id: 97, // Smart chain testnet id
            confirmations: 2,
            timeoutBlocks: 99999,
            skipDryRun: true,
            networkCheckTimeout: 99999999
        },
        matic: {
            provider: () => new HDWalletProvider(mnemonic, `https://matic-testnet-archive-rpc.bwarelabs.com`),
            network_id: 80001, // Polygon chain testnet id
            confirmations: 2,
            timeoutBlocks: 99999,
            skipDryRun: true,
            networkCheckTimeout: 99999999
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