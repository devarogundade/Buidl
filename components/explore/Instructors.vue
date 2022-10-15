<template>
<section>
    <div class="app-width">
        <div class="talents">
            <div class="talent" v-for="index in 24" :key="index">
                <div class="image">
                    <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                </div>
                <div class="detail">
                    <h3 class="name">Arogundade Ibrahim <i class="fa-solid fa-shield"></i></h3>
                    <p class="title">Android Developer</p>
                </div>
                <div class="profile">
                    <div class="message">Follow</div>
                    <div class="message"><i class="fa-regular fa-comments"></i></div>
                </div>
                <div class="trust">
                    <div>
                        <p>Trusted with</p>
                        <p>1,392 $BDL</p>
                    </div>
                    <div>
                        <p><i class="fa-solid fa-user-shield"></i></p>
                        <p>15</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
.talents {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
}

.talent {
    width: 270px;
    border-radius: 30px;
    background: #ffffff25;
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow: hidden;
    backdrop-filter: blur(20px);
}

.talent .image {
    width: 160px;
    height: 140px;
    border-radius: 40px;
    overflow: hidden;
    box-shadow: 6px 6px 0 #0176fb2a;
    margin: 20px;
}

.image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.detail {
    margin-top: 10px;
    text-align: center;
    color: #fff;
}

.detail h3 {
    font-size: 20px;
    font-weight: 600;
}

.detail .title {
    margin-top: 6px;
    font-size: 14px;
    opacity: 0.8;
}

.profile {
    width: 100%;
    display: flex;
    justify-content: center;
    padding: 20px;
    gap: 10px;
}

.profile div {
    height: 35px;
    padding: 0 20px;
    border-radius: 6px;
    background: #235effb6;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    color: #fff;
    cursor: pointer;
    user-select: none;
}

.trust {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
    padding: 20px;
    background: #ffd5e328;
    width: 100%;
    padding: 20px;
    backdrop-filter: blur(20px);
    background-image: url("https://app.idle.finance/images/bg-noise.png");
}

.trust p:first-child {
    font-size: 14px;
}


.trust div:last-child p:first-child {
    font-size: 20px;
}


.trust p:last-child {
    color: #000000;
    font-size: 16px;
    font-family: 'Poppins', sans-serif;
}

.trust div:last-child p {
    text-align: center;
}
</style>
