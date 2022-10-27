import Vue from "vue"
import Web3 from "web3"

export default ({}, inject) => {
    inject('utils', Vue.observable({
        decode: function(format, data) {
            const web3 = new Web3(ethereum)
            return web3.eth.abi.decodeParameters(format, data)
        },
        formatToDate: function(timestamp) {
            const monthsInWord = [
                'January', 'February',
                'March', 'April',
                'May', 'June',
                'July', 'August',
                'September', 'October',
                'November', 'December'
            ]
            const date = new Date(timestamp)

            const day = parseInt(date.getUTCDate())
            const month = parseInt(date.getUTCMonth())
            const year = date.getUTCFullYear()

            return `${day} ${monthsInWord[month]} ${year}`
        },
        slidesPerView: function() {
            const screenWidth = window.innerWidth

            let perView = 4.5

            if (screenWidth < 1400) {
                perView = 4
            }

            if (screenWidth < 1200) {
                perView = 3.2
            }

            if (screenWidth < 1000) {
                perView = 2.5
            }

            if (screenWidth < 800) {
                perView = 2
            }

            if (screenWidth < 700) {
                perView = 1.6
            }

            if (screenWidth < 500) {
                perView = 1.2
            }

            if (screenWidth < 400) {
                perView = 1
            }

            return perView
        }
    }))
}
