<template>
<InProgress v-if="fetching" />
<div class="builder" v-else>
    <div class="screen" v-if="sections.length > 0">
        <div class="course">
            <div class="edit">
                <p class="label">Section title *</p>
                <input type="text" v-model="sections[selectedIndex].title" placeholder="Introduction, Conclusion.." maxlength="45">
            </div>

            <div class="edit">
                <p class="label">Choose video *</p>
                <div class="video">
                    <video v-if="sections[selectedIndex].src != ''" :src="sections[selectedIndex].src"></video>
                    <i v-if="sections[selectedIndex].src != ''" class="fa-solid fa-play"></i>
                    <input v-on:change="chooseFile($event)" type="file">
                </div>
            </div>

            <div class="text">
                <HtmlEditor :value="sections[selectedIndex].content" v-on:content="sections[selectedIndex].content = $event" height="400" />
            </div>

            <div class="save" v-if="!saving" v-on:click="saveChanges()">Save changes</div>
            <div class="save" v-else>Saving..</div>
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
            courseContract: null,
            saving: false,
            currentFile: null,
            currentSlices: []
        }
    },
    watch: {
        title: function (_title) {
            this.sections[this.selectedIndex].title = _title
        }
    },
    created() {
        this.getCourse()
        this.getCourseSections()
        this.addSection()

        this.$contracts.initCourseContract(this.$auth.provider)
        $nuxt.$on('course-contract', (contract) => {
            this.courseContract = contract
        })
    },
    methods: {
        addSection: function () {
            this.sections.push({
                id: 0,
                title: '',
                src: '',
                content: ''
            })
        },

        chooseFile: function (event) {
            const file = event.target.files[0]
            this.currentFile = file
            this.sliceFile(file)
        },

        sliceFile: async function (file) {

            // clean up array
            this.currentSlices = []

            const chunkSize = 1024 * 1024
            const chunks = Math.ceil(file.size / chunkSize, chunkSize)

            let chunk = 0
            while (chunk <= chunks) {
                const offset = chunk * chunkSize
                const slice = file.slice(offset, offset + chunkSize)
                if (slice.size > 0) {
                    const base64 = await this.$ipfs.toBase64(slice)
                    // const encryptedBase64 = this.$encryption.encrypt(base64, this.encryptionKey)
                    // this.currentSlices.push(encryptedBase64)
                    this.currentSlices.push(base64)
                }
                chunk++;
            }

        },

        saveChanges: async function () {
            if (this.saving || this.courseContract == null || this.$auth.accounts == 0) return

            this.saving = true

            let src = this.sections[this.selectedIndex].src

            if (this.currentFile.length == 0 && src == '') {
                $nuxt.$emit('warning', 'You haven\'t selected a video file')
                this.saving = false
                return
            }

            const uploadedSrc = [];

            for (let index = 0; index < this.currentSlices.length; index++) {
                const slice = this.currentSlices[index];
                const _src = await this.$ipfs.upload(`courses/${this.courseId}/${this.selectedIndex}/${index}`, slice)
                if (_src == null) {
                    $nuxt.$emit('warning', 'Failed to upload video file')
                    break
                }
                uploadedSrc.push(_src)
            }

            try {
                const duration = 6000
                const trx = await this.courseContract.createCourseSection(
                    this.courseId, this.sections[this.selectedIndex].title,
                    this.sections[this.selectedIndex].content, uploadedSrc.join('-'), duration, {
                        from: this.$auth.accounts[0]
                    }
                )
            } catch (error) {

            }

            this.saving = false
        },
        async getCourse() {
            this.course = await this.$firestore.fetch("courses", this.courseId);
            $nuxt.$emit(`course${this.courseId}`, this.course);
            this.fetching = false;
        },
        async getCourseSections() {
            this.sections = await this.$firestore.fetchAllWhere('course-sections', 'courseId', '==', this.courseId);
            if (this.sections.length == 0) {
                this.addSection()
            }
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
    background: #0176fb21;
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

.save {
    height: 60px;
    background: linear-gradient(90deg, #4b87f6 -43.68%, #3451f3 72.76%);
    border-radius: 8px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    user-select: none;
    cursor: pointer;
    margin-top: 60px;
    font-weight: 500;
    font-size: 20px;
    color: #FFFFFF;
}
</style>
