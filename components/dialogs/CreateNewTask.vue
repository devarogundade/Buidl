<template>
<div :class="`container ${state}`">
    <div class="scroll">
        <div class="box">
            <div class="title">
                <p>Create new task</p>
                <i v-on:click="$nuxt.$emit('discard-new-task')" class="fa-solid fa-xmark"></i>
            </div>

            <div class="form">
                <div class="edit">
                    <p class="label">Title</p>
                    <input type="text" placeholder="Do something" v-model="title">
                </div>

                <div class="edit">
                    <p class="label">About task</p>
                    <HtmlEditor :height="300" />
                </div>

                <div class="edit">
                    <p class="label">Reward in $ BDL</p>
                    <input type="text" placeholder="100 BDL" v-model="title">
                    <p class="error-text">Note: This amount will be locked from your balance on creating task, and will be released to the
                        doer on task completion
                    </p>
                </div>
            </div>

            <div class="sign_up" v-if="!creating" v-on:click="$nuxt.$emit('discard-new-task')">Create task</div>
            <div class="sign_up" v-else>Please wait..</div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    props: ['state'],
    data() {
        return {
            title: '',
            description: '',
            creating: false
        }
    },
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
    backdrop-filter: blur(8px);
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

.scroll {
    overflow-x: auto;
    max-height: 80vh;
    width: 500px;
    border-radius: 24px;
}

.scroll::-webkit-scrollbar {
  display: none;
}

.box {
    border-radius: 30px;
    background: #23242F;
    max-width: 90%;
    width: 100%;
    padding: 30px;
    height: 100%;
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
