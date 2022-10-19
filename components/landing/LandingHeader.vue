<template>
<section>
    <div class="app-width">
        <div class="header">
            <router-link to="/">
                <div class="logo">
                    <img src="/images/logo.png" alt="logo" />
                </div>
            </router-link>
            <div class="tabs">
                <router-link to="/explore">
                    <p class="tab">Explore</p>
                </router-link>
                <p class="tab" v-on:click="showBuild = !showBuild">
                    Teach <i class="fa-solid fa-angle-down"></i>
                </p>
                <router-link to="/explore/instructors">
                    <p class="tab">Instructors</p>
                </router-link>
                <a href="#bdl-token">
                    <p class="tab">BDL Token</p>
                </a>
                <a href="#faqs">
                    <p class="tab">FAQs</p>
                </a>
            </div>

            <div class="build" v-if="showBuild">
                <div class="item">
                    Become an Instructor <i class="fa-solid fa-user-tie"></i>
                </div>
                <div class="item">
                    Instructor's Guide <i class="fa-solid fa-hammer"></i>
                </div>
            </div>

            <div class="action">
                <router-link :to="'/app'">
                    <div class="app enter" v-if="address != null">
                        Enter App
                    </div>
                </router-link>

                <div class="app" v-if="address == null" v-on:click="$auth.requestWalletConnection()">
                    Connect Wallet
                </div>
                <div class="app" v-else v-on:click="toggleProfile()">
                    <i class="fa-solid fa-wallet"></i>
                    {{
            address.substring(0, 4) +
            "..." +
            address.substring(address.length - 4, address.length)
          }}
                </div>
            </div>

            <div class="profile" v-if="showProfile">
                <router-link to="/app/profile">
                    <div class="item">My Profile <i class="fa-solid fa-user-tie"></i></div>
                </router-link>
                <router-link to="/app/jobs">
                    <div class="item">Jobs <i class="fa-solid fa-briefcase"></i></div>
                </router-link>
                <router-link to="/app/projects">
                    <div class="item">Projects <i class="fa-solid fa-hammer"></i></div>
                </router-link>
                <a v-on:click="$nuxt.$emit('create-new-post')">
                    <div class="item">Create new post <i class="fa-solid fa-plus"></i></div>
                </a>
                <router-link to="/app/notifications">
                    <div class="item">Notifications <i class="fa-solid fa-bell"></i></div>
                </router-link>
                <router-link to="/app/settings">
                    <div class="item">
                        Account settings <i class="fa-solid fa-gear"></i>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    props: ['user'],
    data() {
        return {
            showBuild: false,
            showProfile: false,
            address: null,
        };
    },
    mounted() {
        $nuxt.$on("connected-to-account", (address) => {
            this.address = address;
        });
        $nuxt.$on("disconnected", () => {
            this.address = null;
        });
    },
    methods: {
        toggleProfile() {
            this.showBuild = false;
            this.showProfile = !this.showProfile;
        },
    },
};
</script>

<style scoped>
section {
    height: 100px;
    width: 100%;
    z-index: 10;
    position: fixed;
    left: 0;
    top: 0;
    align-items: center;
    backdrop-filter: blur(20px);
}

.app-width {
    height: 55px;
}

.header {
    width: 100%;
    display: grid;
    grid-template-columns: 150px auto 400px;
    column-gap: 40px;
    height: 100%;
    align-items: center;
}

.logo {
    height: 35px;
}

.logo img {
    height: 100%;
}

.action {
    display: grid;
    grid-template-columns: auto 200px;
    column-gap: 20px;
    height: 100%;
}

.app {
    background: #0177fb;
    color: #ffffff;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    cursor: pointer;
    user-select: none;
    font-size: 20px;
    column-gap: 10px;
    font-weight: 600;
}

.enter {
    background: transparent;
    border: #ffffff 2px solid;
    backdrop-filter: blur(20px);
}

.app:hover {
    background: #ffffff;
    color: #2c2d3a;
}

.tabs {
    display: flex;
    align-items: center;
    height: 100%;
}

.tab {
    color: #ffffff;
    font-size: 20px;
    font-weight: 600;
    padding: 10px 20px;
    display: flex;
    align-items: center;
    column-gap: 10px;
    cursor: pointer;
    user-select: none;
}

.build {
    position: absolute;
    background: #2c2d3a;
    width: 300px;
    border-radius: 30px;
    top: 80px;
    left: 380px;
    overflow: hidden;
    z-index: 10;
    box-shadow: 6px 6px 0 #0176fb2a;
}

.build .item {
    padding: 0 30px;
    background: #2c2d3a;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    user-select: none;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #ffffff;
}

.build .item:hover {
    background: #0177fb;
}

.build .item:first-child {
    padding-top: 40px;
    padding-bottom: 25px;
}

.build .item:last-child {
    padding-top: 25px;
    padding-bottom: 40px;
}

.profile {
    position: absolute;
    background: #2c2d3a;
    width: 300px;
    border-radius: 30px;
    top: 90px;
    right: 4%;
    overflow: hidden;
    z-index: 10;
    box-shadow: 6px 6px 0 #0176fb2a;
}

.profile a .item {
    padding: 0 30px;
    background: #2c2d3a;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    user-select: none;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #ffffff;
}

.profile a .item:hover {
    background: #0177fb;
}

.profile a .item {
    padding-top: 20px;
    padding-bottom: 20px;
}

.profile a:first-child .item {
    padding-top: 40px;
    padding-bottom: 25px;
}

.profile a:last-child .item {
    padding-top: 25px;
    padding-bottom: 40px;
}
</style>
