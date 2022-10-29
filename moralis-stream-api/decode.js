const Web3 = require('web3')

module.exports = {
    // converts EVM data to typeof array
    decode: function(format, value) {
        const web3 = new Web3()
        const data = web3.eth.abi.decodeParameters(format, value)
        return data
    },
    formats: function(collection) {
        // returns EVM event data formats
        switch (collection) {
            case 'categories':
                return ['uint', 'string', 'string']
            case 'courses':
                return ['uint', 'string', 'string', 'uint', 'string', 'string', 'address']
            case 'users':
                return ['string', 'string', 'address']
            default:
                return null
        }
    },
    toObject: function(collection, data) {
        // each object must have a property of id
        switch (collection) {
            case 'categories':
                return {
                    id: data[0],
                    name: data[1],
                    image: data[2]
                }
            case 'courses':
                return {
                    id: Number(data[0]),
                    name: data[1],
                    description: data[2],
                    category: Number(data[3]),
                    photo: data[4],
                    preview: data[5],
                    address: data[6]
                }
            case 'users':
                return {
                    id: data[2],
                    name: data[0],
                    photo: data[1],
                    address: data[2],
                }
            default:
                return null
        }
    }
}