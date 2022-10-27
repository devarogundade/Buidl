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
            loading: true,
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

        await this.$auth.checkAuth()
    },
}
</script>
