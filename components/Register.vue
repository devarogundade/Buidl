<template>
<section>
    <div class="app-width">
        <div class="register">
            <div class="text">
                <h3>Register</h3>
                <p>Choose your account type tab above (Student or an Instructor).</p>
            </div>

            <div class="tabs">
                <p :class="tab == 1 ? 'tab tab_active' : 'tab'" v-on:click="tab = 1">Learners</p>
                <p :class="tab == 2 ? 'tab tab_active' : 'tab'" v-on:click="tab = 2">Instructor</p>
            </div>

            <div class="signed" v-if="user && user.type">
                <p v-if="user.type == 'learner'">Welcome back, {{ user.name }}</p>
                <p v-if="user.type == 'instructor'">Welcome back, {{ user.firstName }}</p>
                <router-link to="/app">
                    <div class="continue">Continue</div>
                </router-link>
            </div>

            <div class="form" v-if="tab == 1">
                <div class="edit">
                    <p class="label">Enter Full Name</p>
                    <input :class="getInputClassForName()" v-model="name" type="text" placeholder="John Doe">
                    <p class="error-text" v-if="errorName">{{ errorName }}</p>
                </div>

                <div class="edit">
                    <p class="label">Email Address</p>
                    <input :class="getInputClassForEmail()" type="email" v-model="email" placeholder="Johndoe@mail.com" maxlength="45">
                    <p v-if="errorEmail" class="error-text">{{ errorEmail }}</p>
                </div>

                <div class="sign_up" v-if="!registering" v-on:click="registerAsStudent()">Register</div>
                <div class="sign_up" v-else>Please wait..</div>
            </div>

            <div class="form" v-if="tab == 2">
                <div class="requirement">
                    <div>
                        <i class="fa-solid fa-star-of-life"></i>
                        <p> You create an Instructor Account, you need to stake 2000 $BDL Token for a period of 1 year.</p>
                    </div>
                </div>

                <div class="edit">
                    <p class="label">Enter First Name</p>
                    <input :class="getInputClassForFirstName()" v-model="firstName" type="text" placeholder="John">
                    <p class="error-text" v-if="errorFirstName">{{ errorFirstName }}</p>
                </div>

                <div class="edit">
                    <p class="label">Enter Last Name</p>
                    <input :class="getInputClassForLastName()" v-model="lastName" type="text" placeholder="Doe">
                    <p class="error-text" v-if="errorLastName">{{ errorLastName }}</p>
                </div>

                <div class="edit">
                    <p class="label">Email Address</p>
                    <input :class="getInputClassForEmail()" type="email" v-model="email" placeholder="Johndoe@mail.com" maxlength="45">
                    <p v-if="errorEmail" class="error-text">{{ errorEmail }}</p>
                </div>

                <div class="edit">
                    <p class="label">Your Country</p>
                    <input :class="getInputClassForCountry()" v-model="country" type="text" placeholder="United States">
                    <p class="error-text" v-if="errorCountry">{{ errorCountry }}</p>
                </div>

                <div class="sign_up" v-if="!registering" v-on:click="registerAsInstructor()">Register</div>
                <div class="sign_up" v-else>Please wait..</div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    data() {
        return {
            user: this.$contracts.user,
            tab: 1,

            name: '',
            email: '',
            firstName: '',
            lastName: '',
            country: '',

            errorName: null,
            errorEmail: null,
            errorFirstName: null,
            errorLastName: null,
            errorCountry: null,

            registering: false
        }
    },
    mounted() {
        $nuxt.$on('user', (user) => {
            this.user = user
        })
    },
    methods: {
        async registerAsStudent() {
            if (this.registering) return
            this.registering = false

            if (this.errorName != null ||
                this.errorEmail != null) {
                return
            }
            if (this.name == '' ||
                this.email == '') {
                return
            }

            this.registering = true

            try {
                const trx = await this.$contracts.buidlContract.createStudentAccount(
                    this.name, this.email, '' /* gender */ , {
                        from: this.$auth.accounts[0]
                    }
                )
                this.$router.push('/app')
            } catch (error) {}
        },
        async registerAsInstructor() {
            if (this.registering) return
            this.registering = false

            if (this.errorFirstName != null ||
                this.errorLastName != null ||
                this.errorEmail != null ||
                this.errorCountry != null
            ) {
                return
            }

            if (this.firstName == '' ||
                this.lastName == '' ||
                this.email == '' ||
                this.country == ''
            ) {
                return
            }

            this.registering = true

            try {
                const trx = await this.$contracts.buidlContract.createInstructorAccount(
                    this.firstName, this.lastName, this.country, 0 /* gender */ , {
                        from: this.$auth.accounts[0]
                    }
                )
                this.$router.push('/app')
            } catch (error) {}
        },
        getInputClassForName() {
            if (this.name == '') {
                this.errorName = null
                return ''
            }
            if (this.name.length < 2) {
                this.errorName = 'Invalid full name'
                return 'error filled'
            } else {
                this.errorName = null
                return 'filled'
            }
        },
        getInputClassForFirstName() {
            if (this.firstName == '') {
                this.errorFirstName = null
                return ''
            }
            if (this.firstName.length < 2) {
                this.errorFirstName = 'Invalid first name'
                return 'error filled'
            } else {
                this.errorFirstName = null
                return 'filled'
            }
        },
        getInputClassForLastName() {
            if (this.lastName == '') {
                this.errorLastName = null
                return ''
            }
            if (this.lastName.length < 2) {
                this.errorLastName = 'Invalid last name'
                return 'error filled'
            } else {
                this.errorLastName = null
                return 'filled'
            }
        },
        getInputClassForCountry() {
            if (this.country == '') {
                this.errorCountry = null
                return ''
            }
            if (this.country.length < 3) {
                this.errorCountry = 'Invalid country name'
                return 'error filled'
            } else {
                this.errorCountry = null
                return 'filled'
            }
        },
        getInputClassForEmail() {
            if (this.email == '') {
                this.errorEmail = null
                return ''
            }
            if (!this.validateEmail(this.email)) {
                this.errorEmail = 'Invalid email address'
                return 'error filled'
            } else {
                this.errorEmail = null
                return 'filled'
            }
        },
        validateEmail(email) {
            return String(email)
                .toLowerCase()
                .match(
                    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                )
        }
    }
}
</script>

