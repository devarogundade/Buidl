<template>
<section>
    <div class="app-width">
        <div class="grid">
            <div class="hero">
                <div class="text">
                    <h3>Build your audience.</h3>
                    <p>
                        Engage, share thoughts, ideas, news, articles to the community.
                    </p>
                </div>
                <div class="action scaleable" v-on:click="$nuxt.$emit('create-new-post')">
                    <i class="fa-solid fa-plus"></i> Create new post
                </div>
            </div>
            <div class="hero">
                <div class="text">
                    <h3>Build your audience.</h3>
                    <p>
                        Engage, share thoughts, ideas, news, articles to the community.
                    </p>
                </div>
                <div class="action scaleable" v-on:click="$nuxt.$emit('create-new-post')">
                    <i class="fa-solid fa-plus"></i> Create new post
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    async mounted() {},
};
</script>

<style scoped>
.app-width {
    padding-top: 160px;
    padding-bottom: 100px;
    position: relative;
}

.grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    width: 100%;
    gap: 40px;
}

.hero {
    width: 100%;
    padding: 40px;
    border-radius: 10px;
    background: rgb(34, 114, 200);
    background-image: url("https://app.idle.finance/images/bg-noise.png");
    z-index: 1;
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
}

.hero:nth-child(2) {
    background: rgb(200, 34, 111);
}

.text {
    color: #fff;
}

.text h3 {
    font-size: 34px;
    font-family: "Poppins", sans-serif;
}

.text p {
    font-size: 20px;
    margin-top: 10px;
}

.action {
    display: flex;
    gap: 10px;
    align-items: center;
    font-size: 18px;
    font-weight: 600;
    background: #fff;
    border-radius: 30px;
    padding: 0 20px;
    height: 50px;
    user-select: none;
    cursor: pointer;
}
</style>
