<template>
<div class="container">
    <div class="ntfs">
        <div class="tabs">
            <h3 :class="tab == 1 ? 'active' : ''" v-on:click="tab = 1">Wallet</h3>
            <h3 :class="tab == 2 ? 'active' : ''" v-on:click="tab = 2">
                Certificates
            </h3>
            <h3 :class="tab == 3 ? 'active' : ''" v-on:click="tab = 3">My NFTs</h3>
        </div>

        <div class="items" v-show="tab == 1">
            <div class="balances">
                <div class="wallet">
                    <img src="/images/bnb_coin.png" alt="">
                    <p>13.32 <b>BNB</b></p>
                </div>
                <div class="wallet">
                    <img src="/favicon.ico" alt="">
                    <p>1,343.02 <b>BDL</b></p>
                </div>
            </div>
        </div>

        <div class="items" v-show="tab == 2">
            <div class="item" v-for="index in 4" :key="index">
                <div class="image">
                    <img :src="`/images/nft${index}.jpg`" alt="" />
                </div>
                <div class="creator">
                    <div class="profile">
                        <img src="/images/nft1.jpg" alt="" />
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
                    <div class="stake">Save <i class="fa-solid fa-download"></i></div>
                </div>
            </div>
        </div>

        <div class="items" v-show="tab == 3">
            <div class="item" v-for="(nft, index) in nfts" :key="index">
                <div class="image">
                    <img :src="toJson(nft.metadata).image" alt="" />
                </div>
                <div class="creator">
                    <div class="profile">
                        <img src="/favicon.ico" alt="" />
                        <div class="name">
                            <p>{{ toJson(nft.metadata).name }}</p>
                            <p>ID: {{ nft.token_id }}</p>
                        </div>
                    </div>
                    <div class="stat">
                        <p>{{ nft.symbol }}</p>
                        <p class="price">Weight <span>{{ toJson(nft.metadata).attributes[0].value }}%</span></p>
                    </div>
                </div>
                <a target="_blank" :href="`https://testnets.opensea.io/assets/bsc-testnet/${nft.token_address}/${nft.token_id}`">
                    <div class="action">
                        <div class="stake">Opensea <i class="fa-solid fa-arrow-up-right-from-square"></i></div>
                    </div>
                </a>
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
        };
    },
    mounted() {
        this.getNfts();
    },
    methods: {
        getNfts: async function () {
            const nfts = await this.$nft.getUserNfts(this.$auth.accounts[0]);
            this.nfts = nfts.result;
        },
        toJson: function (json) {
            if (json == null) {
                return {
                    name: "No name",
                    description: "No description",
                    image: "",
                    attributes: [{
                        display_type: "boost_percentage",
                        trait_type: "Weight",
                        value: 0,
                    }, ],
                };
            }
            return JSON.parse(json);
        },
    },
};
</script>

<style scoped>
.container {
    padding-top: 120px;
    padding-bottom: 50px;
}

.tabs {
    display: flex;
    align-items: center;
    gap: 30px;
}

.tabs h3 {
    font-size: 40px;
    color: #ffffff;
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
    flex-wrap: wrap;
    align-items: center;
    padding-top: 40px;
    overflow: hidden;
}

.items .item {
    width: 300px;
    background: #2c2d3a;
    border-radius: 16px;
}

.item .name p:first-child {
    font-size: 16px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.item .name p:last-child {
    font-size: 12px;
}

.items .image {
    height: 340px;
    border: 2px #ffffff solid;
    border-top-left-radius: 18px;
    border-top-right-radius: 18px;
    overflow: hidden;
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
    width: 30px;
    height: 30px;
    border-radius: 20px;
    object-fit: cover;
}

.creator {
    color: #ffffff;
}

.creator .price {
    font-size: 14px;
    margin-top: 4px;
    color: rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    gap: 4px;
}

.creator span {
    font-size: 12px;
    padding: 2px 6px;
    border-radius: 6px;
    color: #003f2c;
    background: #53f3c3;
}

.action {
    padding: 20px;
    padding-top: 0;
}

.item .stat {
    text-align: right;
}

.item .stat p:first-child {
    font-size: 14px;
}

.stake {
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    color: #ffffff;
    background: #0177fb;
    gap: 10px;
    border-radius: 12px;
}

.balances {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 100%;
    margin-top: 20px;
    gap: 40px;
}

.wallet {
    display: flex;
    gap: 20px;
    align-items: center;
    background: #2c2d3a;
    padding: 12px;
    border-radius: 40px;
    width: 100%;
}

.wallet p {
    font-size: 60px;
    color: #ffffff;
}

.wallet img {
    width: 70px;
    height: 70px;
    border-radius: 40px;
    object-fit: cover;
}
</style>
