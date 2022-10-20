import Vue from "vue"

export default ({}, inject) => {
    inject('utils', Vue.observable({
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
        }
    }))
}