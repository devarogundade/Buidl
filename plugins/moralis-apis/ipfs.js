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

export default ({ app, $axios }, inject) => {
    inject('ipfs', Vue.observable({
        db: getFirestore(firebaseApp),
        uploadSingleData: async function(path, identifier, object, firebase = false) {
            const options = {
                method: 'POST',
                url: '/ipfs/uploadFolder',
                headers: {
                    'accept': 'application/json',
                    'content-type': 'application/json',
                    'X-API-Key': `${process.env.MORALIS_KEY}`
                },
                data: [{ path: `path/${identifier}`, content: btoa(JSON.stringify(object)) }]
            }

            const response = await $axios.request(options)

            if (response.status == 200) {
                const data = response.data[0].path

                if (firebase) {
                    const result = await this.setData(path, identifier, object)
                    return result ? data : null
                }

                return data
            } else {
                return null
            }
        },
        setData: async function(path, identifier, object) {
            try {
                await setDoc(doc(this.db, path, identifier), object);
                return true;
            } catch (error) {
                return false;
            }
        },
        getAllData: async function(path, from = 0, perPage = 20) {
            const querySnapshot = await getDocs(collection(this.db, path));
            querySnapshot.forEach((doc) => {
                console.log(`${doc.id} => ${doc.data()}`);
            });
        },
        getData: async function(path, identifier) {
            const docRef = doc(this.db, path, identifier);
            const docSnap = await getDoc(docRef);

            if (docSnap.exists()) {
                return docSnap.data()
            } else {
                return null
            }
        }
    }))
}