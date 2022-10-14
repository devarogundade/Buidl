<template>
<div class="nav">
    <div class="items">
        <router-link to="/collectibles">
            <div :class="$route.name == 'collectibles' ? 'item active' : 'item'">
                <i class="fa-solid fa-wallet"></i>
                <p>Wallet</p>
            </div>
        </router-link>
        <router-link to="/collectibles/rewards">
            <div :class="$route.name == 'collectibles-rewards' ? 'item active' : 'item'">
              <i class="fa-solid fa-coins"></i>
                <p>Rewards</p>
            </div>
        </router-link>
        <router-link to="/collectibles/swap">
            <div :class="$route.name == 'collectibles-swap' ? 'item active' : 'item'">
                <i class="fa-solid fa-arrows-rotate"></i>
                <p>Trade</p>
            </div>
        </router-link>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            tab: 1,
        }
    },
    mounted() {
        $nuxt.$on('dapp-tab', (tab) => {
            this.tab = tab
        })
    }
}
</script>

<style scoped>
.nav {
    border-right: 1px rgb(201, 227, 255) solid;
    height: calc(100vh - 100px);
    margin-top: 100px;
}

.items {
    display: flex;
    flex-direction: column;
    gap: 6px;
    padding: 50px 0;
}

.item {
    width: 100%;
    padding: 0 30px;
    display: flex;
    align-items: center;
    gap: 20px;
    font-size: 18px;
    font-weight: 600;
    border-top-left-radius: 20px;
    border-bottom-left-radius: 20px;
    color: #FFFFFF;
    height: 60px;
    cursor: pointer;
    user-select: none;
}

.active {
    background: rgb(201, 227, 255);
    color: #0177fb;
}
</style>
