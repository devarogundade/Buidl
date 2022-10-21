<template>
<div class="container">
    <div class="ntfs">
        <div class="tabs">
            <h3 :class="tab == 1 ? 'active' : ''" v-on:click="tab = 1">Wallet</h3>
            <h3 :class="tab == 2 ? 'active' : ''" v-on:click="tab = 2">Certificates</h3>
            <h3 :class="tab == 3 ? 'active' : ''" v-on:click="tab = 3">My NFTs</h3>
        </div>

        <div class="items" v-if="tab == 1"></div>

        <div class="items" v-if="tab == 2">
            <div class="item" v-for="index in 4" :key="index">
                <div class="image">
                    <img :src="`/images/nft${index}.jpg`" alt="">
                </div>
                <div class="creator">
                    <div class="profile">
                        <img src="/images/nft1.jpg" alt="">
                        <div class="name">
                            <p>Laura</p>
                            <p>0.32 BDL</p>
                        </div>
                    </div>
                    <div class="stat">
                        <p>MarketCap</p>
                        <p class="price">$3,490 <span>+0.5%</span></p>
                    </div>
                </div>
                <div class="action">
                    <div class="stake">Download</div>
                </div>
            </div>
        </div>

        <div class="items" v-if="tab == 3">
            <div class="item" v-for="index in 4" :key="index">
                <div class="image">
                    <img :src="`/images/nft${index}.jpg`" alt="">
                </div>
                <div class="creator">
                    <div class="profile">
                        <img src="/images/nft1.jpg" alt="">
                        <div class="name">
                            <p>Laura</p>
                            <p>0.32 BDL</p>
                        </div>
                    </div>
                    <div class="stat">
                        <p>MarketCap</p>
                        <p class="price">$3,490 <span>+0.5%</span></p>
                    </div>
                </div>
                <div class="action">
                    <div class="stake">Sell</div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            tab: 1,
            nfts: [],
        }
    },
    mounted() {
        this.getNfts()
    },
    methods: {
        getNfts: async function() {
            const nfts = await this.$nft.getUserNfts(this.$auth.accounts[0])
            console.log(nfts);
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 120px;
}

.tabs {
    display: flex;
    align-items: center;
    gap: 30px;
}

.tabs h3 {
    font-size: 40px;
    color: #FFFFFF;
    font-weight: 600;
    cursor: pointer;
}

.tabs .active {
    color: rgb(255, 208, 0);
    text-decoration: underline;
}

.items {
    display: flex;
    gap: 40px;
    align-items: center;
    padding-top: 40px;
    justify-content: space-between;
}

.items .item {
    width: 300px;
    background: #2c2d3a;
}

.items .image {
    height: 340px;
    border: 2px #FFFFFF solid;
}

.items .image img {
    width: 100%;
    height: 100%;
}

.creator {
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
}

.profile {
    display: flex;
    align-items: center;
    gap: 10px;
}

.creator img {
    width: 40px;
    height: 40px;
    border-radius: 20px;
    object-fit: cover;
}

.creator {
    color: #FFFFFF;
}

.creator .price {
    font-size: 14px;
    margin-top: 4px;
    color: rgba(255, 255, 255, 0.8);
}

.creator span {
    font-size: 12px;
    padding: 2px 6px;
    border-radius: 6px;
    color: #003f2c;
    background: #53F3C3;
}

.action {
    padding: 20px;
    padding-top: 0;
}

.item .stat {
    text-align: right;
}

.stake {
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: 600;
    color: #FFFFFF;
    background: #0177fb;
}
</style>
