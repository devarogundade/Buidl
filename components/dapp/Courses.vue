<template>
<div class="container">
    <div class="courses" v-if="courses.length > 0">
        <router-link :to="`/app/courses/${course.course.id.toNumber()}`" v-for="(course, index) in courses" :key="index">
            <div class="course scaleable">
                <div class="detail">
                    <img :src="course.image" alt="">
                    <h3>{{ course.name }}</h3>
                    <p>{{ course.description }}</p>
                </div>
            </div>
        </router-link>
    </div>
    <div class="explain" v-else>
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
            courses: []
        }
    },
    async mounted() {
        const instructorCoursesLength = await this.$contracts.buidlContract.getInstructorCoursesLength()
        for (let index = 0; index < instructorCoursesLength.toNumber(); index++) {
            const courseId = await this.$contracts.buidlContract.getInstructorCourseIdAtIndex(index)
            const course = await this.$contracts.buidlContract.courses(courseId)

            if (course.instructor.toLowerCase() == this.$auth.accounts[0].toLowerCase()) {
                this.$axios.get(course.ipfsHash).then((response) => {
                    const courseMetadata = response.data
                    courseMetadata.course = course
                    this.courses.push(courseMetadata)
                }).catch((error) => {})
            }
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 160px;
    padding-bottom: 50px;
    min-height: 100vh;
    position: relative;
}

.courses {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
}

.course {
    width: 420px;
    border-radius: 20px;
    background: #23242F;
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
}

.detail img {
    width: 60px;
    height: 60px;
    border-radius: 20px;
    object-fit: cover;
}

.detail h3 {
    font-size: 35px;
    font-weight: 600;
    margin-top: 10px;
}

.detail p {
    font-size: 16px;
    margin-top: 10px;
    opacity: 0.8;
}
</style>
