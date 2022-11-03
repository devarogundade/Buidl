import Vue from "vue";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore, collection, getDocs, doc, setDoc, getDoc, query, where, onSnapshot } from "firebase/firestore";

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
    inject('firestore', Vue.observable({
        db: getFirestore(firebaseApp),
        fetchAll: async function(_collection) {
            const result = []
            const snapshot = await getDocs(collection(this.db, _collection))

            snapshot.forEach(document => {
                result.push(document.data())
            });

            return result
        },
        fetchAllWithCreator: async function(_collection) {
            const result = []
            const snapshot = await getDocs(collection(this.db, _collection))

            snapshot.forEach(document => {
                result.push(document.data())
            });

            for (let index = 0; index < result.length; index++) {
                result[index].creator = await this.fetch('users', result[index].address)
            }

            return result
        },
        fetchAllWhere: async function(_collection, key, sign, value) {
            const result = []

            const _query = query(collection(this.db, _collection), where(key, sign, value));
            const snapshot = await getDocs(_query)

            snapshot.forEach(document => {
                result.push(document.data())
            });

            return result
        },
        fetch: async function(_collection, _document) {
            const reference = doc(this.db, _collection, _document);
            const data = await getDoc(reference);

            if (data.exists()) {
                return data.data()
            } else {
                return null
            }
        },
        fetchAllSubscribedCourses: async function(_address) {
            const subscriptions = await this.fetchAllWhere('subscriptions', 'address', '==', _address)

            for (let index = 0; index < subscriptions.length; index++) {
                subscriptions[index].course = await this.fetch('courses', subscriptions[index].courseId)
            }

            return subscriptions
        },
        write: async function(_collection, _document, _object) {
            const reference = doc(this.db, _collection, _document)
            await setDoc(reference, _object)
        },
        callback: function(_collection, _document) {
            const reference = doc(this.db, _collection, _document)

            onSnapshot(reference, (doc) => {
                const source = doc.metadata.hasPendingWrites ? "Local" : "Server";
                console.log(source, " data: ", doc.data());
            });
        }
    }))
}
