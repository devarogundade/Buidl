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
                return ['uint256', 'string', 'string', 'uint256', 'string', 'string', 'address', 'uint256', 'bool', 'bool', 'uint256']
            case 'users':
                return ['address', 'string', 'string', 'bool']
            case 'creators':
                return ['address', 'bool']
            case 'subscriptions':
                return ['uint256', 'address', 'bool']
            case 'course-sections':
                return ['uint256', 'string', 'string', 'string', 'uint256', 'uint256']
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
                    id: data[0],
                    name: data[1],
                    description: data[2],
                    category: Number(data[3]),
                    photo: data[4],
                    preview: data[5],
                    address: data[6].toUpperCase(), // creator
                    price: data[7],
                    certificate: data[8],
                    publish: data[9],
                    updatedAt: data[10]
                }
            case 'users':
                return {
                    id: data[0].toUpperCase(), // avoid case sensitive
                    name: data[1],
                    photo: data[2],
                    verified: data[3],
                }
            case 'creators':
                return {
                    id: data[0].toUpperCase(), // avoid case sensitive
                    verified: data[1],
                }
            case 'subscriptions':
                return {
                    id: `${data[1].toUpperCase()}-${data[0]}`, // unique yet constructable id
                    courseId: data[0],
                    address: data[1].toUpperCase(),
                    active: data[2]
                }
            case 'course-sections':
                return {
                    id: data[0], // todo unique yet constructable id
                    courseId: data[0],
                    title: data[1],
                    content: data[2],
                    src: data[3],
                    duration: data[4],
                    sectionId: data[5]
                }
            default:
                return null
        }
    }
}
