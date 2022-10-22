<template>
<div class="container">
    <div class="grid">
        <div class="profile">
            <div class="cover">
                <div class="image">
                    <img src="/favicon.ico" alt="">
                </div>
            </div>

            <div class="form">
                <div class="edit">
                    <p class="label">Full Name *</p>
                    <input :class="getInputClassForName()" type="text" v-model="name" placeholder="John Doe" maxlength="45">
                    <p v-if="errorName" class="error-text">{{ errorName }}</p>
                </div>

                <div class="edit">
                    <p class="label">Title *</p>
                    <input :class="getInputClassForDescription()" v-model="description" type="text" placeholder="Music producer">
                    <p class="error-text" v-if="errorDescription">{{ errorDescription }}</p>
                </div>

                <div class="edit">
                    <p class="label">Bio</p>
                    <input :class="getInputClassForTags()" type="text" v-model="tags" placeholder="Talks about #Music #Lyrics" maxlength="45">
                    <p v-if="errorTags" class="error-text">{{ errorTags }}</p>
                </div>

                <div class="edit">
                    <p class="label">About </p>
                    <HtmlEditor :height="300" />
                </div>

                <div class="sign_up" v-if="!signing" v-on:click="register()">Save changes</div>
                <div class="sign_up" v-else>Please wait..</div>
            </div>
        </div>
        <div class="others">
            <div class="skills">
                <div class="title">
                    <h3>Skills</h3>
                    <i class="fa-solid fa-plus"></i>
                </div>
                <div class="list">
                    <div class="item">JavaScript</div>
                    <div class="item">Kotlin</div>
                    <div class="item">React</div>
                    <div class="item">Angular</div>
                    <div class="item">NodeJs</div>
                    <div class="item">PHP</div>
                </div>
                <p class="see-more">See all <i class="fa-solid fa-chevron-down"></i></p>
            </div>
            <div class="positions">
                <div class="title">
                    <h3>Experience</h3>
                    <i class="fa-solid fa-plus"></i>
                </div>
                <div class="list">
                    <div class="item">
                        <div>
                            <p>Ex: Product Manager</p>
                            <p>Facebook</p>
                        </div>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                    <div class="item">
                        <div>
                            <p>Ex: Product Manager</p>
                            <p>Facebook</p>
                        </div>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
                <p class="see-more">See all <i class="fa-solid fa-chevron-down"></i></p>
            </div>
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
    width: 100%;
    display: flex;
    justify-content: center;
    padding-top: 100px;
    padding-bottom: 80px;
}

.profile {
    margin-top: 20px;
    width: 500px;
    max-width: 100%;
}

.grid {
    display: flex;
    flex-wrap: wrap;
    gap: 100px;
}

.cover {
    width: 100%;
    background: #000;
    height: 160px;
    position: relative;
}

.cover .image {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    position: absolute;
    bottom: -50px;
    left: 30px;
    overflow: hidden;
}

.cover img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.form {
    margin-top: 100px;
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

option {
    color: #3D392A;
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

.switch-con {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 20px;
}

.switch-con p {
    color: #FFFFFF;
    font-size: 20px;
    font-weight: 600;
}

.switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
}

.switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    -webkit-transition: .4s;
    transition: .4s;
}

.slider:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    -webkit-transition: .4s;
    transition: .4s;
}

.switch :checked+.slider {
    background-color: #4b87f6;
}

.switch :focus+.slider {
    box-shadow: 0 0 1px #3451f3;
}

.switch :checked+.slider:before {
    -webkit-transform: translateX(26px);
    -ms-transform: translateX(26px);
    transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
    border-radius: 34px;
}

.slider.round:before {
    border-radius: 50%;
}

.others {
    position: sticky;
    top: 100px;
    height: fit-content;
}

.skills {
    width: 300px;
    border-radius: 10px;
    background: #23242F;
    overflow: hidden;
}

.skills .title,
.positions .title {
    padding: 20px;
    color: #FFFFFF;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-family: 'Poppins', sans-serif;
    width: 100%;
}

.skills .item {
    height: 55px;
    padding: 15px 20px;
    color: #b8c0e6;
    font-size: 16px;
    font-weight: 500;
    border-bottom: 1px #3B3C4E solid;
}

.skills .item:first-child {
    border-top: 1px #3B3C4E solid;
}

.skills .see-more,
.positions .see-more {
    padding: 20px;
    text-align: center;
    color: #3451f3;
    font-size: 16px;
    font-weight: 600;
}

.positions {
    margin-top: 40px;
    width: 300px;
    border-radius: 10px;
    background: #23242F;
    overflow: hidden;
}

.positions .item {
    height: 65px;
    padding: 15px 20px;
    color: #b8c0e6;
    font-size: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 500;
    border-bottom: 1px #3B3C4E solid;
}

.positions .item:first-child {
    border-top: 1px #3B3C4E solid;
}

.positions>div p:last-child {
    font-size: 14px;
    color: #616eb9;
    font-weight: 600;
}
</style>
