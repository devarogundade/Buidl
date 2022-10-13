<template>
<div :class="`container ${state}`">
    <div class="box">
        <div class="title">
            <p>Add roadmap</p>
            <i v-on:click="$nuxt.$emit('discard-add-roadmap')" class="fa-solid fa-xmark"></i>
        </div>

        <div class="form">
            <div class="edit">
                <p class="label">Title</p>
                <input type="text" placeholder="@username" v-model="title">
            </div>

            <div class="edit">
                <p class="label">Date</p>
                <input type="text" placeholder="@username" v-model="title">
            </div>
        </div>

        <div class="sign_up" v-if="!creating" v-on:click="$nuxt.$emit('sm')">Add to roadmap</div>
        <div class="sign_up" v-else>Please wait..</div>
    </div>
</div>
</template>

<script>
export default {
    props: ['state'],
    mounted() {
        $nuxt.$on('create-new-post-for', (data) => {

        })
    }
}
</script>

<style scoped>
.container {
    position: fixed;
    top: 0;
    left: 0;
    background: #0176fb28;
    backdrop-filter: blur(20px);
    height: 100%;
    width: 100%;
    z-index: 50;
    display: flex;
    align-items: center;
    justify-content: center;
    user-select: none;
}

.hide {
    top: 100vh !important;
    transform: scale(0.5, 0.5);
}

.box {
    border-radius: 30px;
    max-width: 90%;
    width: 390px;
    background: #23242F;
    border-radius: 24px;
    padding: 30px;
}

.title {
    color: #FFFFFF;
    display: flex;
    column-gap: 10px;
    font-weight: 600;
    font-size: 16px;
    align-items: center;
    justify-content: space-between;
    margin-right: -10px;
    margin-top: -10px;
}

.title i {
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

.title i:hover {
    color: #FF6370;
}

.form {
    margin-top: 40px;
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
</style>
