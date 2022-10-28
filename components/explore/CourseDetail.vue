<template>
<section>
    <div class="app-width">
        <div class="container">
            <InProgress v-if="course == null" />
            <div class="course" v-else>
                <div class="head">
                    <div class="wrapper">
                        <div class="tree" v-if="category != null">
                            <router-link to="/explore">
                                <p>Explore</p>
                            </router-link>
                            <i class="fa-solid fa-chevron-right"></i>
                            <p>{{ category.name }}</p>
                        </div>
                        <h3 class="title">{{ course.name }}</h3>
                        <p class="subtitle">{{ course.description }}</p>
                        <div class="stat">
                            <p class="ratings"><i class="fa-solid fa-star"></i> 4.7 of 5.0 &nbsp; <router-link to="">(2 ratings)</router-link>
                            </p>
                            <p>•</p>
                            <p class="n_students">2 students</p>
                        </div>
                        <p class="instructor"> <img :src="course.creator.image" alt=""> {{ course.creator.name }} </p>
                        <div class="specs">
                            <p class="last_update"><i class="fa-solid fa-calendar-days"></i> 20 mins ago</p>
                            <p class="languages"><i class="fa-solid fa-globe"></i> English</p>
                        </div>
                    </div>

                    <div class="buy">
                        <div class="preview">
                            <img :src="course.photo" />
                            <i class="fa-solid fa-play"></i>
                        </div>
                        <div class="tag" v-if="!bought">Preview</div>
                        <div class="tag" v-else><i class="fa-solid fa-certificate"></i> Bought</div>

                        <div class="coupon" v-if="!bought">
                            <p>Apply Coupon</p>

                            <div class="options" v-show="showNfts && !bought">
                                <div class="nft_row" v-on:click="removeCoupon()">
                                    <div class="name">
                                        <p>Remove coupon</p>
                                        <p>0%</p>
                                    </div>
                                </div>
                                <div class="nft_row" v-for="(nft, index) in nfts" :key="index" v-on:click="applyCoupon(index)">
                                    <img :src="toJson(nft.metadata).image" alt="">
                                    <div class="name">
                                        <p>{{ toJson(nft.metadata).name }}</p>
                                        <p>{{ toJson(nft.metadata).attributes[0].value }}% off</p>
                                    </div>
                                </div>
                            </div>

                            <div class="selector" v-on:click="showNfts = !showNfts">
                                <div class="nft_row" v-if="selectedNft == null">
                                    <div class="name">
                                        <p>Click here to select a coupon</p>
                                        <a href="" target="_blank">
                                            <p>Buy coupon on Opensea</p>
                                        </a>
                                    </div>
                                </div>
                                <div class="nft_row" v-else>
                                    <img :src="toJson(nfts[selectedNft].metadata).image" alt="">
                                    <div class="name">
                                        <p>{{ toJson(nfts[selectedNft].metadata).name }}</p>
                                        <p>{{ toJson(nfts[selectedNft].metadata).attributes[0].value }}% off</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pricing" v-if="!bought">
                            <div>
                                <p>Course price</p>
                                <p v-if="course.price">{{ course.price }} BDL</p>
                            </div>

                            <div>
                                <p>Coupon discount</p>
                                <p v-if="selectedNft != null">{{ calcDiscount(selectedNft).toFixed(2) }} BDL</p>
                                <p v-else>0 BDL</p>
                            </div>

                            <div>
                                <p>Total price</p>
                                <p v-if="selectedNft != null">{{ 0 }} BDL</p>
                                <p v-else>{{ 0 }} BDL</p>
                            </div>
                        </div>

                        <div class="action" v-if="author">
                            <router-link :to="`/app/course-builder/${$route.params.course}`">
                                <div class="pay">Edit Course</div>
                            </router-link>
                            <i class="fa-solid fa-heart-circle-plus"></i>
                        </div>

                        <div class="action" v-else>
                            <div class="pay" v-if="!bought" v-on:click="buyCourse()">Buy Course</div>
                            <router-link v-else :to="`/app/courses/${$route.params.course}`">
                                <div class="pay">Study Course</div>
                            </router-link>
                            <i class="fa-solid fa-heart-circle-plus"></i>
                        </div>
                    </div>
                </div>

                <div class="body">
                    <div class="content">
                        <h3 class="title">Course content</h3>
                        <div class="desc">{{ sections.length }} sections &nbsp; • &nbsp; {{ sections.length }} Tests &nbsp; • &nbsp; 6 hours length</div>

                        <div class="accordions">
                            <div class="accordion" v-for="(section, index) in sections" :key="index">
                                <div class="front" v-on:click="openAccordion(index)">
                                    <div>
                                        <i class="fa-solid fa-chevron-down"></i>
                                        <p>{{ section.title }}</p>
                                    </div>
                                    <p>1 test • 4min</p>
                                </div>
                                <div class="back" v-if="selectedSection == index">
                                    <video src=""></video>
                                </div>
                            </div>
                        </div>
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
        return {
            selectedSection: 0,
            courseId: this.$route.params.course,
            course: null,
            sections: [],
            categories: [],
            notFound: false,
            bought: false,
            author: false,
            nfts: [],
            selectedNft: null,
            showNfts: false,
        }
    },
    mounted() {
        this.getCourse()
        this.getNfts()
    },
    methods: {
        openAccordion(index) {
            if (this.selectedSection == index) {
                this.selectedSection = -1
            } else {
                this.selectedSection = index
            }
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
        calcDiscount(index) {
            const weight = this.toJson(this.nfts[index].metadata).attributes[0].value
            return (weight / 100) * this.course.price.toNumber()
        },
        removeCoupon: function () {
            this.selectedNft = null
            this.showNfts = false
        },
        applyCoupon: function (index) {
            this.selectedNft = index
            this.showNfts = false
        },
        getNfts: async function () {
            if (this.$auth.accounts == null) return
            const nfts = await this.$nft.getUserNfts(this.$auth.accounts[0])
            this.nfts = nfts.result
        },
        async getCourse() {
            const response = await this.$stream.fetch('course-created')
            if (!response) return

            const status = response.status

            if (status) {
                const courses = response.data.data
                courses.forEach(course => {
                    const data = this.$utils.decode(['uint', 'string', 'string', 'uint', 'string', 'string', 'address'], course.data)
                    const creator = this.$utils.decode(['string', 'string', 'address'], course.creator.data)
                    if (Number(data[0] == this.courseId)) {
                        this.course = {
                            id: Number(data[0]),
                            name: data[1],
                            description: data[2],
                            category: Number(data[3]),
                            photo: data[4],
                            preview: data[5],
                            address: data[6],
                            creator: {
                                name: creator[0],
                                image: creator[1],
                                address: creator[2]
                            }
                        }

                        this.author = this.course.creator.address.toLowerCase() == this.$auth.accounts[0].toLowerCase()
                        $nuxt.$emit(`course${this.courseId}`, this.course)

                        return
                    }
                })
            }
        },
        async getCategories() {
            const response = await this.$stream.fetch('create-category')
            if (!response) return

            const status = response.status

            if (status) {
                const categories = response.data.data
                categories.forEach(category => {
                    const data = this.$utils.decode(['uint256', 'string', 'string'], category.data)
                    this.categories.push({
                        id: Number(data[0]),
                        name: data[1],
                        photo: data[2]
                    })
                })
            }
        },
        async getCourseSections() {

        },
        async buyCourse() {}
    }
};
</script>

