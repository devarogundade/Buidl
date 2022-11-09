import {
    AxelarGMPRecoveryAPI,
    Environment,
} from "@axelar-network/axelarjs-sdk";

const sdk = new AxelarGMPRecoveryAPI({
    environment: Environment.TESTNET,
});

export default ({}, inject) => {
    inject('axelar', Vue.observable({
        track: async function(txHash) {
            const txStatus = await sdk.queryTransactionStatus(txHash);
            return txStatus
        }
    }))
}
