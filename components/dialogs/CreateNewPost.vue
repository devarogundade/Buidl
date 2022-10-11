<template>
<div :class="`container ${state}`">
    <div class="box">
        <div class="title">
            <p>Create new post</p>
            <i v-on:click="$nuxt.$emit('discard-new-post')" class="fa-solid fa-xmark"></i>
        </div>

        <div class="agree">
            <p>Posts are immutable from the network.</p>
        </div>

        <router-link to="/app/create-post/feed">
            <div class="post" v-on:click="$nuxt.$emit('create-new-post-for', 'feeds')">
                <i class="fa-solid fa-newspaper"></i>
                <p>Feeds</p>
            </div>
        </router-link>

        <router-link to="/app/create-post/job">
            <div class="post" v-on:click="$nuxt.$emit('create-new-post-for', 'jobs')">
                <i class="fa-solid fa-briefcase"></i>
                <p>Jobs</p>
            </div>
        </router-link>

        <router-link to="/app/projects">
            <div class="post" v-on:click="$nuxt.$emit('create-new-post-for', 'projects')">
                <i class="fa-solid fa-hammer"></i>
                <p>Share a project</p>
            </div>
        </router-link>
    </div>
</div>
</template>

<script>
export default {
    props: ['state'],
    mounted() {
        $nuxt.$on('create-new-post-for', (data) => {

        })
    }
}
</script>

<style scoped>
.container {
    position: fixed;
    top: 0;
    left: 0;
    background: #0176fb28;
    backdrop-filter: blur(8px);
    height: 100%;
    width: 100%;
    z-index: 50;
    display: flex;
    align-items: center;
    justify-content: center;
    user-select: none;
}

.hide {
    top: 100vh !important;
    transform: scale(0.5, 0.5);
}

.box {
    border-radius: 30px;
    max-width: 90%;
    width: 390px;
    background: #23242F;
    border-radius: 24px;
    padding: 30px;
}

.title {
    color: #FFFFFF;
    display: flex;
    column-gap: 10px;
    font-weight: 600;
    font-size: 16px;
    align-items: center;
    justify-content: space-between;
    margin-right: -10px;
    margin-top: -10px;
}

.title i {
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

.title i:hover {
    color: #FF6370;
}

.agree {
    padding: 16px;
    width: 100%;
    background: #681c1cb9;
    border-radius: 16px;
    margin-top: 24px;
}

.agree p {
    font-size: 16px;
    line-height: 22px;
    color: #FFFFFF;
}

.agree a {
    color: #0177FB;
}

.post {
    display: flex;
    align-items: center;
    padding: 20px;
    gap: 10px;
    width: 100%;
    background: #2C2D3A;
    border-radius: 16px;
    margin-top: 24px;
    cursor: pointer;
    color: #FFFFFF;
}

.post p {
    font-size: 18px;
    font-weight: 600;
}

.post:hover {
    color: #0177FB;
}
</style>
