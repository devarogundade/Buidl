<template>
<section>
    <!-- https://idle.finance/assets/img/bgCircles-desktop1.813090.svg -->
    <div class="bg"><img src="https://idle.finance/assets/img/Ellipse1.ee547e.png" alt=""></div>
    <div class="bg2"><img src="https://idle.finance/assets/img/Ellipse2.6ad222.png" alt=""></div>
    <div class="app-width">
        <div class="features">
            <div class="feature">
                <div class="text">
                    <h3>
                        Built for growth
                    </h3>
                    <p>
                        Get hired as a freelancer, grow your trust on work experience, expertise with
                        the Buidl Trust tokens, start building your network.
                    </p>
                </div>
                <div class="image">
                    <img src="https://www.talentprotocol.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fprofile.966f73d0.png&w=1080&q=75" alt="">
                </div>
            </div>
            <div class="feature">
                <div class="image">
                    <img src="https://www.talentprotocol.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fnotifications.64dc1155.png&w=1080&q=75" alt="">
                </div>
                <div class="text">
                    <h3>
                        Work together!
                    </h3>
                    <p>
                        Collaborate with other professionals that share similar goals with you
                        or build your team for your next hackethon project.
                    </p>
                </div>
            </div>
            <div class="feature">
                <div class="text">
                    <h3>
                        Built for growth
                    </h3>
                    <p>
                        Get hired as a freelancer, grow your trust on work experience, expertise with
                        the Buidl Trust tokens, start building your network.
                    </p>
                </div>
                <div class="image">
                    <img src="https://www.talentprotocol.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fprofile.966f73d0.png&w=1080&q=75" alt="">
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
section {
    padding-top: 160px;
    position: relative;
    overflow: hidden;
}

.bg {
    position: absolute;
    left: 0;
    top: 0;
    width: 600px;
    opacity: 0.5;
}

.bg img {
    width: 100%;
}

.bg2 {
    position: absolute;
    right: -100px;
    bottom: -50px;
    width: 1000px;
    opacity: 0.5;
    rotate: 90deg;
}

.bg2 img {
    width: 100%;
}


.features {
    display: flex;
    flex-direction: column;
    row-gap: 100px;
}

.feature {
    display: flex;
    flex-wrap: wrap;
    column-gap: 150px;
    justify-content: center;
    align-items: center;
}

.feature .image {
    width: 400px;
    max-width: 100%;
}

.feature .image img {
    width: 100%;
}

.feature .text {
    width: 450px;
    max-width: 100%;
    color: #fff;
}

.text h3 {
    font-size: 44px;
    font-family: black;
}

.text p {
    font-size: 20px;
    line-height: 28px;
    margin-top: 30px;
    font-weight: 600;
    opacity: 0.8;
}
</style>
