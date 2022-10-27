import Vue from "vue";

export default ({ $axios }, inject) => {
    inject('stream', Vue.observable({
        fetch: async function(tag) {
            const options = {
                method: 'GET',
                url: `https://buidl-app.herokuapp.com/api/fetch`,
                params: { 'tag': tag },
            }

            try {
                const response = await $axios.request(options)
                return response.data
            } catch (error) {
                return null
            }
        },
        fetchForAddress: async function(tag, address) {
            const options = {
                method: 'GET',
                url: `https://buidl-app.herokuapp.com/api/fetch/${address}`,
                params: { 'tag': tag },
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
