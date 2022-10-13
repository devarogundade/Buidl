<template>
<div class="container">
    <div class="grid" v-if="tasks.length > 0">
        <div class="tasks">
            <div class="task" v-for="task in tasks" :key="task.id">
                <div class="title">
                    <h3>{{ task.title }}</h3>
                    <p class="reward">Reward {{ task.reward }} $BDL</p>
                </div>
                <div class="about">
                    <div class="text"></div>
                </div>
                <div class="member-con" v-on:drop="onDrop($event, task)" @dragover.prevent @dragenter.prevent>
                    <div class="member" v-if="task.member">
                        <img :src="task.member.image" alt="">
                        <div class="profile">
                            <h3>{{ task.member.name }}</h3>
                            <p class="tag">{{ task.member.role }}</p>
                        </div>
                        <i class="fa-solid fa-minus" v-on:click="task.member = null"></i>
                    </div>
                    <p v-else>Drag a member here</p>
                </div>
                <div class="action done">Mark as done</div>
            </div>
        </div>
        <div class="members">
            <p class="desc">Drag and drop a member on a task to assign the to them.</p>
            <div class="list">
                <div class="member" draggable v-for="member in members" :key="member.id" v-on:dragstart="startDrag($event, member)">
                    <img :src="member.image" alt="">
                    <div class="profile">
                        <h3>{{ member.name }}</h3>
                        <p class="tag">{{ member.role }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="explain" v-else>
        <h3>Assign task to members</h3>
        <p>
            Manage your projects members with <b>Tasks</b>. Keeping record of each task will help you build a strong team
            management.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-plus"></i> button to assign your first task.
        </div>
    </div>
    <div class="fab-btn" v-on:click="$nuxt.$emit('create-new-task', 1)">
        <div class="fab">
            <i class="fa-solid fa-plus"></i>
        </div>
    </div>
</div>
</template>

<script>
export default {
    props: ['project'],
    data() {
        return {
            tasks: [
              {
                    id: 1,
                    title: 'Write the code',
                    reward: 250,
                    date: null,
                    due: null,
                    status: 'no-member',
                    member: null
                },
                {
                    id: 2,
                    title: 'Sing the song',
                    reward: 100,
                    date: null,
                    due: null,
                    status: 'no-member',
                    member: null
                }
            ],
            members: [{
                    id: 1,
                    name: 'Arogundade Ibrahim',
                    role: 'Android Developer',
                    image: 'https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY='
                },
                {
                    id: 2,
                    name: 'Sam Jones',
                    role: 'Music Composer',
                    image: 'https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY='
                }
            ]
        }
    },
    methods: {
        startDrag(evt, member) {
            evt.dataTransfer.dropEffect = 'move'
            evt.dataTransfer.effectAllowed = 'move'
            evt.dataTransfer.setData('memberId', member.id)
        },
        onDrop(evt, task) {
            const memberId = evt.dataTransfer.getData('memberId')
            const member = this.members.find((member) => member.id == memberId)
            task.member = member
        },
    }
}
</script>

<style scoped>
.container {
    padding-top: 100px;
    min-height: 100vh;
    position: relative;
}

.project {
    width: 420px;
    border-radius: 20px;
    background: #23242F;
}

.fab-btn {
    width: 100%;
    display: flex;
    justify-content: flex-end;
    position: fixed;
    right: 5%;
    bottom: 5%;
}

.fab {
    margin-top: 40px;
    z-index: 20px;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    color: #0177fb;
    background: #FFFFFF;
    font-size: 35px;
    cursor: pointer;
    box-shadow: 0 4px 10px #ffffffb0;
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

.detail {
    padding: 30px;
    padding-top: 100px;
    color: #FFFFFF;
    user-select: none;
}

.detail img {
    width: 60px;
    height: 60px;
    border-radius: 20px;
    object-fit: cover;
}

.detail h3 {
    font-size: 35px;
    font-weight: 600;
    margin-top: 10px;
}

.detail p {
    font-size: 16px;
    margin-top: 10px;
    opacity: 0.8;
}

.grid {
    display: grid;
    grid-template-columns: auto 400px;
    column-gap: 40px;
}

.tasks {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
    padding: 60px 0;
}

.task {
    width: 350px;
    background: #23242F;
    overflow: hidden;
    border-radius: 20px;
    height: fit-content;
    color: #fff;
}

.task .title {
    padding: 30px;
    padding-bottom: 15px;
    background: #2C2D3A;
}

.task .title h3 {
    font-size: 24px;
    font-family: 'Poppins', sans-serif;
}

.task .reward {
    font-size: 14px;
    margin-top: 6px;
}

.member {
    display: grid;
    gap: 16px;
    align-items: center;
    grid-template-columns: 40px auto;
}

.task .member {
    grid-template-columns: 40px auto 24px;
}

.member i {
    background: #b10202;
    border-radius: 20px;
    font-size: 14px;
    width: 24px;
    cursor: pointer;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.member .tag {
    background: #FF6370;
    border-radius: 6px;
    font-size: 14px;
    width: fit-content;
    margin-top: 6px;
    color: #2C2D3A;
    padding: 3px 10px;
}

.task .member {
    padding: 40px 30px;
}

.member h3 {
    font-size: 16px;
}

.member img {
    width: 40px;
    height: 40px;
    object-fit: cover;
    border-radius: 20px;
    cursor: pointer;
}

.task .action {
    background: linear-gradient(90deg, #4b87f6 -43.68%, #3451f3 72.76%);
    height: 50px;
    border-radius: 20px;
    margin: 20px;
    margin-top: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    cursor: pointer;
    user-select: none;
}

.members {
    border-left: 1px rgb(201, 227, 255) solid;
    height: calc(100vh - 100px);
    position: sticky;
    top: 100px;
    padding: 20px 40px;
    padding-right: 0;
    color: #fff;
}

.members .desc {
    font-size: 16px;
    width: 100%;
    font-weight: 600;
    padding: 16px;
    border-radius: 10px;
    background: rgb(34, 114, 200);
    background-image: url("https://app.idle.finance/images/bg-noise.png");
}

.members .member {
    cursor: grab;
}

.member-con p {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 50px 30px;
    width: 100%;
    height: 100%;
}

.members .list {
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 30px;
}
</style>
