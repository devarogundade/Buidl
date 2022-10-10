<template>
<div class="container">
    <div class="projects">
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
        <div class="project"></div>
    </div>
</div>
</template>

<style scoped>
.container {
    padding: 40px;
}

.projects {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
}

.project {
    width: 300px;
    height: 280px;
    border-radius: 20px;
    background: #23242F;
}
</style>
