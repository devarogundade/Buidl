import Vue from "vue";

export default ({ $axios }, inject) => {
    inject('certificate', Vue.observable({
        getUserCertificates: async function(address) {

        }
    }))
}