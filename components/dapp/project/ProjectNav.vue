<template>
<div class="nav">

    <div class="items">
        <router-link :to="`/app/projects/${$route.params.project}`">
            <div :class="$route.name == 'app-projects-project' ? 'item active' : 'item'">
                <i class="fa-solid fa-chart-pie"></i>
                <p>Overview</p>
            </div>
        </router-link>
        <router-link :to="`/app/projects/${$route.params.project}/chat`">
            <div :class="$route.name == 'app-projects-project-chat' ? 'item active' : 'item'">
                <i class="fa-solid fa-comments"></i>
                <p>Chat</p>
            </div>
        </router-link>
        <router-link :to="`/app/projects/${$route.params.project}/tasks`">
            <div :class="$route.name == 'app-projects-project-tasks' ? 'item active' : 'item'">
                <i class="fa-solid fa-list-check"></i>
                <p>Tasks</p>
            </div>
        </router-link>
        <router-link :to="`/app/projects/${$route.params.project}/members`">
            <div :class="$route.name == 'app-projects-project-members'  ? 'item active' : 'item'">
                <i class="fa-solid fa-user-group"></i>
                <p>Members</p>
            </div>
        </router-link>
        <router-link :to="`/app/projects/${$route.params.project}/goals`">
            <div :class="$route.name == 'app-projects-project-goals' ? 'item active' : 'item'">
                <i class="fa-solid fa-bullseye"></i>
                <p>Goals</p>
            </div>
        </router-link>
        <router-link :to="`/app/projects/${$route.params.project}/settings`">
            <div :class="$route.name == 'app-projects-project-settings' ? 'item active' : 'item'">
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
