<template>
<section>
    <div class="app-width">
        <div class="features">
            <div class="feature">
                <div class="text">
                    <h3>
                        Incentives for learning.
                    </h3>
                    <p>
                        Get a tradeable NFT on course completion. NFTs can be traded to cryptocurrency or
                        use for a coupon for your next course.
                    </p>
                </div>
                <div class="image">
                    <img src="/images/incentives.png" alt="">
                </div>
            </div>
            <div class="feature">
                <div class="image">
                    <img src="/images/inter_payment.png" alt="">
                </div>
                <div class="text">
                    <h3>
                        Seamless payments and refunds.
                    </h3>
                    <p>
                        Eliminate the limitation of banks and international
                        payments using the Buidl cryptocurrency  ($BDL Token) instead.
                    </p>
                </div>
            </div>
            <div class="feature">
                <div class="text">
                    <h3>
                        Get an on-chain certificate.
                    </h3>
                    <p>
                        An on-chain certificate guarantees the true ownership of your certificate. <br> <br> Certificates are in form of
                        NFTs that are not tradeable. <br> <br> Learn more about <a href="">ERC4973 <i class="fa-solid fa-arrow-up-right-from-square"></i></a>
                    </p>
                </div>
                <div class="image">
                    <img src="/images/certificate.png" alt="">
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
section {
    padding: 160px 0;
    position: relative;
    background-image: url('https://idle.finance/assets/img/bgCircles-desktop1.813090.svg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center center;
    overflow: hidden;
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

.text a {
    color: #50a2ff;
    text-decoration: underline;
}
</style>
