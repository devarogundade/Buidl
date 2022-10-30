const express = require('express')
const app = express()
const fireStore = require('./firestore.js')
const decoder = require('./decode.js')

app.use(express.json())

app.post('/webhook', (req, res) => {
    const webhook = req.body;
    let collection = webhook.tag;

    console.log(webhook);

    for (const log of webhook.logs) {
        const format = decoder.formats(collection)

        // abi format does not exists for event data
        if (format == null) {
            return res.status(400).json();
        }

        const data = decoder.decode(format, log.data)
        const object = decoder.toObject(collection, data)

        // event data to object mapping failed
        if (object == null) {
            return res.status(400).json();
        }

        // override collection if needed
        if (collection == 'creators') {
            collection = 'users'
        }

        // write data to firebase
        fireStore.write(collection, object.id, object)
    }

    return res.status(200).json();
})

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {})
