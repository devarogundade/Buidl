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
                return response.data.result.filter(nft => nft.token_address.toUpperCase() == "0x424c5be33c6e3185f1022a13c4a31c9641c323dd".toUpperCase())
            } catch (error) {
                return null
            }
        }
    }))
}
