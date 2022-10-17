<template>
<div class="explore">
    <div class="bg"><img src="https://app.idle.finance/images/ellipse-topleft.svg" alt=""></div>
    <div class="bg2"><img src="https://app.idle.finance/images/ellipse-bottomright.svg" alt=""></div>
    <ExploreHeader />
    <ExploreHero />
    <Nuxt />
    <LandingFooter />
    <WalletConnect :state="wcState" />
    <CreateNewPost :state="cpState" />
</div>
</template>

<script>
export default {
    data() {
        return {
            wcState: 'hide',
            cpState: 'hide',
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
        $nuxt.$on('create-new-post', () => {
            this.cpState = 'show'
        })
        $nuxt.$on('discard-new-post', () => {
            this.cpState = 'hide'
        })
        $nuxt.$on('create-new-post-for', (data) => {
            this.cpState = 'hide'
        })

        $nuxt.$on('connected', (data) => {
            this.$contracts.init(this.$auth.provider, this.$auth.accounts)
        })

        $nuxt.$on('user-status', (status) => {
            if (status == 'loading') {
                this.loading = true
            }

            if (status == 'available') {
                this.loading = false
            }

            if (status == 'not-available') {
                this.$router.push('/register')
            }
        })

        await this.$auth.checkAuth()
        this.$contracts.init(this.$auth.provider, this.$auth.accounts)
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
