<template>
<section>
    <div class="app-width">
        <div class="container">
            <div class="filter"></div>
            <div class="feeds">
                <div class="feed" v-for="index in 50" :key="index">
                    <div class="user">
                        <div class="image">
                            <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                        </div>
                        <div class="profile">
                            <h3>Arogundade Ibrahim</h3>
                            <p>@devarogundade</p>
                        </div>
                        <div class="follow">Follow</div>
                    </div>
                    <div class="post">
                        <div class="photo">
                            <p class="message">This is how I alway charge for my service.</p>
                            <img src="https://media.istockphoto.com/photos/modern-office-black-businesswoman-sitting-at-her-desk-working-on-a-picture-id1365824279?b=1&k=20&m=1365824279&s=170667a&w=0&h=3_YJ2lSlaQhoEgoroJ5E8PzwHFnyEKWZBHc_ZtTb1QY=" alt="">
                        </div>
                    </div>
                    <div class="options">
                        <div>
                            <p><i class="fa-solid fa-heart"></i> 10</p>
                            <p><i class="fa-solid fa-comment"></i> 4</p>
                            <p><i class="fa-solid fa-share-nodes"></i></p>
                        </div>
                        <div>
                            <p> <i class="fa-solid fa-dollar-sign"></i> <span>tip</span></p>
                            <div class="tip">
                                <div class="grid">
                                    <p>1 BDL</p>
                                    <p>4 BDL</p>
                                    <p>10 BDL</p>
                                </div>
                                <div class="send">Send</div>
                            </div>
                        </div>
                    </div>
                </div>
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
    grid-template-columns: 220px auto;
    column-gap: 40px;
}

.filter {
    height: 700px;
    border-radius: 30px;
    background: #23242F;
    position: sticky;
    top: 30px;
}

.feeds {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
}

.feed {
    width: 100%;
    max-width: 450px;
    background: #ffffff25;
    overflow: hidden;
    border-radius: 24px;
    backdrop-filter: blur(20px);
}

.user {
    padding: 20px;
    color: #fff;
    display: grid;
    grid-template-columns: 50px auto auto;
    gap: 16px;
    align-items: center;
}

.user h3 {
    font-size: 18px;
}

.user p {
    font-size: 16px;
    opacity: 0.8;
}

.user .image {
    width: 50px;
    height: 50px;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 4px 4px 0 #0176fb2a;
}

.user .image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.user .follow {
    height: 35px;
    padding: 0 20px;
    border-radius: 6px;
    background: #235effb6;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    color: #fff;
    cursor: pointer;
    user-select: none;
}

.post {
    width: 100%;
}

.photo {
    width: 100%;
    height: 300px;
    position: relative;
}

.message {
    position: absolute;
    padding: 14px 20px;
    bottom: 0;
    left: 0;
    width: 100%;
    background: #1d235fce;
    color: #fff;
    font-size: 16px;
    line-height: 24px;
    backdrop-filter: blur(20px);
}

.photo img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.options {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
}

.options div {
    display: flex;
    gap: 26px;
    color: #fff;
}

.options p {
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 22px;
    cursor: pointer;
    user-select: none;
}

.options i {
    padding: 4px 0;
}

.options span {
    padding: 2px 4px;
    border-radius: 6px;
    background: #1d225f;
    border: 1px #fff solid;
    font-size: 20px;
}

.options>div:last-child {
    position: relative;
}

.options>div:last-child:hover .tip {
    bottom: 0;
}

.tip {
    background: #23242F;
    position: absolute;
    bottom: -200px;
    right: 0;
    width: 240px;
    border-radius: 16px;
    display: flex;
    flex-direction: column;
    padding: 20px;
}

.tip .grid {
    display: grid;
    height: 35px;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 10px;
}

.tip .grid p {
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 14px;
    border: 1px #4F5069 solid;
    border-radius: 6px;
}

.tip .send {
    width: 100%;
    height: 40px;
    background: #0177fb;
    border-radius: 6px;
    display: flex;
    align-items: center;
    color: #FFFFFF;
    font-size: 16px;
    font-family: 'regular';
    font-weight: 600;
    justify-content: center;
    cursor: pointer;
    user-select: none;
}
</style>
