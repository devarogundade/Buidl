<template>
<section id="creator">
    <div class="app-width">
        <div class="become">
            <div class="image">
                <img src="/images/instructor.png" alt="">
            </div>
            <div class="text">
                <h3>Get your courses to reach over 3000 learners around the world.</h3>
                <router-link to="/register">
                    <div class="action">Become a Creator</div>
                </router-link>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
section {
    margin-top: 160px;
    padding: 60px 0;
    background: #00306e;
}

.become {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
    gap: 100px;
}

.become .image {
    width: 320px;
}

.become .image img {
    width: 100%;
}

.become .text {
    width: 600px;
}

.become .text h3 {
    color: #FFFFFF;
    font-size: 36px;
    margin-bottom: 40px;
}

.become .action {
    background: #FFFFFF;
    font-size: 20px;
    height: 50px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 270px;
    font-family: 'regular';
    font-weight: 600;
    color: black;
}
</style>
