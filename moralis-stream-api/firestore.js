const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./buidl-a1411-4baccd805ed5.json');

initializeApp({ credential: cert(serviceAccount) });

module.exports = {
    db: getFirestore(),
    write: async function(collection, document, data) {
        try {
            const reference = this.db.collection(collection).doc(document);
            await reference.set(data)
        } catch (error) {
            console.log(error);
            return false
        }
    },
}
