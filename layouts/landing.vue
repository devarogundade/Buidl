<template>
<div class="landing">
    <LandingHeader />
    <Nuxt />
    <LandingFooter />
    <WalletConnect :state="wcState" />
</div>
</template>

<script>
export default {
    data() {
        return {
            wcState: 'hide'
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
    }
}
</script>
