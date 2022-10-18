import Vue from "vue"
import contract from 'truffle-contract'
import buidlJson from "../build/contracts/Buidl.json"

const Contracts = {
    isInit: false,
    buidlContract: null,
    user: null,

    init: async function(provider) {
        const buidlContract = contract(buidlJson)
        buidlContract.setProvider(provider)

        try {
            await buidlContract.deployed().then(instance => {
                Contracts.buidlContract = instance
            })

            this.isInit = true
        } catch (error) {
            this.isInit = false
        }
    },

    checkUser: async function(provider, accounts) {
        if (provider != null) {
            $nuxt.$emit('user-status', 'loading')

            // first check if user is already a student
            const studentAccount = await Contracts.buidlContract.students(accounts[0]);
            if (studentAccount.emailAddress != '') {
                Contracts.user = studentAccount
                Contracts.user.type = 'student'

                $nuxt.$emit('user', Contracts.user)
                $nuxt.$emit('user-status', 'available')
                return
            }

            // then check if user is an instructor
            const instructorAccount = await Contracts.buidlContract.instructors(accounts[0]);
            if (instructorAccount.firstName != '') {
                Contracts.user = instructorAccount
                Contracts.user.type = 'instructor'

                $nuxt.$emit('user', Contracts.user)
                $nuxt.$emit('user-status', 'available')
                return
            }

            $nuxt.$emit('user-status', 'not-available')
        }
    }
}

export default ({ app }, inject) => {
    inject('contracts', Vue.observable({
        buidlContract: Contracts.buidlContract,
        user: Contracts.user,

        init: async function(provider, accounts) {
            await Contracts.init(provider)
            this.buidlContract = Contracts.buidlContract
            await Contracts.checkUser(provider, accounts)
            this.user = Contracts.user
        }
    }))
}