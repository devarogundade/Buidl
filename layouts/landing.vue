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
import Certificate from '/plugins/certificate.js'
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
        $nuxt.$on('connected', (data) => {
            this.address = data.account
            this.$contracts.init(this.$auth.provider, this.$auth.accounts)
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
        this.$contracts.init(this.$auth.provider, this.$auth.accounts)
    },
}
</script>
