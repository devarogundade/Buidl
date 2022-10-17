<template>
<div class="container">
    <div class="login">
        <div class="text">
            <h3>Create a new course</h3>
            <p>Transaction fee is required to create a new course.</p>
        </div>

        <div class="signed" v-if="user">
            <p>You have signed in as {{ user.name }}</p>
            <router-link to="/">
                <div class="continue">Continue</div>
            </router-link>
        </div>

        <div class="form">
            <div class="edit">
                <p class="label">Project name *</p>
                <input :class="getInputClassForName()" type="text" v-model="name" placeholder="Hackathon 1" maxlength="45">
                <p v-if="errorName" class="error-text">{{ errorName }}</p>
            </div>

            <div class="edit">
                <p class="label">Project description *</p>
                <input :class="getInputClassForDescription()" v-model="description" type="text" placeholder="My first hackathon">
                <p class="error-text" v-if="errorDescription">{{ errorDescription }}</p>
            </div>

            <div class="edit">
                <p class="label">Tags</p>
                <input :class="getInputClassForTags()" type="text" v-model="tags" placeholder="Challenge, Innovation" maxlength="45">
                <p v-if="errorTags" class="error-text">{{ errorTags }}</p>
            </div>

            <div class="sign_up" v-if="!signing" v-on:click="register()">Create project</div>
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
            signing: false
        }
    },
    methods: {
        register() {

        },
        getInputClassForName() {
            if (this.name == '') {
                this.errorName = null
                return ''
            }
            if (this.name.length < 4) {
                this.errorName = 'Name is too short'
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
            if (this.tags.length < 2) {
                this.errorTags = 'Tags is too short'
                return 'error filled'
            } else {
                this.errorTags = null
                return 'filled'
            }
        },
        // validateEmail(email) {
        //     return String(email)
        //         .toLowerCase()
        //         .match(
        //             /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        //         )
        // }
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

.form input {
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
