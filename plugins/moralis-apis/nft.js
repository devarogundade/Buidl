import Vue from "vue"

export default ({ $axios }, inject) => {
    inject('nft', Vue.observable({
        getUserNfts: async function(address) {
            const options = {
                method: 'GET',
                url: `/${address}/nft`,
                params: { chain: 'bsc testnet', format: 'decimal' },
                headers: {
                    'accept': 'application/json',
                    'X-API-Key': `${process.env.MORALIS_KEY}`
                }
            }

            try {
                const response = await $axios.request(options)
                return response.data.filter(nft => nft.token_address == process.env.NFT_CONTRACT_ADDRESS)
            } catch (error) {
                return null
            }
        }
    }))
}
