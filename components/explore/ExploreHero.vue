<template>
<section>
    <div class="app-width">
        <div class="hero">
            <div class="text">
                <h3>Build your audience.</h3>
                <p>Engage, share thoughts, ideas, news, articles to the community.</p>
            </div>
            <div class="action scaleable" v-on:click="$nuxt.$emit('create-new-post')">
                <i class="fa-solid fa-plus"></i> Create new post
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
.app-width {
    width: 1200px;
    padding-top: 160px;
    padding-bottom: 100px;
    position: relative;
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
