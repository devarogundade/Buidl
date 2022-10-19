import Vue from "vue"
import CryptoJS from "crypto-js"
import Base64 from 'crypto-js/enc-base64';


export default ({ app }, inject) => {
    inject('encryption', Vue.observable({
        encrypt: function(data, key) {
            const wordArray = CryptoJS.enc.Utf8.parse(data)
            return CryptoJS.enc.Base64.stringify(wordArray)
        },
        decrypt: function(base64, key) {
            const parsedWordArray = CryptoJS.enc.Base64.parse(base64)
            return parsedWordArray.toString(CryptoJS.enc.Utf8)
        },
    }))
}