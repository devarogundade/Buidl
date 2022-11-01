<template>
<section>
    <div>
        <h3>Category</h3>
        <button v-on:click="mintCategories()">Mint Categories</button>

        {{ this.test }}
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
        }
    },
    created() {
        this.$contracts.initCourseContract(this.$auth.provider)
        $nuxt.$on('course-contract', (contract) => {
            this.courseContract = contract
        })
    },
    methods: {
        mintCategories: async function () {
            if (this.courseContract == null) return

            await this.courseContract.mintCategories({
                from: this.$auth.accounts[0]
            })
        }
    }
}
</script>
