import Vue from "vue";

export default ({ $axios }, inject) => {
    inject('logs', Vue.observable({
        getCategories: async function(address) {
            const options = {
                method: 'GET',
                url: `/${address}/logs`,
                params: { chain: 'bsc testnet' },
                headers: {
                    'accept': 'application/json',
                    'X-API-Key': `${process.env.MORALIS_KEY}`
                }
            }

            try {
                const response = await $axios.request(options)
                return response.data
            } catch (error) {
                return null
            }
        },
    }))
}
