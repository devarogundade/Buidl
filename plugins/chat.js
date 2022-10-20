import Vue from "vue";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore, collection, getDocs, doc, setDoc, getDoc } from "firebase/firestore";

const firebaseConfig = {
    apiKey: "AIzaSyAN_Oc0Wz5TXJFdZK__bs5sVUAm6WBzJhY",
    authDomain: "buidl-a1411.firebaseapp.com",
    projectId: "buidl-a1411",
    storageBucket: "buidl-a1411.appspot.com",
    messagingSenderId: "1070242648819",
    appId: "1:1070242648819:web:30af82bde5283232441d86",
    measurementId: "G-B5R2HHTZVQ"
};

const firebaseApp = initializeApp(firebaseConfig);
const analytics = getAnalytics(firebaseApp);

export default ({}, inject) => {
    inject('chat', Vue.observable({
        path: 'messages',
        db: getFirestore(firebaseApp),
        writeMessage: async function(document, message) {
            try {
                await setDoc(doc(this.db, this.path, document), message)
                return true
            } catch (error) {
                return false
            }
        },
        getAllMessages: async function() {
            // TODO: do some where query filtering
            const querySnapshot = await getDocs(collection(this.db, this.path))

            querySnapshot.forEach((doc) => {
                console.log(`${doc.id} => ${doc.data()}`)
            })
        },
        getMessage: async function(document) {
            const docRef = doc(this.db, this.path, document)
            const docSnap = await getDoc(docRef)

            if (docSnap.exists()) {
                return docSnap.data()
            } else {
                return null
            }
        }
    }))
}