<style scoped>
.container {
    min-height: 100vh;
}

.course {
    padding-top: 100px;
    padding-bottom: 100px;
}

.head {
    width: 100%;
    background-image: linear-gradient(to top, #09203f 0%, #537895 100%);
    padding: 40px;
    position: relative;
}

.wrapper {
    width: 1000px;
    max-width: 100%;
}

.tree {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #000000;
    font-size: 16px;
}

.tree a {
    color: #000000;
    text-decoration: underline;
}

.tree i {
    font-size: 12px;
}

.wrapper .title {
    color: #FFFFFF;
    margin-top: 20px;
    font-size: 40px;
}

.subtitle {
    color: #FFFFFF;
    opacity: 0.8;
    margin-top: 20px;
    font-size: 20px;
    width: 800px;
    max-width: 100%;
}

.body {
    margin-top: 40px;
}

.content {
    width: 1200px;
    max-width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.buy {
    width: 400px;
    background: #2C2D3A;
    position: absolute;
    right: 40px;
    top: 40px;
    border-radius: 10px;
    overflow: hidden;
}

.preview {
    width: 100%;
    height: 220px;
    position: relative;
}

.preview i {
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    background: #000000bd;
    color: #FFFFFF;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 50%;
}

.preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.stat {
    margin-top: 20px;
    display: flex;
    align-items: center;
    gap: 20px;
    font-size: 16px;
    color: #a0a0a0;
}

.ratings a {
    color: #0177fb;
    text-decoration: underline;
}

.ratings i {
    color: rgb(255, 187, 0);
}

.instructor {
    font-size: 16px;
    margin-top: 20px;
    color: #fff;
    display: flex;
    align-items: center;
}

.instructor img {
    width: 30px;
    height: 30px;
    object-fit: cover;
    border-radius: 20px;
    margin-right: 10px;
}

.specs {
    margin-top: 20px;
    display: flex;
    align-items: center;
    gap: 20px;
    color: #fff;
    opacity: 0.6;
}

.specs i {
    margin-right: 4px;
}

.content .title {
    font-size: 26px;
    color: #fff;
    width: 1000px;
    max-width: 100%;
}

.content .desc {
    display: flex;
    align-items: center;
    color: #a0a0a0;
    margin-top: 10px;
    font-size: 16px;
    width: 1000px;
    max-width: 100%;
}

.accordions {
    width: 1000px;
    max-width: 100%;
    margin-top: 40px;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.accordion {
    background: #2C2D3A;
    overflow: hidden;
    border-radius: 10px;
    user-select: none;
}

.accordion .front {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 60px;
    padding: 0 20px;
    background: #242531;
    cursor: pointer;
}

.front div:first-child {
    display: flex;
    align-items: center;
    gap: 20px;
    color: #FFFFFF;
    font-size: 18px;
}

.front>p {
    background: #0177fb;
    padding: 3px 10px;
    border-radius: 6px;
    font-size: 16px;
    color: #FFFFFF;
}

.back {
    padding: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}

.back video {
    width: 400px;
    height: 400px;
}

.buy .tag {
    margin: 20px;
    width: fit-content;
    padding: 3px 8px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    gap: 4px;
    line-height: 14px;
    background: #09203f;
    color: #0177fb;
    font-size: 14px;
}

.coupon {
    padding: 0 20px;
}

.nft_row {
    display: flex;
    align-items: center;
    gap: 10px;
}

.nft_row img {
    width: 30px;
    height: 40px;
    border-radius: 4px;
    object-fit: cover;
}

.nft_row .name p:first-child {
    font-size: 16px;
    color: #e0e0e0;
}

.nft_row .name p:last-child {
    color: #003f2c;
    background: #53f3c3;
    padding: 2px 6px;
    border-radius: 6px;
    margin-top: 4px;
    width: fit-content;
    font-size: 12px;
}

.coupon>p {
    color: #fff;
    font-size: 16px;
    margin-bottom: 10px;
}

.selector {
    padding: 10px;
    border-radius: 6px;
    background: #242531;
}

.options {
    position: fixed;
    background: #ffffff;
    z-index: 4;
    width: 400px;
    transform: translate(-50%, -50%);
    padding: 10px;
    border-radius: 10px;
    top: 50%;
    left: 50%;
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-height: 300px;
    overflow-y: scroll;
}

.options .nft_row {
    padding: 6px;
    cursor: pointer;
    border-radius: 6px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.options .nft_row img {
    width: 50px;
    height: 60px;
    border-radius: 6px;
    object-fit: cover;
}

.options .nft_row .name p:first-child {
    font-size: 18px;
    color: #242531;
}

.options .nft_row .name p:last-child {
    color: #003f2c;
    background: #53f3c3;
    padding: 2px 6px;
    border-radius: 6px;
    margin-top: 4px;
    width: fit-content;
    font-size: 12px;
}

.options .nft_row:hover {
    background: #5da3ff;
}

.action {
    display: grid;
    grid-template-columns: auto 50px;
    column-gap: 10px;
    height: 40px;
    margin-top: 20px;
    margin-bottom: 60px;
    user-select: none;
    padding: 20px;
}

.action .pay {
    background: #0177fb;
    height: 100%;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}

.action i {
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px rgb(255, 209, 5) solid;
    font-size: 20px;
    cursor: pointer;
    color: #fff;
}

.pricing {
    padding: 0 20px;
    padding-top: 20px;
}

.pricing>div {
    padding: 10px;
    border-radius: 6px;
    border: 3px solid #242531;
    margin-bottom: 6px;
}

.pricing p:first-child {
    font-size: 12px;
    color: #a0a0a0;
}

.pricing p:last-child {
    font-size: 16px;
    font-weight: 600;
    color: #e0e0e0;
}

@media screen and (max-width: 1300px) {
    .head {
        padding: 0;
    }

    .wrapper {
        padding: 20px;
    }

    .buy {
        position: unset;
        width: 100%;
        margin-top: 20px;
        border-radius: 0;
    }

    .wrapper .title {
        font-size: 24px;
    }

    .subtitle {
        font-size: 16px;
        margin-top: 10px;
    }
}
</style>
