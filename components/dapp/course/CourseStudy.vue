<template>
<div class="study">
    <div class="screen">
        <div class="swiper-section">
            <div class="swiper-wrapper" v-if="sections.length > 0">
                <div class="swiper-slide" v-for="(section, index) in sections" :key="index">
                    <div class="section">
                        <div class="video">
                            <div class="title">{{ section.title }}</div>
                            <video src="/videos/sample.mp4"></video>
                            <i class="fa-solid fa-play"></i>
                        </div>
                        <div class="text" v-html="section.content"></div>
                    </div>
                </div>
                <div class="swiper-slide">
                    <div class="section">
                        <!-- <div class="video">dsds</div> -->
                    </div>
                </div>
            </div>
        </div>

        <div class="pager">
            <div class="prev scaleable" v-on:click="prev()">
                <i class="fa-solid fa-angle-left"></i> Previous Section
            </div>
            <div class="next scaleable" v-if="swiper && swiper.isEnd" v-on:click="onComplete()">
                Check Result <i class="fa-solid fa-angle-right"></i>
            </div>
            <div class="next scaleable" v-else v-on:click="next()">
                Next Section <i class="fa-solid fa-angle-right"></i>
            </div>
        </div>
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
        };
    },
    mounted() {
        this.getCourse();
        this.getCourseSections();

        $nuxt.$on("user", (user) => {
            this.user = user;
        });
    },
    updated() {
        if (this.swiper == null) {
            new Swiper(".swiper-section", {
                slidesPerView: 1,
                spaceBetween: 30,
            });
            this.swiper = document.querySelector(".swiper-section").swiper;
        }
    },
    methods: {
        prev() {
            if (this.swiper == null) return;
            this.swiper.slidePrev();
        },
        next() {
            if (this.swiper == null) return;
            this.swiper.slideNext();
        },
        async onComplete() {
            if (this.user != null && this.user.type == 'learner') {
                console.log('here');
                const document = await Certificate.generateDocument(this.user.name);

                console.log(document);

                const documentUrl = await this.$ipfs.upload(
                    `certificates/${this.$auth.accounts[0]}/${this.courseId}`,
                    document
                );

                console.log(documentUrl);

                if (documentUrl == null) {
                    $nuxt.$emit("error", "Failed to mint course certificate");
                    return;
                }

                const certificateJson = {
                    name: `${this.course.name} certificate`,
                    description: `This certificate is issued by Buidl to ${this.user.name} on ${Date()}`,
                    image: documentUrl,
                };

                console.log(certificateJson);

                const certificateMetadataUrl = await this.$ipfs.upload(
                    `certificates/${this.$auth.accounts[0]}/${this.courseId}.json`,
                    certificateJson
                );

                console.log(certificateMetadataUrl);

                if (certificateMetadataUrl == null) {
                    $nuxt.$emit("error", "Failed to mint course certificate");
                    return;
                }

                try {
                    const trx = await this.$contracts.buidlContract.onCompletedCourse(
                        this.courseId,
                        certificateMetadataUrl, {
                            from: this.$auth.accounts[0],
                        }
                    );

                    console.log(trx);
                } catch (error) {
                    console.log(error);
                }
            }
        },
        async getCourse() {
            const course = await this.$contracts.buidlContract.courses(this.courseId);

            if (course.id.toNumber() != 0) {
                this.course = course;
                $nuxt.$emit(`course${this.courseId}`, course);
            } else {
                this.notFound = true;
            }

            this.fetching = false;
        },
        async getCourseSections() {
            let index = 0;
            try {
                while (index < 5) {
                    const section = await this.$contracts.buidlContract.courseSections(
                        this.courseId,
                        index
                    );

                    if (section.id.toNumber() == 0) {
                        break;
                    }

                    const existing = this.sections.filter(
                        (_section) => section.id.toNumber() == _section.id.toNumber()
                    );

                    if (existing.length == 0) {
                        this.sections.push(section);
                    }

                    index++;
                }
            } catch (error) {}
        },
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
}

.swiper-section {
    width: 1000px;
    max-width: 100%;
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

.section .title {
    padding: 20px 30px;
    padding-bottom: 16px;
    font-size: 18px;
    color: #fff;
    font-weight: 600;
    background: #3b3c4e;
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

.section .text {
    margin-top: 50px;
    font-size: 17px;
    color: #fff;
    line-height: 22px;
    padding: 0 20px;
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
</style>
