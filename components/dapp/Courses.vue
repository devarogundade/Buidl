<template>
<div class="container">
    <InProgress v-if="fetching" />

    <div class="tabs">
        <h3 :class="tab == 1 ? 'active' : ''" v-on:click="tab = 1">Subscribed</h3>
        <h3 v-if="user && user.verified" :class="tab == 2 ? 'active' : ''" v-on:click="tab = 2">Created</h3>
    </div>

    <div class="courses" v-show="(courses.length > 0) && !fetching && tab == 1">
        <router-link :to="`/app/courses/${course.id}`" v-for="(course, index) in courses" :key="index">
            <div class="course scaleable">
                <div class="detail">
                    <img :src="course.photo" alt="">
                    <h3>{{ course.name }}</h3>
                    <p>{{ course.description }}</p>
                </div>
            </div>
        </router-link>
    </div>

    <div class="explain" v-show="(courses.length == 0) && !fetching && tab == 1">
        <h3>What's a course?</h3>
        <p>
            <b>Buidl Course</b> provides you an environment with the handy tools you need to teach
            and publish your lectures to students. <br> <br> You are in full control of your course and data.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-search"></i> button to subscribe to your first course.
        </div>
    </div>

    <div class="fab-btn" v-if="tab == 1">
        <router-link to="/explore">
            <div class="fab">
                <i class="fa-solid fa-search"></i>
            </div>
        </router-link>
    </div>

    <!-- /////////////////////////////// -->

    <div class="courses" v-show="(createdCourses.length > 0) && !fetching && tab == 2">
        <router-link :to="`/app/course-builder/${course.id}`" v-for="(course, index) in createdCourses" :key="index">
            <div class="course scaleable">
                <div class="detail">
                    <img :src="course.photo" alt="">
                    <h3>{{ course.name }}</h3>
                    <p>{{ course.description }}</p>
                </div>
            </div>
        </router-link>
    </div>

    <div class="explain" v-show="(createdCourses.length == 0) && !fetching && tab == 2">
        <h3>What's a course?</h3>
        <p>
            <b>Buidl Course</b> provides you an environment with the handy tools you need to teach
            and publish your lectures to students. <br> <br> You are in full control of your course and data.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-plus"></i> button to create your first course.
        </div>
    </div>

    <div class="fab-btn" v-if="user && user.verified && tab == 2">
        <router-link to="/app/courses/create">
            <div class="fab">
                <i class="fa-solid fa-plus"></i>
            </div>
        </router-link>
    </div>

</div>
</template>

<script>
export default {
    data() {
        return {
            courses: [],
            createdCourses: [],
            fetching: true,
            tab: 1,
            user: null,
            buidlContract: this.$contracts.buidlContract,
            courseContract: this.$contracts.courseContract,
            provider: this.$auth.provider,
        }
    },
    created() {
        this.$contracts.initBuidlContract(this.provider)
        this.$contracts.initCourseContract(this.provider)

        $nuxt.$on('buidl-contract', (contract) => {
            if (this.buidlContract == null) {
                this.buidlContract = contract
                this.getUser()
            }
            this.buidlContract = contract
        })
        $nuxt.$on('course-contract', (contract) => {
            if (this.courseContract == null) {
                this.courseContract = contract
            }
            this.courseContract = contract
        })

        this.getCourses()
        this.getCreatedCourses()
        this.getUser()
    },
    methods: {
        getCourses: async function () {
            const response = await this.$stream.fetch('course-created')
            if (!response) return

            const status = response.status

            if (status) {
                const courses = response.data.data
                courses.forEach(course => {
                    const data = this.$utils.decode(['uint', 'string', 'string', 'uint', 'string', 'string', 'address'], course.data)
                    const creator = this.$utils.decode(['string', 'string', 'address'], course.creator.data)

                    this.courses.push({
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
                        }
                    })
                })

            }
            this.fetching = false
        },
        getCreatedCourses: async function () {
            const response = await this.$stream.fetchForAddress('course-created', this.$auth.accounts[0])
            if (!response) return

            const status = response.status

            if (status) {
                const courses = response.data.data
                courses.forEach(course => {
                    const data = this.$utils.decode(['uint', 'string', 'string', 'uint', 'string', 'string', 'address'], course.data)
                    this.createdCourses.push({
                        id: Number(data[0]),
                        name: data[1],
                        description: data[2],
                        category: data[3],
                        photo: data[4],
                        preview: data[5],
                        address: data[6]
                    })
                })
            }
        },
        getUser: async function () {
            const address = this.$auth.accounts[0]
            if (!address || !this.buidlContract) return

            const user = await this.buidlContract.users(address)
            this.user = {
                verified: user.verified,
                createdAt: Number(user.createdAt)
            }
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 120px;
    padding-bottom: 50px;
    min-height: 100vh;
    position: relative;
    width: 100%;
}

.tabs {
    display: flex;
    align-items: center;
    gap: 30px;
    margin-bottom: 60px;
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

.courses {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    width: 100%;
}

.courses a {
    max-width: 100%;
    display: block;
}

.course {
    width: 420px;
    max-width: 100%;
    height: 320px;
    justify-content: center;
    border-radius: 20px;
    background: #23242F;
    position: relative;
}

.fab-btn {
    width: 100%;
    display: flex;
    justify-content: flex-end;
    position: fixed;
    right: 5%;
    bottom: 5%;
}

.fab {
    margin-top: 40px;
    z-index: 20px;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    color: #0177fb;
    background: #FFFFFF;
    font-size: 35px;
    cursor: pointer;
    box-shadow: 0 4px 10px #ffffffb0;
}

.explain {
    border-radius: 30px;
    max-width: 90%;
    width: 400px;
    background: #23242F;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border-radius: 24px;
    color: #FFFFFF;
    padding: 30px;
    position: absolute;
}

.explain h3 {
    font-size: 30px;
    font-family: 'Poppins', sans-serif;
}

.explain p {
    margin-top: 20px;
    font-size: 18px;
    line-height: 24px;
}

.explain .action {
    margin-top: 40px;
    background: #0177fb;
    padding: 8px 10px;
    border-radius: 16px;
    line-height: 24px;
    font-size: 16px;
    text-align: center;
    font-weight: 600;
}

.action i {
    padding: 4px;
    border-radius: 50%;
    background: #FFFFFF;
    color: #0177fb;
}

.detail {
    padding: 30px;
    padding-top: 100px;
    color: #FFFFFF;
    user-select: none;
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
}

.detail img {
    width: 120px;
    height: 100px;
    border-radius: 12px;
    object-fit: cover;
}

.detail h3 {
    font-size: 24px;
    font-weight: 600;
    margin-top: 10px;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.detail p {
    font-size: 16px;
    margin-top: 10px;
    opacity: 0.8;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

@media screen and (max-width: 700px) {
    .container {
        padding-top: 0;
        padding-bottom: 0;
    }

    .courses {
        justify-content: center;
    }

    .fab {
        width: 60px;
        height: 60px;
        font-size: 25px;
    }
}
</style>
