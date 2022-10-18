import Vue from "vue"

export default ({ app }, inject) => {
    inject('utils', Vue.observable({
        formatToDate: function(timestamp) {
            var wMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

            var date = new Date()
            var day = parseInt(date.getUTCDate());
            var month = parseInt(date.getUTCMonth());
            var year = date.getUTCFullYear()

            return day + ' ' + wMonths[month] + ', ' + year
        }
    }))
}