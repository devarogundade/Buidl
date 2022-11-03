<template>
<section>
    <div>
        <h3>Category</h3>
        <button v-on:click="mintCategories()">Mint Categories</button>
        <button v-on:click="testAxelar()">Test Axelar</button>
    </div>
</section>
</template>

<style scoped>
section {
    padding: 200px 50px;
    min-height: 100vh;
    color: white;
}

div {
    margin-bottom: 50px;
}
</style>

<script>
import Web3 from 'web3'
export default {
    layout: 'landing',
    data() {
        return {
            courseContract: null,
            executableContract: null
        }
    },
    created() {
        this.$contracts.initCourseContract(this.$auth.provider)
        this.$contracts.initExecutableContract(this.$auth.provider)

        $nuxt.$on('course-contract', (contract) => {
            this.courseContract = contract
        })
        $nuxt.$on('executable-contract', (contract) => {
            console.log(contract);
            this.executableContract = contract
        })
    },
    methods: {
        mintCategories: async function () {
            if (this.courseContract == null) return

            await this.courseContract.mintCategories({
                from: this.$auth.accounts[0]
            })
        },
        testAxelar: async function () {
            console.log(this.executableContract);
            if (this.executableContract == null) return

            const trx = await this.executableContract.subscribe("binance", "0x3407714B59fD7f5A3535bD51177e1f709cA08ba5", 93593177001, {
                from: this.$auth.accounts[0]
            })

            console.log(trx);
        }
    }
}
</script>
