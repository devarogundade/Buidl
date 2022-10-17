<template>
<div class="container">
    <div class="grid">
        <div class="chat">
            <div class="online" v-if="members.length > 0">Sam is typing.. and 2 members online</div>
            <div class="messages" v-if="messages.length > 0">
                <div class="items">
                    <div class="item me">
                        <p class="text">Who is available tomorrow?</p>
                        <p class="time">12:54 today</p>
                    </div>
                    <div class="item me">
                        <p class="text">or should we all meet tonight?</p>
                        <p class="time">just now</p>
                    </div>
                    <div class="item other">
                        <p class="text">I'm going to market tomorrow</p>
                        <p class="time">12:54 today</p>
                    </div>
                    <div class="item other">
                        <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                        <p class="time">just now</p>
                    </div>
                    <div class="contract">
                        <div class="tags">
                            <p class="tag"><i class="fa-solid fa-handshake-simple"></i> Contract</p>
                            <div class="tag2">
                                <i class="fa-solid fa-gas-pump"></i>
                                <p>Gas fee is required to sign a contract</p>
                            </div>
                        </div>
                        <p class="title">Team member agreement on reward sharing.</p>
                        <p class="body">

                        </p>
                        <div class="action">
                            <div>Click to open</div>
                            <i class="fa-solid fa-ban"></i>
                        </div>
                    </div>
                    <div class="item me">
                        <p class="text">Alright dear <br> We're good then</p>
                        <p class="time">12:54 today</p>
                    </div>
                </div>
            </div>
            <div class="explain" v-else>
                <h3>No messages</h3>
                <p>
                    Use the input box below to start a conversation with your project members.
                </p>
                <div class="action">
                    Use the <i class="fa-solid fa-image"></i> icon to send an image to the chat.
                </div>
            </div>
            <div class="write">
                <textarea type="text" rows="1" placeholder="Write your message here.."></textarea>
                <div class="files">
                    <i class="fa-regular fa-image scaleable"></i>
                    <i class="fa-solid fa-file scaleable"></i>
                </div>
            </div>
        </div>
        <div class="tools">
            <div class="title">
                <h3>Tools</h3>
            </div>
            <div class="categories">
                <div class="category scaleable" v-on:click=" $nuxt.$emit('draw-board')">
                    <i class="fa-solid fa-compass-drafting"></i>
                    <h3>Draw</h3>
                </div>
                <div class="category scaleable">
                    <i class="fa-solid fa-square-poll-horizontal"></i>
                    <h3>Polls</h3>
                </div>
                <div class="category scaleable">
                    <i class="fa-solid fa-handshake"></i>
                    <h3>Contract</h3>
                </div>
                <div class="category scaleable">
                    <i class="fa-solid fa-video"></i>
                    <h3>Meeting</h3>
                </div>
                <div class="category scaleable">
                    <i class="fa-solid fa-calendar-days"></i>
                    <h3>Agenda</h3>
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
            messages: [],
            members: []
        }
    }
}
</script>

