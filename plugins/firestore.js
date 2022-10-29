import Vue from "vue";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore, collection, getDocs, doc, setDoc, getDoc, query } from "firebase/firestore";

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
        fetchFromPath: async function(_path) {
            const reference = doc(this.db, _path);
            const data = await getDoc(reference);

            if (data.exists()) {
                return data.data()
            } else {
                return null
            }
        },
    }))
}
