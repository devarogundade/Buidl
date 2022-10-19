const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
    networks: {
        development: {
            host: "127.0.0.1", // Ganache
            port: 7545,
            network_id: "*",
        },
        testnet: {
            provider: () => new HDWalletProvider("forget pull traffic comfort guard urban fold mutual bleak swim little foil", `https://data-seed-prebsc-1-s2.binance.org:8545`),
            network_id: 97, // Smart chain testnet id
            confirmations: 2,
            timeoutBlocks: 9999,
            skipDryRun: true,
            networkCheckTimeout: 9999999
        },
    },

    mocha: {},

    compilers: {
        solc: {
            version: "0.8.17"
        }
    },

    plugins: ["truffle-contract-size"],
};