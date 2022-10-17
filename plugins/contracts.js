import Vue from "vue"
import contract from 'truffle-contract'
import BuidlContract from "/contracts/Buidl.json"

const Contracts = {
    isInit: false,
    buidlContract: null,

    init: async function(provider) {
        console.log('json', buidlContract);

        const buidlContract = contract(BuidlContract)

        buidlContract.setProvider(provider)

        try {
            await buidlContract.deployed().then(instance => {
                Contracts.buidlContract = instance
            })

            this.isInit = true
        } catch (error) {
            this.isInit = false
            console.log(error);
        }
    }
}

export default ({ app }, inject) => {
    inject('contracts', Vue.observable({
        buidlContract: Contracts.buidlContract,

        init: async function(provider) {
            await Contracts.init(provider)
            this.buidlContract = Contracts.buidlContract
        }
    }))
}