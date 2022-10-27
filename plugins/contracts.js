import Vue from "vue"
import contract from 'truffle-contract'
import buidlJson from "../build/contracts/Buidl.json"
import courseJson from "../build/contracts/BdlCourse.json"

const Contracts = {
    isInit: false,
    buidlContract: null,
    courseContract: null,
    user: null,

    init: async function(provider) {
        const buidlContract = contract(buidlJson)
        const courseContract = contract(courseJson)

        if (!provider) {
            if (typeof ethereum === 'undefined') {
                $nuxt.$emit('request-connect-wallet')
            } else {
                buidlContract.setProvider(ethereum)
                courseContract.setProvider(ethereum)
            }
        } else {
            buidlContract.setProvider(provider)
            courseContract.setProvider(provider)
        }

        try {
            // await buidlContract.deployed().then(instance => {
            //     Contracts.buidlContract = instance
            //     $nuxt.$emit('contracts-ready', Contracts.buidlContract)
            // })

            await courseContract.deployed().then(instance => {
                Contracts.courseContract = instance
                $nuxt.$emit('course-contracts-ready', Contracts.courseContract)
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
                Contracts.user.type = 'learner'

                $nuxt.$emit('user', Contracts.user)
                $nuxt.$emit('user-status', 'available')
                return
            }

            // then check if user is an instructor
            const instructorAccount = await Contracts.buidlContract.instructors(accounts[0]);
            if (instructorAccount.firstName != '') {
                Contracts.user = instructorAccount
                Contracts.user.type = 'creator'

                $nuxt.$emit('user', Contracts.user)
                $nuxt.$emit('user-status', 'available')
                return
            }

            // user is neither a student nor instructor
            $nuxt.$emit('user-status', 'not-available')
        }
    }
}

export default ({ app }, inject) => {
    inject('contracts', Vue.observable({
        buidlContract: Contracts.buidlContract,
        courseContract: Contracts.courseContract,
        user: Contracts.user,

        init: async function(provider, accounts) {
            await Contracts.init(provider)
            this.buidlContract = Contracts.buidlContract
            this.courseContract = Contracts.courseContract
            await Contracts.checkUser(provider, accounts)
            this.user = Contracts.user
        }
    }))
}
