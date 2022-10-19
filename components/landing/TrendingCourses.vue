<template>
<section>
    <div class="app-width">
        <div class="title">
            <h3>Trending Courses</h3>
            <div class="action">Explore all courses <i class="fa-solid fa-arrow-right-long"></i></div>
        </div>
        <div class="trending">
            <div class="swiper trendSwiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" v-for="course in getValidCourses()" :key="course.id.toNumber()">
                        <div class="image">
                            <img src="https://cdn.tgdd.vn/hoi-dap/1321801/javascript-la-gi-co-vai-tro-gi-cach-bat-javascript-tren.001.jpg" alt="">
                        </div>
                        <div class="detail">
                            <h3 class="course_title">{{ course.name }}</h3>
                            <p class="instructor" v-if="course.instructorData"> <img src="/images/nft2.jpg" alt=""> {{ course.instructorData.lastName + ' ' + course.instructorData.firstName }} </p>
                            <p class="ratings"><i class="fa-solid fa-star"></i> 4.7 of 5.0 &nbsp; • &nbsp; 235 students</p>
                            <p class="price">{{ course.price.toNumber() }} $BDL</p>
                        </div>

                        <div class="description">
                            <div class="detail">
                                <p class="price">{{ course.price.toNumber() }} $BDL</p>
                                <h3 class="course_title">{{ course.name }}</h3>
                                <p class="instructor" v-if="course.instructorData"> <img src="/images/nft2.jpg" alt=""> {{ course.instructorData.lastName + ' ' + course.instructorData.firstName }} </p>
                                <p class="ratings"><i class="fa-solid fa-star"></i> 4.7 of 5.0 &nbsp; • &nbsp; 235 students</p>
                                <p class="sections">Sections</p>
                                <ul>
                                    <li>Introduction to javascript</li>
                                    <li>Variables</li>
                                    <li>Object and Classes</li>
                                    <p class="more_sections">+2 sections</p>
                                </ul>
                                <div class="action">
                                    <router-link :to="`/explore/courses/${course.id.toNumber()}`">
                                        <div class="buy">View Course</div>
                                    </router-link>
                                    <i class="fa-solid fa-heart-circle-plus"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    data() {
        return {
            courses: [],
        }
    },
    mounted() {
        $nuxt.$on('contracts-ready', (buidlContract) => {
            this.getCourses(buidlContract)
        })
    },
    updated() {
        new Swiper(".trendSwiper", {
            slidesPerView: 4,
            spaceBetween: 30,
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });
    },
    methods: {
        async getCourses(buidlContract) {
            let index = 1;
            let ended = false;

            try {
                while (!ended) {
                    const course = await buidlContract.courses(index);

                    const existing = this.courses.filter(_course =>
                        _course.id.toNumber() == course.id.toNumber()
                    )

                    if (existing.length == 0) {
                        if (course.id.toNumber() != 0) {
                            this.instructorData = null
                            this.courses.push(course)
                        } else {
                            ended = true
                        }
                    }

                    index++
                }
            } catch (error) {
                ended = true
            }

            this.getInstructors(buidlContract)
        },
        getValidCourses() {
            return this.courses.filter(course => course.id.toNumber() != 0)
        },
        async getInstructors(buidlContract) {
            for (let index = 0; index < this.courses.length; index++) {
                if (index > 20) break

                const instructor = await buidlContract.instructors(this.courses[index].instructor);
                if (instructor.id.toNumber() != 0) {
                    this.courses[index].instructorData = instructor

                    // force re rendering bug
                    let name = this.courses[index].name
                    this.courses[index].name = 'forcing'
                    this.courses[index].name = name
                }
            }
        }
    }
}
</script>

<style scoped>
section {
    padding-bottom: 50px;
}

.title {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 40px;
}

.title h3 {
    font-size: 40px;
    color: #fff;
}

.title div {
    background: #0177fb;
    padding: 6px 16px;
    border-radius: 6px;
    color: #fff;
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 20px;
}

.swiper {
    width: 100%;
    padding-bottom: 40px;
}

.swiper-slide {
    background: #2C2D3A;
    border-radius: 20px;
    user-select: none;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.swiper-slide .image {
    height: 250px;
    width: 100%;
}

.swiper-slide .image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.swiper-slide .detail {
    padding: 20px;
}

.detail .course_title {
    font-weight: 600;
    color: #e9e9e9;
    margin-bottom: 20px;
    font-size: 18px;
}

.detail .instructor {
    font-size: 16px;
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

.detail .ratings {
    margin-top: 10px;
    color: #a0a0a0;
}

.ratings i {
    color: rgb(255, 187, 0);
}

.price {
    padding: 6px 16px;
    border-radius: 6px;
    margin-top: 20px;
    background: #355f8f;
    font-family: 'Poppins';
    width: fit-content;
    color: #fff;
}

.description {
    height: 100%;
    width: 100%;
    background: #2C2D3A;
    position: absolute;
    right: 0%;
    bottom: -100%;
    z-index: 1;
    opacity: 0.5;
}

.swiper-slide:hover .description {
    bottom: 0;
    opacity: 1;
}

.description .price {
    margin-top: 0;
}

.description .course_title {
    margin-top: 20px;
}

.sections {
    background: #a0a0a0;
    color: #2C2D3A;
    padding: 4px 12px;
    border-radius: 6px;
    width: fit-content;
    font-weight: 600;
    margin-top: 20px;
}

ul {
    list-style: square;
}

ul li {
    padding: 10px 4px;
    color: #e9e9e9;
    font-size: 14px;
    border-bottom: 1px #a0a0a0 solid;
}

.more_sections {
    padding: 10px 4px;
    font-size: 12px;
    color: #7dbaff;
}

.action {
    display: grid;
    grid-template-columns: auto 50px;
    column-gap: 10px;
    height: 40px;
    margin-top: 10px;
}

.action .buy {
    background: #0177fb;
    height: 100%;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 16px;
}

.swiper-slide .action i {
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px rgb(255, 209, 5) solid;
    font-size: 20px;
    color: #fff;
}
</style>
