<template>
<div class="nav" v-if="user">

    <div class="items">
        <router-link to="/app" v-if="user.type == 'instructor'">
            <div :class="$route.name == 'app' ? 'item active' : 'item'">
                <i class="fa-solid fa-house"></i>
                <p>Overview</p>
            </div>
        </router-link>
        <router-link to="/app" v-if="user.type == 'student'">
            <div :class="$route.name == 'app' ? 'item active' : 'item'">
                <i class="fa-solid fa-house"></i>
                <p>Overview</p>
            </div>
        </router-link>

        <router-link to="/app/profile" v-if="user.type == 'instructor'">
            <div :class="($route.name == 'app-profile' || $route.name == 'app-profile-edit') ? 'item active' : 'item'">
                <i class="fa-solid fa-user-tie"></i>
                <p>Students</p>
            </div>
        </router-link>

        <router-link to="/app/courses">
            <div :class="($route.name == 'app-courses' || $route.name == 'app-courses-create')  ? 'item active' : 'item'">
                <i class="fa-solid fa-hammer"></i>
                <p>Courses</p>
            </div>
        </router-link>

        <router-link to="/app/jobs" v-if="user.type == 'instructor'">
            <div :class="$route.name == 'app-jobs'  ? 'item active' : 'item'">
                <i class="fa-solid fa-briefcase"></i>
                <p>Revenue</p>
            </div>
        </router-link>

        <div v-if="user.type == 'instructor'" :class="($route.name == 'app-create-post-feed' || $route.name == 'app-create-post-job') ? 'item active' : 'item'" v-on:click="$nuxt.$emit('create-new-post')">
            <i class="fa-solid fa-plus"></i>
            <p>Broadcast</p>
        </div>

        <router-link to="/app/notifications">
            <div :class="$route.name == 'app-notifications' ? 'item active' : 'item'">
                <i class="fa-solid fa-bell"></i>
                <p>Notifications</p>
            </div>
        </router-link>

        <router-link to="/app/settings">
            <div :class="$route.name == 'app-settings' ? 'item active' : 'item'">
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
