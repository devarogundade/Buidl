import Vue from "vue"
import CryptoJS from "crypto-js"


export default ({ app }, inject) => {
    inject('encryption', Vue.observable({
        encryptText: function(data, key) {
            return CryptoJS.AES.encrypt(data, key).toString()
        },
        decryptText: function(data, key) {
            const bytes = CryptoJS.AES.decrypt(data, key)
            return bytes.toString(CryptoJS.enc.Utf8)
        }
    }))
}