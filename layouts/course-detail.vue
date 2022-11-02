<template>
<div class="explore">
    <div class="bg"><img src="https://app.idle.finance/images/ellipse-topleft.svg" alt=""></div>
    <div class="bg2"><img src="https://app.idle.finance/images/ellipse-bottomright.svg" alt=""></div>
    <ExploreHeader />
    <Nuxt />
    <LandingFooter />
    <WalletConnect :state="wcState" />
    <CreateNewPost :state="cpState" />
    <Error />
</div>
</template>

<script>
export default {
    data() {
        return {
            wcState: 'hide',
            cpState: 'hide',
            provider: this.$auth.provider
        }
    },
    async created() {
        $nuxt.$on('request-connect-wallet', () => {
            this.wcState = 'show'
        })
        $nuxt.$on('release-connect-wallet', () => {
            this.wcState = 'hide'
        })
        $nuxt.$on('create-new-post', () => {
            this.cpState = 'show'
        })
        $nuxt.$on('discard-new-post', () => {
            this.cpState = 'hide'
        })
        $nuxt.$on('create-new-post-for', (data) => {
            this.cpState = 'hide'
        })

        this.$auth.checkAuth()
        this.$contracts.initCourseContract(this.provider)
        this.$contracts.initBuidlContract(this.provider)
    }
}
</script>

<style>
.bg {
    position: fixed;
    left: -150px;
    top: -150px;
    width: 600px;
    opacity: 0.2;
    z-index: -1;
}

.bg img {
    width: 100%;
}

.bg2 {
    position: fixed;
    right: -100px;
    bottom: 0;
    width: 600px;
    opacity: 0.5;
    rotate: 90deg;
    z-index: -1;
}

.bg2 img {
    width: 100%;
}
</style>
