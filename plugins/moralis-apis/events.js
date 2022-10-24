import Vue from "vue";

export default ({ $axios }, inject) => {
    inject('events', Vue.observable({
        fetch: async function(address, topic) {
            try {
                const options = {
                    method: 'POST',
                    url: `/${address}/events`,
                    params: { chain: 'bsc testnet', topic: topic },
                    headers: {
                        accept: 'application/json',
                        'content-type': 'application/json',
                        'X-API-Key': `${ process.env.MORALIS_KEY }`
                    }
                }

                const response = await $axios.request(options)
                return response.data[0].path
            } catch (error) {
                return null
            }
        }
    }))
}
