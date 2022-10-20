<template>
<section>
    <div class="app-width">
        <div class="header">
            <router-link to="/app">
                <div class="logo">
                    <img src="/images/logo.png" alt="logo" />
                </div>
            </router-link>

            <div class="nav">
                <div class="tabs">
                    <router-link to="/app/courses">
                        <p class="tab"><i class="fa-solid fa-arrow-left"></i> Courses</p>
                    </router-link>
                    <p class="active tab">{{ course ? getCourseName(course) : '...'  }}</p>
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
                <router-link to="/">
                    <div class="item">
                        Leave Workspace <i class="fa-solid fa-right-from-bracket"></i>
                    </div>
                </router-link>
                <router-link to="/explore">
                    <div class="item">
                        Explore <i class="fa-solid fa-newspaper"></i>
                    </div>
                </router-link>
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
            tab: 1,
            courseId: this.$route.params.course,
            notFound: false,
            course: null
        };
    },
    mounted() {
        $nuxt.$on("connected-to-account", (address) => {
            this.address = address;
        });
        $nuxt.$on("disconnected", () => {
            this.address = null;
        });
        $nuxt.$on('explore-tab', (tab) => {
            this.tab = tab
        })
        $nuxt.$on(`course${this.courseId}`, (course) => {
            this.course = course
        })
    },
    methods: {
        toggleProfile() {
            this.showBuild = false;
            this.showProfile = !this.showProfile;
        },
        getCourseName(course) {
            if (course.name.length > 20) {
                return (course.name.substring(0, 10) +
                    "..." +
                    course.name.substring(course.name.length - 10, course.name.length))
            }

            return course.name
        }
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
    grid-template-columns: 320px auto 200px;
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
    justify-content: center;
    height: 100%;
    border-radius: 30px;
    width: fit-content;
    padding: 6px 10px;
    background: #ffffff2d;
    backdrop-filter: blur(20px);
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
    border-radius: 20px;
}

.active {
    background: #0177fb;
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
