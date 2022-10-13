import Vue from "vue";

export default ({ app }, inject) => {
    inject('nft', Vue.observable({
        chain: 'bsc testnet',

        getUserNfts: async function(address) {
            const data = await $axios.get(`/${address}/nft?chain=${this.chain}&format=decimal`)
            console.log(data);
        },

        getBuidlNFTs: async function(contractAddress) {
            const data = await $axios.get(`/nft/${contractAddress}?chain=${this.chain}&format=decimal`)
            console.log(data);
        }
    }))
}