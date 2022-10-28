<template>
<div class="container">
    <InProgress v-if="fetching" />

    <div class="tabs">
        <h3 :class="tab == 1 ? 'active' : ''" v-on:click="tab = 1">All Courses</h3>
        <h3 :class="tab == 2 ? 'active' : ''" v-on:click="tab = 2">Created</h3>
    </div>

    <div class="courses" v-show="(courses.length > 0) && !fetching && tab == 1">
        <router-link :to="`/app/courses/${Number(course[0])}`" v-for="(course, index) in courses" :key="index">
            <div class="course scaleable">
                <div class="detail">
                    <img :src="course[4]" alt="">
                    <h3>{{ course[1] }}</h3>
                    <p>{{ course[2] }}</p>
                </div>
            </div>
        </router-link>
    </div>

     <div class="courses" v-show="(courses.length > 0) && !fetching && tab == 2">
        <router-link :to="`/app/course-builder/${Number(course[0])}`" v-for="(course, index) in createdCourses" :key="index">
            <div class="course scaleable">
                <div class="detail">
                    <img :src="course[4]" alt="">
                    <h3>{{ course[1] }}</h3>
                    <p>{{ course[2] }}</p>
                </div>
            </div>
        </router-link>
    </div>

    <div class="explain" v-show="(courses.length == 0) && !fetching">
        <h3>What's a course?</h3>
        <p>
            <b>Buidl Course</b> provides you an environment with the handy tools you need to teach
            and publish your lectures to students. <br> <br> You are in full control of your course and data.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-plus"></i> button to create your first course.
        </div>
    </div>

    <div class="fab-btn">
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
            tab: 1
        }
    },
    created() {
        this.getCourses()
        this.getCreatedCourses()
    },
    methods: {
        async getCourses() {
            const response = await this.$stream.fetch('course-created')
            if (!response) return

            const status = response.status

            if (status) {
                const courses = response.data.data
                courses.forEach(course => {
                    const data = this.$utils.decode(['uint', 'string', 'string', 'uint', 'string', 'string', 'address'], course.data)
                    this.courses.push(data)
                })

            }
            this.fetching = false
        },
        async getCreatedCourses() {
            const response = await this.$stream.fetchForAddress('course-created', this.$auth.accounts[0])
            if (!response) return

            const status = response.status

            if (status) {
                const courses = response.data.data
                courses.forEach(course => {
                    const data = this.$utils.decode(['uint', 'string', 'string', 'uint', 'string', 'string', 'address'], course.data)
                    this.createdCourses.push(data)
                })

            }
        },
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
    margin-top: 60px;
}

.courses a {
    font-display: block;
    max-width: 100%;
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
}

.detail p {
    font-size: 16px;
    margin-top: 10px;
    opacity: 0.8;
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
