<template>
<section>
    <div class="app-width">
        <div class="course">
            <div class="head">
                <div class="wrapper">
                    <div class="tree">
                        <router-link to="/">
                            <p>Web Development</p>
                        </router-link>
                        <i class="fa-solid fa-chevron-right"></i>
                        <p>JavaScript</p>
                    </div>
                    <h3 class="title">The Complete JavaScript Course 2022: From Zero to Expert!</h3>
                    <p class="subtitle">The modern JavaScript course for everyone! Master JavaScript with projects, challenges and theory. Many courses in one!</p>
                </div>
            </div>

            <div class="body">
                <div class="grid">
                    <div class="detail"></div>
                    <div class="buy"></div>
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
.course {
    padding-top: 100px;
    padding-bottom: 100px;
}

.head {
    height: 400px;
    width: 100%;
    background-image: linear-gradient(to top, #09203f 0%, #537895 100%);
    padding: 40px;
}

.wrapper {
    width: 1000px;
    max-width: 100%;
}

.tree {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #000000;
    font-size: 16px;
}

.tree a {
    color: #000000;
    text-decoration: underline;
}

.tree i {
    font-size: 12px;
}

.title {
    color: #FFFFFF;
    margin-top: 20px;
    font-size: 40px;
}

.subtitle {
    color: #FFFFFF;
    opacity: 0.8;
    margin-top: 20px;
    font-size: 20px;
    width: 800px;
    max-width: 100%;
}

.grid {
    margin-top: 40px;
    display: flex;
    justify-content: space-between;
    gap: 40px;
    position: relative;
}

.detail {
    width: 1000px;
    height: 150vh;
}

.buy {
    height: 60vh;
    width: 400px;
    background: #2C2D3A;
    position: absolute;
    right: 40px;
    top: -400px;
    border-radius: 10px;
}
</style>
