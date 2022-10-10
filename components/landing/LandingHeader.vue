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
                    Build <i class="fa-solid fa-angle-down"></i>
                </p>
                <router-link to="/find-talents">
                    <p class="tab">Find Talents</p>
                </router-link>
                <a href="#tokenomics">
                    <p class="tab">Tokenomics</p>
                </a>
                <a href="#blog">
                    <p class="tab">Blog</p>
                </a>
            </div>

            <div class="build" v-if="showBuild">
                <div class="item">
                    Hire Professionals <i class="fa-solid fa-user-tie"></i>
                </div>
                <div class="item">
                    Create Project <i class="fa-solid fa-hammer"></i>
                </div>
            </div>

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

            <div class="profile" v-if="showProfile">
                <div class="item">
                    My Profile <i class="fa-solid fa-user-tie"></i>
                </div>
                <div class="item">Projects <i class="fa-solid fa-hammer"></i></div>
                <div class="item">Jobs <i class="fa-solid fa-briefcase"></i></div>
                <div class="item">Post to Feeds <i class="fa-solid fa-plus"></i></div>
                <div class="item">Notifications <i class="fa-solid fa-bell"></i></div>
                <div class="item">
                    Account settings <i class="fa-solid fa-gear"></i>
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
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
    grid-template-columns: 150px auto 200px;
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

.profile .item {
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

.profile .item:hover {
    background: #0177fb;
}

.profile .item {
    padding-top: 20px;
    padding-bottom: 20px;
}

.profile .item:first-child {
    padding-top: 40px;
    padding-bottom: 25px;
}

.profile .item:last-child {
    padding-top: 25px;
    padding-bottom: 40px;
}
</style>
