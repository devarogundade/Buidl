<template>
<div class="landing">
    <LandingHeader />
    <Nuxt />
    <LandingFooter />
    <WalletConnect :state="wcState" />
    <Error />
</div>
</template>

<script>
export default {
    data() {
        return {
            wcState: 'hide',
            address: null,
            provider: this.$auth.provider
        }
    },
    async mounted() {
        $nuxt.$on('request-connect-wallet', () => {
            this.wcState = 'show'
        })
        $nuxt.$on('release-connect-wallet', () => {
            this.wcState = 'hide'
        })

        $nuxt.$on('user-status', (status) => {
            if (status == 'loading') {
                this.loading = true
            }

            if (status == 'available') {
                this.loading = false
            }
        })

        this.$auth.checkAuth(false)
        this.$contracts.initCourseContract(this.provider)
        this.$contracts.initBuidlContract(this.provider)
    },
}
</script>
