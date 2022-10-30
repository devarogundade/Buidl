<template>
<section>
    <div>
        <h3>Category</h3>
        <input type="text" placeholder="name" v-model="name">
        <input type="text" placeholder="name" v-model="image">
        <button v-on:click="addCategory()">Add Category</button>

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
            name: '',
            image: '',
            courseContract: null,
            test: null
        }
    },
    mounted() {
        this.$contracts.initCourseContract(this.$auth.provider)
        $nuxt.$on('course-contract', (contract) => {
            this.courseContract = contract
        })

        const web3 = new Web3()

    },
    methods: {
        addCategory: async function () {
            if (this.courseContract == null) return

            await this.courseContract.createCategory(this.name, this.image, {
                from: this.$auth.accounts[0]
            })
        }
    }
}
</script>
