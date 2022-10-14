<template>
<section id="faqs">
    <div class="app-width">
        <h3>Frequently Asked Questions</h3>
        <div class="items">
            <div v-for="(faq, index) in faqs" :key="faq.question" :class="show == index ? 'show item' : 'item'">
                <div class="question" v-on:click="openFaq(index)">
                    <p>{{ faq.question }}</p>
                    <div class="handle">
                        <div></div>
                        <div></div>
                    </div>
                </div>
                <div class="answer">
                    <p>{{ faq.answer }}</p>
                </div>
            </div>
        </div>
    </div>
</section>
</template>

<script>
export default {
    data() {
        return {
            show: -1,
            faqs: [{
                    question: 'When can I buy Lucky Cats tokens?',
                    answer: 'You will be able to buy Lucky Cats tokens on the 27th of September 2022 at Public fair Launch.'
                },
                {
                    question: 'Where can I buy Lucky Cats token?',
                    answer: 'You can buy Lucky Cats on Gempad on the 27th of September 2022 during Fair launch.'
                }, {
                    question: 'What is the contract address?',
                    answer: 'Contract address is 0x683bbaa70fd8e2cf62617e48b100a7609ee48946.'
                }, {
                    question: 'What slippage should I use?',
                    answer: 'We recommend going with 5% slippage, the slippage tax deduction will feed our jackpot pools and our liquidity.'
                }
            ]
        }
    },
    methods: {
        openFaq(index) {
            if (this.show == index) {
                this.show = -1
            } else {
                this.show = index
            }
        }
    }
}
</script>

<style scoped>
section {
    padding-top: 200px;
    padding-bottom: 50px;
}

section h3 {
    font-size: 40px;
    color: #FFFFFF;
    text-align: center;
}

.items {
    margin-top: 80px;
    display: flex;
    flex-direction: column;
    align-items: center;
    row-gap: 20px;
    will-change: auto;
}

.item {
    width: 900px;
    max-width: 100%;
    border: 4px solid #04215c;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.question {
    height: 100px;
    width: 100%;
    display: grid;
    grid-template-columns: auto 30px;
    column-gap: 10px;
    align-items: center;
    padding: 0 40px;
    cursor: pointer;
}

.question p {
    font-weight: bold;
    font-size: 20px;
    line-height: 20px;
    letter-spacing: 0.02em;
    color: #F9F6ED;
    transition: .4s;
}

.show .question p {
    color: #FF6370;
}

.answer {
    height: 0;
    transition: .4s;
    padding-left: 40px;
    padding-right: 40px;
    will-change: auto;
}

.show .answer {
    padding-bottom: 40px;
    height: fit-content !important;
}

.answer p {
    font-weight: 400;
    font-size: 20px;
    line-height: 40px;
    letter-spacing: 0.02em;
    color: rgba(255, 255, 255, 0.8);
    transition: .4s;
}

.handle {
    width: 24px;
    height: 24px;
    position: relative;
}

.handle div:first-child {
    position: absolute;
    background: #FFFFFF;
    width: 100%;
    height: 4px;
    border-radius: 2px;
    top: 10px;
    left: 0;
    transition: .4s;
}

.handle div:last-child {
    position: absolute;
    background: #FFFFFF;
    width: 4px;
    height: 100%;
    border-radius: 2px;
    top: 0;
    left: 10px;
    transition: .4s;
}

.show .handle div:last-child {
    transform: rotate(-90deg);
}

.show .handle div {
    background: #FF6370;
}

@media screen and (max-width: 700px) {
    .items {
        margin-top: 60px;
    }

    .question {
        padding: 0 20px;
        height: 90px;
    }

    .question p {
        font-size: 18px;
        line-height: 27px;
    }

    .answer p {
        font-size: 18px;
        line-height: 36px;
    }

    .answer {
        padding-left: 20px;
        padding-right: 20px;
    }

    .show .answer {
        padding-bottom: 20px;
    }
}
</style>
