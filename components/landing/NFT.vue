<template>
<section>
    <div class="app-width">
        <div class="nft">
            <div class="image">
                <img src="/images/instructor.png" alt="">
            </div>
            <div class="text">
                <h3>Get your courses to reach over 3000 students around the world.</h3>
                <router-link to="/collectibles">
                    <div class="action">Become an Instructor</div>
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

.nft {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
    gap: 100px;
}

.nft .image {
    width: 320px;
}

.nft .image img {
    width: 100%;
}

.nft .text {
    width: 600px;
}

.nft .text h3 {
    color: #FFFFFF;
    font-size: 36px;
    margin-bottom: 40px;
}

.nft .action {
    background: #FFFFFF;
    font-size: 20px;
    height: 50px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 250px;
    font-family: 'regular';
    font-weight: 600;
    color: black;
}
</style>
