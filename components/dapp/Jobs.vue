<template>
<div class="container">
    <div class="jobs" v-if="jobs.length > 0">
        <div class="job" v-for="job in jobs" :key="job.id"></div>
    </div>
    <div class="explain">
        <h3>No jobs found!</h3>
        <p>
            Here is where you will receive your job invites or jobs to have applied for. <br> <br>
            Your jobs applications is only private to you and the job creator.
        </p>
        <div class="action">
            Click on the <i class="fa-solid fa-magnifying-glass"></i> button to create your first job.
        </div>
    </div>

    <div class="fab-btn">
        <router-link to="/explore/jobs">
            <div class="fab">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
        </router-link>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            jobs: []
        }
    }
}
</script>

<style scoped>
.container {
    padding-top: 160px;
    padding-bottom: 50px;
    min-height: 100vh;
    position: relative;
}

.jobs {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
}

.job {
    width: 420px;
    height: 280px;
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
</style>
