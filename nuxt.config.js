export default {
    ssr: false,

    target: 'static',

    env: {
        INFURA_KRY: process.env.INFURA_KRY,
        MORALIS_KEY: process.env.MORALIS_KEY
    },


    head: {
        title: 'Buidl - SocialFi of Instructors and Students',
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
        script: [{
                src: "https://kit.fontawesome.com/19ee52fe0f.js",
                crossorigin: "anonymous"
            },
            {
                src: 'https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js',
                defer: true
            }
        ]
    },

    css: [
        '@/static/common.css'
    ],

    plugins: [
        '@/plugins/auth.js',
        '@/plugins/contracts.js',
        '@/plugins/moralis-apis/ipfs.js',
        '@/plugins/moralis-apis/nft.js',
        '@/plugins/moralis-apis/token.js',
    ],

    components: {
        dirs: [
            '~/components',
            '~/components/landing',
            '~/components/dapp',
            '~/components/dapp/course',
            '~/components/dapp/token',
            '~/components/dapp/tools',
            '~/components/explore',
            '~/components/collectibles',
            '~/components/dialogs'
        ]
    },
    buildModules: [],

    modules: [
        '@nuxtjs/axios',
    ],

    axios: {
        baseURL: 'https://deep-index.moralis.io/api/v2/', // moralis base url
    },

    build: {}
}