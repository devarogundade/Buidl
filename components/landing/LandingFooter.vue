<template>
<section>
    <div class="app-width">
        <div class="footer">
            <div class="logo">
                <img src="/images/logo.png" alt="">
            </div>
            <div class="links">
                <router-link to="/bdl-token">BDL Token</router-link>
                <a href="/bdl-token">Moralis x Google Hackathon</a>
            </div>
            <div class="socials">
                <!-- <a href="https://twitter.com/devarogundade" target="_blank"><i class="fa-brands fa-twitter"></i></a> -->
                <a href="https://github.com/devarogundade/Buidl" target="_blank"><i class="fa-brands fa-github"></i></a>
            </div>
        </div>
    </div>
</section>
</template>

<style scoped>
section {
    padding: 40px 0;
    background: rgb(0, 11, 61);
}

.footer {
    display: grid;
    grid-template-columns: 150px auto 150px;
    gap: 40px;
    height: 50px;
    align-items: center;
}

.logo img {
    height: 35px;
}

.links {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 40px;
}

.links a {
    font-size: 20px;
    font-weight: 500;
    color: #fff;
}

.socials {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 40px;
}

.socials i {
  font-size: 30px;
  color: #fff;
}
</style>
