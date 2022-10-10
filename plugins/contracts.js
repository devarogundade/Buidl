// import Vue from "vue"
// import contract from 'truffle-contract'
// import threeHRJson from "../../build/ThreeHr.json"
// import companyJson from "../../build/Company.json"
// import thrTokenJson from "../../build/THRToken.json"
// import tokenJson from "../../build/Token.json"

// const Contracts = {
//     isInit: false,
//     thrHRContract: null,
//     companyContract: null,
//     thrTokenContract: null,
//     tokenContract: null,

//     init: async function() {
//         const thrHRContract = contract(threeHRJson)
//         const companyContract = contract(companyJson)
//         const thrTokenContract = contract(thrTokenJson)
//         const tokenContract = contract(tokenJson)

//         thrHRContract.setProvider(window.ethereum)
//         companyContract.setProvider(window.ethereum)
//         thrTokenContract.setProvider(window.ethereum)
//         tokenContract.setProvider(window.ethereum)

//         try {
//             await thrHRContract.deployed().then(instance => {
//                 Contracts.thrHRContract = instance
//             })

//             await companyContract.deployed().then(instance => {
//                 Contracts.companyContract = instance
//             })

//             await thrTokenContract.deployed().then(instance => {
//                 Contracts.thrTokenContract = instance
//             })

//             await tokenContract.deployed().then(instance => {
//                 Contracts.tokenContract = instance
//             })

//             this.isInit = true
//         } catch (error) {

//         }
//     }
// }

// export default ({ app }, inject) => {
//     inject('contracts', Vue.observable({
//         thrHRContract: Contracts.thrHRContract,
//         companyContract: Contracts.companyContract,
//         thrTokenContract: Contracts.thrTokenContract,
//         tokenContract: Contracts.tokenContract,

//         init: async function() {
//             await Contracts.init();
//             this.thrHRContract = Contracts.thrHRContract
//             this.companyContract = Contracts.companyContract
//             this.thrTokenContract = Contracts.thrTokenContract
//             this.tokenContract = Contracts.tokenContract
//         }
//     }))
// }