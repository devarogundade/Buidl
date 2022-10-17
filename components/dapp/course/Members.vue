<template>
<div class="container">
    <div class="members" v-if="members.length > 0">

    </div>
    <div class="explain" v-else>
        <h3>No member</h3>
        <p>
           Invite your team members to join this project or <a href="/explore/talents">explore</a> to find creative minds like.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-plus"></i> button to invite your team member.
        </div>
    </div>
    <div class="fab-btn" v-on:click="$nuxt.$emit('invite-member', 1)">
        <div class="fab">
            <i class="fa-solid fa-plus"></i>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            members: []
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 100px;
    min-height: 100vh;
    position: relative;
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
</style>
