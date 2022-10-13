<template>
<section>
    <div class="bg"><img src="https://idle.finance/assets/img/Ellipse1.ee547e.png" alt=""></div>
    <div class="bg2"><img src="https://idle.finance/assets/img/Ellipse2.6ad222.png" alt=""></div>
    <div class="app-width">
        <div class="set-profile">
            <div class="text">
                <h3>Link with LinkedIn</h3>
                <p>Connect your profile with your LinkedIn account for a faster onboarding process.</p>
            </div>

            <div class="image" v-if="hasLinkedIn">
                <img src="/images/linkedin-buidl.png" />
            </div>

            <div class="sign_up" v-if="!saving" v-on:click="save()">Connect</div>
            <div class="sign_up" v-else>Connecting..</div>
            <router-link to="/app">
                <div class="skip">Skip</div>
            </router-link>
        </div>
    </div>
</section>
</template>

<script>
export default {
    props: ['address'],
    data() {
        return {
            // first name
            name: '',
            errorName: null,
            // last name
            email: '',
            errorEmail: null,
            // bio
            bio: '',
            errorBio: null,
            // save
            saving: false,
            hasLinkedIn: true
        }
    },
    methods: {
        async save() {
            await this.ipfs.uploadSingleData("users", this.address, {
                name: this.name,
                email: this.email
            })
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
        getInputClassForBio() {
            if (this.bio == '') {
                this.errorBio = null
                return ''
            }
            if (this.bio.length < 6) {
                this.errorBio = 'Bio is too short'
                return 'error filled'
            } else {
                this.errorBio = null
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
    background: url('https://idle.finance/assets/img/bgCircles-desktop1.813090.svg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center center;
    position: relative;
    overflow: hidden;
}

.app-width {
    display: flex;
    justify-content: center;
}

.bg {
    position: absolute;
    left: 0;
    top: 0;
    width: 600px;
    opacity: 0.2;
}

.bg img {
    width: 100%;
}

.bg2 {
    position: absolute;
    right: -100px;
    bottom: -50px;
    width: 1000px;
    opacity: 0.2;
    rotate: 90deg;
}

.bg2 img {
    width: 100%;
}

.set-profile {
    width: 500px;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    min-height: 70vh;
}

.image {
    width: 250px;
}

.image img {
    width: 100%;
    box-shadow: 6px 6px 0 #0176fb2a;
    border-radius: 26px;
}

.text {
    text-align: center;
}

.text h3 {
    font-size: 34px;
    text-transform: capitalize;
    font-family: 'Poppins', sans-serif;
    color: #FFFFFF;
}

.text p {
    font-size: 18px;
    line-height: 26px;
    text-align: center;
    color: #ffffffce;
    margin-top: 10px;
    margin-bottom: 60px;
}

.sign_up {
    height: 50px;
    background: linear-gradient(90deg, #4b87f6 -43.68%, #3451f3 72.76%);
    border-radius: 20px;
    width: 200px;
    max-width: 100%;
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

.skip {
    height: 50px;
    border-radius: 20px;
    width: 200px;
    max-width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    user-select: none;
    text-decoration: underline;
    cursor: pointer;
    font-weight: 500;
    font-size: 18px;
    color: #FFFFFF;
    gap: 20px;
}
</style>
