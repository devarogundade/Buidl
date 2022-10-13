<template>
<div class="landing">
    <LandingHeader :user="user" />
    <Nuxt />
    <LandingFooter />
    <WalletConnect :state="wcState" />
</div>
</template>

<script>
export default {
    data() {
        return {
            wcState: 'hide',
            user: {},
            address: null
        }
    },
    mounted() {
        this.$auth.checkAuth()
        $nuxt.$on('request-connect-wallet', () => {
            this.wcState = 'show'
        })
        $nuxt.$on('release-connect-wallet', () => {
            this.wcState = 'hide'
        })
        $nuxt.$on('connected', (data) => {
            this.address = data.account
            this.getUser();
        })
    },
    methods: {
        async getUser() {
            const data = await this.$ipfs.getData("users", this.address)
            this.user = data
        }
    }
}
</script>
