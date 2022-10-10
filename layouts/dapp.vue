<template>
<div class="landing">
    <DappHeader />
    <section>
        <div class="app-width">
            <div class="grid">
                <DappNav />
                <Nuxt />
            </div>
        </div>
    </section>
    <DappFooter />
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

<style scoped>
.grid {
    display: grid;
    grid-template-columns: 300px auto;
}
</style>
