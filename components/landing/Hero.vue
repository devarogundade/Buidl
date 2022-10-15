<template>
<section>
    <div class="bg"><img src="https://idle.finance/assets/img/Ellipse1.ee547e.png" alt=""></div>
    <div class="bg2"><img src="https://app.idle.finance/images/ellipse-topleft.svg" alt=""></div>
    <div class="app-width">
        <div class="hero">
            <div class="grid">
                <div class="text">
                    <h3>Learn without limits. <br> <span>Buidl</span> a career.</h3>
                    <p>Building a Borderless, Permissionless and Decentralized Community of Instructors and Students.</p>
                    <router-link to="/explore">
                        <div class="feeds">Courses <i class="fa-solid fa-arrow-right"></i></div>
                    </router-link>
                </div>
                <div class="image">
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                                <div class="profile">

                                </div>
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.gq.com/photos/5582d76209f0bee56440264f/master/w_1600%2Cc_limit/entertainment-2014-10-9-rising-female-artists-06-jhene-aiko.jpg" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://i.pinimg.com/736x/37/8a/30/378a308e0d89db685588c03f332d4a43.jpg" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="stats">
                    <div class="stat">
                        <h3>2.2k+</h3>
                        <p>Verified Instructors</p>
                    </div>
                    <div class="stat">
                        <h3>1,937,392 $BDL</h3>
                        <p>Trusted to the community</p>
                    </div>
                    <div class="stat">
                        <h3>32.8k+</h3>
                        <p>Active students</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    data() {
        return {}
    },
    mounted() {
        try {
            new Swiper(".mySwiper", {
                effect: "cards",
                grabCursor: true,
                loop: true,
                autoplay: true,
                delay: 3000,
                disableOnInteraction: false
            });
        } catch (error) {}
    },
}
</script>

<style scoped>
section {
    overflow: hidden;
}

.bg {
    position: absolute;
    left: 0;
    top: 0;
    width: 500px;
    opacity: 0.15;
}

.bg img {
    width: 100%;
}

.bg2 {
    position: absolute;
    right: 100px;
    bottom: -150px;
    width: 1000px;
    opacity: 0.15;
    rotate: 90deg;
}

.bg2 img {
    width: 100%;
}

.swiper {
    width: 350px;
    height: 500px;
}

.swiper-slide {
    border-radius: 30px;
    background: #2C2D3A;
    padding: 20px;
}

.swiper-slide img {
    width: 100%;
    height: 340px;
    object-fit: cover;
    border-radius: 20px;
    box-shadow: 6px 6px 0 #0176fb2a;
}

section {
    min-height: 100vh;
    background-repeat: no-repeat;
    background-size: cover;
    background-image: #001731;
}

.hero {
    padding: 200px 0;
    height: 100%;
}

.grid {
    column-gap: 200px;
    height: 100%;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    column-gap: 200px;
    row-gap: 100px;
    align-items: center;
}

.text {
    width: 600px;
    max-width: 100%;
}

.text h3 {
    font-size: 50px;
    line-height: 60px;
    font-family: 'Poppins', sans-serif;
    color: #fff;
}

.text h3 span {
  background: -webkit-linear-gradient(#e3ffe1, rgb(23, 236, 23));
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.text p {
    font-size: 28px;
    line-height: 32px;
    color: #FFFFFF;
    font-weight: 600;
    margin-top: 20px;
}

.text .feeds {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 55px;
    background: #FF6370;
    color: #2C2D3A;
    margin-top: 60px;
    width: 200px;
    border-radius: 8px;
    font-size: 24px;
    font-weight: 600;
    column-gap: 20px;
}

.stats {
    display: flex;
    column-gap: 100px;
}

.stat h3 {
    font-size: 40px;
    color: #fff;
    font-weight: 600;
    font-family: bold;
}

.stat p {
    font-size: 20px;
    color: #fff;
    font-weight: 600;
    opacity: 0.8;
}
</style>
