<template>
<section>
    <div class="app-width">
        <div class="nft">
            <div class="image">
                <img src="/images/nft-sample.png" alt="">
            </div>
            <div class="text">
                <h3>Purchase Talents NFT to Unlocked Premium Perks and Invest on their Growth.</h3>
                <router-link to="/collectibles">
                    <div class="action">NFTs Gallery</div>
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
    width: 220px;
    font-family: 'regular';
    font-weight: 600;
    color: black;
}
</style>
