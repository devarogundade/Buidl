<template>
<section>
    <div class="app-width">
        <div class="container">
            <div class="filter"></div>
            <div class="feeds">
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
                <div class="feed"></div>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
.app-width {
    width: 1200px;
}

.container {
    display: grid;
    grid-template-columns: 400px auto;
    column-gap: 40px;
}

.filter {
    height: 700px;
    border-radius: 30px;
    background: #23242F;
    position: sticky;
    top: 140px;
}

.feeds {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
}

.feed {
    width: 100%;
    height: 500px;
    border-radius: 30px;
    background: #23242F;
    border-radius: 24px;
    padding: 30px;
}
</style>
