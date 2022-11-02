<template>
<div class="study">
    <div class="refund">
        <div class="action" v-if="!refunding" v-on:click="refund()">Refund this course</div>
        <div class="action" v-else>Processing...</div>
    </div>
    <div class="sections">
        <div class="section" v-for="(section, index) in sections" :key="index" :class="activeSection && activeSection == (index + 1) ? 'active' : ''">
            <p class="nomba">{{ index + 1 }}.</p>
            <h3 class="title">{{ section.title }}</h3>
            <p class="length"><i class="fa-solid fa-clock"></i> 00.53 min</p>
            <p class="lock unlock"><i class="fa-solid fa-unlock"></i> Unlock</p>
            <!-- <p class="lock play"> <i class="fa-solid fa-play"></i> Play</p> -->
        </div>
    </div>

    <div class="screen">
        <video src="" class="player" controls></video>
    </div>
</div>
</template>

<script>
import Certificate from "/plugins/certificate.js";
export default {
    data() {
        return {
            courseId: this.$route.params.course,
            notFound: false,
            course: null,
            fetching: true,
            sections: [],
            swiper: null,
            user: this.$contracts.user,
            nfts: [],
            buidlContract: null,
            refunding: false,
            activeSection: 1
        };
    },
    created() {
        this.getCourse();
        this.getCourseSections();

        this.$contracts.initBuidlContract(this.$auth.provider)
        $nuxt.$on('buidl-contract', (contract) => {
            this.buidlContract = contract
            console.log(contract);
        })
    },
    updated() {
        if (this.swiper == null) {
            // new Swiper(".swiper-section", {
            //     slidesPerView: 1,
            //     spaceBetween: 30,
            // });
            // this.swiper = document.querySelector(".swiper-section").swiper;
        }
    },
    methods: {
        prev: function () {
            // if (this.swiper == null) return;
            // this.swiper.slidePrev();
        },
        next: function () {
            // if (this.swiper == null) return;
            // this.swiper.slideNext();
        },
        onComplete: async function () {},
        getCourse: async function () {
            this.course = await this.$firestore.fetch("courses", this.courseId);
            $nuxt.$emit(`course${this.courseId}`, this.course);
            this.fetching = false;
        },
        getCourseSections: async function () {
            this.sections = await this.$firestore.fetchAll("course-sections", this.courseId);
        },
        refund: async function () {
            if (this.buidlContract == null || this.$auth.accounts.length == 0) return
            this.refunding = true

            try {
                const trx = await this.buidlContract.unSubscribe(this.courseId, {
                    from: this.$auth.accounts[0]
                })
            } catch (error) {
                $nuxt.$emit('error', 'You can\'t refund this course')
                console.log(error);
            }

            this.refunding = false
        }
    },
};
</script>

<style scoped>
.study {
    padding-top: 120px;
    padding-bottom: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
}

.swiper-section {
    width: 100%;
    max-width: 1000px;
    overflow: hidden;
}

.swiper-wrapper {
    width: 100%;
}

.swiper-slide {
    width: 100%;
}

.swiper-slide img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.swiper-pagination-bullet {
    width: 20px;
    height: 20px;
    text-align: center;
    line-height: 20px;
    font-size: 12px;
    color: #000;
    opacity: 1;
    background: rgba(0, 0, 0, 0.2);
}

.swiper-pagination-bullet-active {
    color: #fff;
    background: #007aff;
}

.sections,
.section {
    width: 100%;
}

.section {
    display: grid;
    grid-template-columns: 20px auto 120px 120px;
    height: 80px;
    gap: 30px;
    align-items: center;
    color: #ffffff;
    padding: 0 20px;
    border-bottom: 1px solid #fff;
}

.lock {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    border-radius: 10px;
    background: #007aff;
    cursor: pointer;
    user-select: none;
    height: 40px;
}

.length {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.unlock {
    color: #FF6370;
    background: #ffdee1;
}

.section .nomba {
    font-size: 20px;
}

.active {
    background: #007bff34;
}

.section .title {
    font-size: 24px;
    font-weight: 600;
}

.refund {
    display: flex;
    justify-content: flex-end;
    width: 100%;
    margin-bottom: 40px;
}

.refund .action {
    width: 280px;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 50px;
    border-radius: 10px;
    border: 1px solid #FF6370;
    color: #FF6370;
    font-size: 20px;
    cursor: pointer;
    user-select: none;
}

.video {
    width: 100%;
    border-radius: 30px;
    background: #2c2d3a;
    overflow: hidden;
    position: relative;
}

.video video {
    width: 100%;
    height: 540px;
    object-fit: cover;
}

.video i {
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    background: #000000bd;
    color: #ffffff;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 50%;
}

.pager {
    margin-top: 100px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.pager div {
    height: 50px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    color: #007aff;
    background: #ffffff;
    cursor: pointer;
    font-weight: 600;
    user-select: none;
    padding: 0 20px;
    gap: 10px;
}

.screen {
    width: 100%;
    margin-top: 50px;
    border-radius: 20px;
    overflow: hidden;
}

.player {
    height: 600px;
    width: 100%;
}

@media screen and (max-width: 800px) {
    .study {
        padding-top: 0;
        padding-bottom: 0;
    }
}
</style>
