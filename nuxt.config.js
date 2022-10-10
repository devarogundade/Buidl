export default {
    ssr: false,

    target: 'static',

    env: {
        INFURA_KRY: process.env.INFURA_KRY,
    },


    head: {
        title: 'Buidl - SocialFi for Professionals',
        htmlAttrs: {
            lang: 'en'
        },
        meta: [
            { charset: 'utf-8' },
            { name: 'viewport', content: 'width=device-width, initial-scale=1' },
            { hid: 'description', name: 'description', content: '' },
            { name: 'format-detection', content: 'telephone=no' }
        ],
        link: [
            { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
            {
                rel: "stylesheet",
                href: "https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
            }
        ],
        script: [
            { src: "https://kit.fontawesome.com/19ee52fe0f.js", crossorigin: "anonymous" },
            { src: 'https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js', defer: true }
        ]
    },

    css: [
        '@/static/common.css'
    ],

    plugins: ['@/plugins/contracts.js', '@/plugins/auth.js'],

    components: {
        dirs: [
            '~/components',
            '~/components/landing',
            '~/components/dapp',
            '~/components/explore',
            '~/components/collectibles',
        ]
    },
    buildModules: [],

    modules: [
        '@nuxtjs/axios',
    ],

    axios: {
        baseURL: '/',
    },

    build: {}
}
