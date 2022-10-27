<template>
<div class="container">
    <div class="login">
        <div class="text">
            <h3>Create a new course</h3>
            <p>Enter course details below.</p>
        </div>

        <div class="form">
            <div class="edit">
                <p class="label">Course Title *</p>
                <input :class="getInputClassForName()" type="text" v-model="name" placeholder="Cooking Masterclass" maxlength="80">
                <p v-if="errorName" class="error-text">{{ errorName }}</p>
            </div>

            <div class="edit">
                <p class="label">Course Description *</p>
                <input :class="getInputClassForDescription()" v-model="description" type="text" placeholder="Learn how to cook your first meal">
                <p class="error-text" v-if="errorDescription">{{ errorDescription }}</p>
            </div>

            <div class="edit">
                <p class="label">Category *</p>
                <select v-on:change="onCategoryChanged($event)">
                    <option selected disabled hidden>Choose category</option>
                    <option v-for="(category, index) in categories" :key="index" :value="category.id">{{ category.name }}</option>
                </select>
                <p v-if="errorCategory" class="error-text">{{ errorCategory }}</p>
            </div>

            <div class="edit">
                <p class="label">Level *</p>
                <select v-on:change="onLevelChanged($event)">
                    <option selected disabled hidden>Choose level</option>
                    <option v-for="(level, index) in levels" :key="index" :value="(index + 1)">{{ level }}</option>
                </select>
            </div>

            <div class="edit">
                <p class="label">Tags</p>
                <input :class="getInputClassForTags()" type="text" v-model="tags" placeholder="Cooking, Food" maxlength="45">
                <p v-if="errorTags" class="error-text">{{ errorTags }}</p>
            </div>

            <div class="sign_up" v-if="!creating" v-on:click="createCourse()">Create course</div>
            <div class="sign_up" v-else>Please wait..</div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            // email
            name: '',
            errorName: null,
            // password
            description: '',
            errorDescription: null,
            // tags
            tags: '',
            errorTags: null,
            // signing
            creating: false,

            errorCategory: null,

            categories: [],
            selectedCategory: 0,

            levels: [
                'Beginner',
                'Intermediate',
                'Advanced'
            ],

            selectedLevel: 0
        }
    },
    mounted() {
        this.getCategories()
    },
    methods: {
        async getCategories() {

        },
        onCategoryChanged(event) {
            this.selectedCategory = event.target.value
        },
        onLevelChanged(event) {
            this.selectedLevel = event.target.value
        },
        async createCourse() {
            if (this.creating) return
            this.creating = false

            if (this.selectedCategory == 0) {
                this.errorCategory = 'Select a category'
            } else {
                this.errorCategory = null
            }

            if (this.errorName != null ||
                this.errorDescription != null ||
                this.errorTags != null
            ) {
                return
            }

            if (this.name == '' ||
                this.description == '' ||
                this.tags == ''
            ) {
                return
            }

            this.creating = true


        },
        getInputClassForName() {
            if (this.name == '') {
                this.errorName = null
                return ''
            }
            if (this.name.length < 5) {
                this.errorName = 'Title is too short'
                return 'error filled'
            } else {
                this.errorName = null
                return 'filled'
            }
        },
        getInputClassForDescription() {
            if (this.description == '') {
                this.errorDescription = null
                return ''
            }
            if (this.description.length < 10) {
                this.errorDescription = 'Description is too short'
                return 'error filled'
            } else {
                this.errorDescription = null
                return 'filled'
            }
        },
        getInputClassForTags() {
            if (this.tags == '') {
                this.errorTags = null
                return ''
            }
            if (this.tags.length < 4) {
                this.errorTags = 'Tags is too short'
                return 'error filled'
            } else {
                this.errorTags = null
                return 'filled'
            }
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 160px;
    padding-bottom: 100px;
    display: flex;
    justify-content: center;
}

.login {
    width: 520px;
    max-width: 100%;
}

.text {
    text-align: center;
}

.text h3 {
    font-size: 34px;
    color: #FFFFFF;
    font-weight: 600;
}

.text p {
    font-size: 18px;
    text-align: center;
    color: #ffffffce;
    margin-top: 10px;
}

.form {
    margin-top: 60px;
}

.form .edit {
    width: 100%;
    margin-top: 40px;
}

.form .label {
    font-weight: 600;
    font-size: 18px;
    line-height: 22px;
    letter-spacing: 0.02em;
    color: #b8c0e6;
    margin-bottom: 10px;
}

.form input,
select {
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

.form .filled {
    border: 2px solid #007a00;
}

.form .error {
    border: 2px solid #C74F4F;
}

.form .error-text {
    font-weight: 400;
    font-size: 14px;
    line-height: 17px;
    letter-spacing: 0.02em;
    color: #C74F4F;
    margin-top: 10px;
}

.sign_up {
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

option {
    color: #000;
}

/* @media screen and (max-width: 700px) {
    .text h3 {
        font-size: 24px;
        line-height: 36px;
    }
    .text p {
        font-size: 16px;
        line-height: 24px;
    }
    .signed {
        grid-template-columns: auto 100px;
    }
    .signed p {
        font-size: 14px;
        line-height: 22px;
    }
    .signed .continue {
        font-size: 16px;
        line-height: 20px;
    }
} */
</style>
