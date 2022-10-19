<template>
<InProgress v-if="fetching" />
<div class="builder" v-else>
    <div class="screen">
        <div class="course">
            <div class="edit">
                <p class="label">Section Title *</p>
                <input type="text" v-model="sections[selectedIndex].title" placeholder="Introduction, Conclusion.." maxlength="45">
            </div>

            <div class="edit">
                <p class="label">Choose Video *</p>
                <div class="video">
                    <video v-if="sections[selectedIndex].src != ''" :src="sections[selectedIndex].video"></video>
                    <i v-if="sections[selectedIndex].src != ''" class="fa-solid fa-play"></i>
                    <input accept="video/*" v-on:change="chooseFile($event)" v-else type="file">
                </div>
            </div>

            <div class="text">
                <HtmlEditor height="400" />
            </div>
        </div>
    </div>
    <div class="grid">
        <div></div>
        <div class="section-scroll">
            <div class="sections">
                <div v-for="(section, index) in sections" :class="selectedIndex == index ? 'section active' : 'section'" :key="index" v-on:click="selectedIndex = index">
                    {{ section.title == '' ? 'No title' : section.title }}
                </div>
                <div class="add-section" v-on:click="addSection()">
                    <i class="fa-solid fa-plus"></i>
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
            selectedIndex: 0,
            courseId: this.$route.params.course,
            notFound: false,
            instructor: null,
            category: null,
            fetching: true,
            sections: [],
        }
    },
    watch: {
        title: function (_title) {
            this.sections[this.selectedIndex].title = _title
        }
    },
    mounted() {
        if (this.sections.length == 0) {
            this.addSection()
        }
        this.getCourse()
    },
    methods: {
        addSection() {
            this.sections.push({
                title: '',
                src: '',
                file: null
            })
        },
        chooseFile(event) {
            const file = event.target.files[0]
            this.sections[this.selectedIndex].file = file
        },
        async getCourse() {
            const course = await this.$contracts.buidlContract.courses(this.courseId);

            if (course.id.toNumber() != 0) {
                this.course = course

                this.instructor = await this.$contracts.buidlContract.instructors(course.instructor)
                this.category = await this.$contracts.buidlContract.categories(course.categoryId)
            } else {
                this.notFound = true
            }

            this.fetching = false
        },
    }
}
</script>

<style scoped>
.builder {
    width: 100%;
    height: 100%;
    padding-top: 160px;
    padding-bottom: 200px;
}

.grid {
    left: 0;
    width: 100%;
    position: fixed;
    padding: 0 5%;
    bottom: 20px;
    display: grid;
    grid-template-columns: 400px auto;
}

.section-scroll {
    overflow-x: auto;
    background: #ffffff2d;
    padding: 10px;
    border-radius: 20px;
    backdrop-filter: blur(20px);
}

.screen {
    display: flex;
    justify-content: center;
}

.video {
    width: 100%;
    border-radius: 20px;
    overflow: hidden;
    margin-bottom: 40px;
    position: relative;
}

.video video {
    width: 100%;
    height: 320px;
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
    color: #FFFFFF;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 50%;
    cursor: pointer;
}

.course {
    width: 600px;
    max-width: 100%;
}

.edit {
    width: 100%;
    margin-bottom: 40px;
}

.label {
    font-weight: 600;
    font-size: 18px;
    line-height: 22px;
    letter-spacing: 0.02em;
    color: #b8c0e6;
    margin-bottom: 10px;
}

input {
    height: 50px;
    border: 2px solid #b8c0e6;
    border-radius: 8px;
    background: transparent;
    width: 100%;
    padding: 0 20px;
    margin-top: 10px;
    font-weight: 400;
    font-size: 18px;
    line-height: 22px;
    letter-spacing: 0.02em;
    outline: none;
    color: #F9F6ED;
}

.sections {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 100%;
    gap: 30px;
}

.section {
    height: 100px;
    min-width: 160px;
    max-width: 180px;
    background: #FFFFFF;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    font-size: 16px;
    text-align: center;
    cursor: pointer;
    user-select: none;
    border: transparent 2px solid;
}

.active {
    border: #0177fb 6px solid;
}

.add-section {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 60px;
    color: #0177fb;
    height: 100px;
    min-width: 160px;
    background: #a2cdff;
    border-radius: 16px;
    cursor: pointer;
    user-select: none;
}
</style>