<style scoped>
.grid {
    width: 100%;
    display: grid;
    grid-template-columns: auto 450px;
    column-gap: 40px;
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

.explain a {
    color: #0177fb;
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

.chat {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    position: relative;
}

.online {
    width: 100%;
    padding: 4px;
    background: #0176fb57;
    border-radius: 6px;
    text-align: center;
    color: #fff;
    font-size: 16px;
    backdrop-filter: blur(20px);
    font-weight: bold;
    position: fixed;
    z-index: 1;
    top: 110px;
    width: 500px;
    transform: translate(-50%, 0);
    max-width: 100%;
    left: 46.5%;
}

.messages {
    display: flex;
    flex-direction: column;
    height: 100%;
    max-width: 600px;
    position: relative;
    width: 100%;
    padding-top: 160px;
    padding-bottom: 120px;
}

.write {
    position: fixed;
    bottom: 30px;
    left: 46.5%;
    transform: translate(-50%, 0);
    display: grid;
    grid-template-columns: auto 140px;
    width: 600px;
    max-width: 100%;
    column-gap: 20px;
}

.write .files {
    display: flex;
    align-items: center;
    justify-content: space-between;
    column-gap: 20px;
}

.files i {
    height: 60px;
    width: 60px;
    border-radius: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    user-select: none;
    background: #0177fb;
    color: white;
    cursor: pointer;
}

.write textarea {
    background: #fff;
    border-radius: 25px;
    border: none;
    outline: none;
    line-height: 26px;
    font-size: 18px;
    padding: 16px 20px;
    resize: none;
    overflow: hidden;
}

.items {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    gap: 20px;
}

.item {
    padding: 10px;
    border-radius: 10px;
    width: fit-content;
    min-width: 200px;
    max-width: 90%;
}

.me {
    background: #42ff97;
    border-bottom-right-radius: 0px;
    align-self: flex-end;
}

.other {
    background: #fff;
    border-bottom-left-radius: 0px;
}

.item .text {
    font-size: 16px;
    margin-bottom: 8px;
}

.item .time {
    font-size: 12px;
    opacity: 0.8;
}

.me .time {
    width: 100%;
    text-align: right;
}

.item img {
    width: 400px;
    max-width: 100%;
    border-radius: 6px;
}

.tools {
    border-left: 1px rgb(201, 227, 255) solid;
    height: calc(100vh - 100px);
    position: sticky;
    top: 100px;
    padding: 20px;
    padding-left: 40px;
    padding-right: 0;
}

.categories {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
}

.category {
    height: 100px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    gap: 10px;
    cursor: pointer;
    user-select: none;
}

.category i {
    color: #0177fb;
    font-size: 24px;
}

.category h3 {
    color: #fff;
    font-size: 20px;
    font-weight: 600;
}

.category:first-child {
    background-image: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
}

.category:nth-child(2) {
    background-image: linear-gradient(to top, #fbc2eb 0%, #a6c1ee 100%);
}

.category:nth-child(3) {
    background-image: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);
}

.category:nth-child(4) {
    background-image: linear-gradient(to top, #37ecba 0%, #72afd3 100%);
}

.category:nth-child(5) {
    background-image: linear-gradient(to top, #0ba360 0%, #3cba92 100%);
}

.tools .title {
    color: #fff;
    margin-bottom: 30px;
}

.tools .title h3 {
    font-size: 30px;
    font-family: 'Poppins', sans-serif;
}

.contract {
    border-radius: 20px;
    margin: 10px 0;
    background: #23242F;
    width: 400px;
    max-width: 100%;
    overflow: hidden;
    color: #fff;
    align-self: center;
}

.contract .tags {
    background: #2C2D3A;
    padding: 30px;
    padding-bottom: 15px;
}

.contract .tag {
    display: flex;
    align-items: center;
    column-gap: 10px;
    margin-bottom: 10px;
    font-size: 20px;
    font-weight: 600;
}

.contract .tag2 {
    display: grid;
    align-items: center;
    grid-template-columns: 24px auto;
    margin-bottom: 10px;
    font-size: 14px;
    color: #fff;
    background: #FF6370;
    width: fit-content;
    padding: 4px 10px;
    border-radius: 6px;
}

.contract .title {
    padding: 20px 30px;
    text-align: center;
    font-size: 16px;
    font-family: 'Poppins', sans-serif;
}

.contract .action {
    display: grid;
    grid-template-columns: auto 60px;
    column-gap: 10px;
    padding: 20px;
    margin-top: 30px;
}

.contract .action div,
.contract .action i {
    height: 50px;
    border-radius: 20px;
    display: flex;
    user-select: none;
    cursor: pointer;
    align-items: center;
    justify-content: center;
}

.contract .action div:first-child {
    background: #0177fb;
}

.contract .action i:last-child {
    background: #FF6370;
}
</style>
