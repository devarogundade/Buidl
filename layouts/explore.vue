<template>
<div class="landing">
    <ExploreHeader />
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
        }
    },
    mounted() {
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
    }
}
</script>
