<template>
<div class="nav">

    <div class="items">
        <div :class="tab == 1 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 1)">
            <i class="fa-solid fa-house"></i>
            <p>Overview</p>
        </div>
        <div :class="tab == 2 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 2)">
            <i class="fa-solid fa-user-tie"></i>
            <p>My Profile</p>
        </div>
        <div :class="tab == 3 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 3)">
            <i class="fa-solid fa-briefcase"></i>
            <p>Jobs</p>
        </div>
        <div :class="tab == 4 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 4)">
            <i class="fa-solid fa-hammer"></i>
            <p>Projects</p>
        </div>
        <div :class="tab == 5 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('create-new-post')">
            <i class="fa-solid fa-plus"></i>
            <p>New post</p>
        </div>
        <div :class="tab == 6 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 6)">
            <i class="fa-solid fa-bell"></i>
            <p>Notifications</p>
        </div>
        <div :class="tab == 7 ? 'item active' : 'item'" v-on:click="$nuxt.$emit('dapp-tab', 7)">
            <i class="fa-solid fa-gear"></i>
            <p>Account settings</p>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            tab: 1
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
