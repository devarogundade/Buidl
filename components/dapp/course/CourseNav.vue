<template>
<div class="nav" v-if="user">
    <div class="items">
        <router-link :to="`/app/courses/${$route.params.course}`">
            <div :class="$route.name == 'app-courses-course' ? 'item active' : 'item'">
                <i class="fa-solid fa-chart-pie"></i>
                <p>Overview</p>
            </div>
        </router-link>

        <router-link :to="`/app/courses/${$route.params.course}/chat`">
            <div :class="$route.name == 'app-courses-course-chat' ? 'item active' : 'item'">
                <i class="fa-solid fa-comments"></i>
                <p>Chat</p>
            </div>
        </router-link>

        <router-link :to="`/app/courses/${$route.params.course}/members`">
            <div :class="$route.name == 'app-courses-course-members'  ? 'item active' : 'item'">
                <i class="fa-solid fa-user-group"></i>
                <p>Members</p>
            </div>
        </router-link>

        <router-link :to="`/app/courses/${$route.params.course}/goals`">
            <div :class="$route.name == 'app-courses-course-goals' ? 'item active' : 'item'">
                <i class="fa-solid fa-road"></i>
                <p>Roadmap</p>
            </div>
        </router-link>

        <router-link :to="`/app/courses/${$route.params.course}/settings`">
            <div :class="$route.name == 'app-courses-course-settings' ? 'item active' : 'item'">
                <i class="fa-solid fa-gear"></i>
                <p>Settings</p>
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
            user: this.$contracts.user
        }
    },
    mounted() {
        $nuxt.$on('dapp-tab', (tab) => {
            this.tab = tab
        })
        $nuxt.$on('user', (user) => {
            this.user = user
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
