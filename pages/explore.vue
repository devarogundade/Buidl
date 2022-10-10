<template>
<div class="explore">
    <div class="bg"><img src="https://app.idle.finance/images/ellipse-topleft.svg" alt=""></div>
    <div class="bg2"><img src="https://app.idle.finance/images/ellipse-bottomright.svg" alt=""></div>
    <ExploreHero />
    <Feeds v-show="tab == 1" />
    <Talents v-show="tab == 2" />
</div>
</template>

<script>
export default {
    layout: 'explore',
    mounted() {
        $nuxt.$on('explore-tab', (tab) => {
            this.tab = tab
        })
    },
    data() {
        return {
            tab: 1
        }
    }
}
</script>

<style>
.bg {
    position: fixed;
    left: 0;
    top: 0;
    width: 600px;
    opacity: 0.5;
    z-index: -1;
}

.bg img {
    width: 100%;
}

.bg2 {
    position: fixed;
    right: -100px;
    bottom: 0;
    width: 600px;
    opacity: 0.5;
    rotate: 90deg;
    z-index: -1;
}

.bg2 img {
    width: 100%;
}
</style>