<style scoped>
section {
    padding-top: 160px;
    padding-bottom: 100px;
}

.app-width {
    display: flex;
    justify-content: center;
}

.register {
    width: 500px;
    max-width: 100%;
}

.tabs {
    width: 100%;
    height: 100%;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    height: 50px;
    overflow: hidden;
    border-radius: 6px;
    margin-top: 40px;
}

.tab {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    font-weight: 600;
    color: #FFFFFF;
    background: #2c2d3a;
    cursor: pointer;
    user-select: none;
    border: 2px solid transparent;
}

.tab_active {
    border: 2px solid #0177fb;
    background: #414364;
    border-radius: 6px;
}

.text {
    text-align: center;
}

.text h3 {
    font-weight: 700;
    font-size: 34px;
    line-height: 51px;
    letter-spacing: 0.02em;
    text-transform: capitalize;
    color: #F9F6ED;
}

.text p {
    font-weight: 600;
    font-size: 18px;
    line-height: 27px;
    text-align: center;
    letter-spacing: 0.02em;
    color: #BCB69F;
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
    color: #BCB69F;
    margin-bottom: 10px;
}

.form input {
    height: 50px;
    border: 2px solid #BCB69F;
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
    border: 2px solid #4b87f6;
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
    font-weight: 600;
    font-size: 20px;
    line-height: 24px;
    letter-spacing: 0.02em;
    color: #FFFFFF;
}

.signed {
    display: grid;
    grid-template-columns: auto 120px;
    align-items: center;
    width: 100%;
    margin-top: 30px;
    background: #2a323d;
    border-radius: 8px;
    padding: 10px 20px;
    column-gap: 20px;
}

.signed p {
    font-weight: 400;
    font-size: 16px;
    line-height: 24px;
    letter-spacing: 0.02em;
    color: #FFFFFF;
}

.signed .continue {
    height: 100%;
    height: 30px;
    background: #FFFFFF;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    user-select: none;
    font-weight: 400;
    font-size: 18px;
    line-height: 22px;
    letter-spacing: 0.02em;
    color: #0177fb;
}

.requirement {
    background: #c7b54f38;
    padding: 20px;
    border-radius: 20px;
}

.requirement>div {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 20px;
}

.requirement i {
    color: #fbb801;
}

.requirement p {
    color: white;
    font-size: 16px;
    line-height: 24px;
}

@media screen and (max-width: 700px) {
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
}
</style>
