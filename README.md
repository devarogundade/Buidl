# Buidl - SocialFi for Creators and Learners
## _A Moralis X Google Cloud Hackathon Project_

Buidl is a Social-Fi and Decentralized Autonomous Organization (DAO) for content creators (e.g instructors, YouTubers, DIY makers, etc) anyone that shares their skills with other people online either for free or at a particular cost.

Today, there are various existing Web2 solutions for this particular aspect, but we are taking it further leveraging blockchain technology to provide more secured, learning incentives with ownership to the community pattern.

To become a creator on the buidl platform requires a minimum stake of 2000 BDL tokens for a minimum duration of one year, if staking is withdrawn after one year the user is not a creator anymore until they restake a minimum of 2000 BDL back in the contract.
A creator with suspicious activities and a high report rate is subjected to ban and their staked BDL token remains locked in the smart contract, this feature helps us maintain the DAO a safe community.

We have heavily used moralis stream and smart contract events, which has helped us maintain a very low gas cost on the platform, and also introduce alternative gas options like $MATIC & $FANTOM with the help of Axelar a cross chain messaging protocol.

## Core Features
- # Incentives for learning
    Non-creators (i.e learners) will cover the largest base of the platform, it's a crucial part of the platform encourage and reward learners to retain them to use and enjoy the platform. 
   
    On each and every content (free/premium) a user purchases on the platform, given that they completed learning from the content a Buidl NFT will be minted for them based on the content price.
    
    The Buidl NFT serves as a coupon(discount) on premium contents, each nft has a weight property which ranges from 0 ~ 50, this weight property is the percentage of the nft discount on a course.
    
    The NFT can be traded in exchange for cryptocurrency to other users on marketplaces like Opensea.io
    
- # Cryptocurrency payment and Guaranteed refund system using Staking protocol
    The Buidl Token(BDL) is the only payment method of the platform, which will be available on DEX and CEX, cryptocurrency has given us the ability to ensure a guaranteed & instant refund policy compared to web2 where it's complex and slow to refund back through the channel the money was charged.
    
    Whenever content is purchased on the platform, the tokens are staked in the smart contract, and released to the creator after two weeks. Learners can create a  refund and instantly receive back their tokens with a deduction of the sections of the content consumed already.

- # Account Bound Certificate (ERC4973)
    Account Bound Certificate that is it cannot be transferred between addresses like normal Erc20 or Erc721. Creators can set quizzes (exams) for each content they create and also mint an Account Bound certificate for subscribers(learners).
    
    On-chain certificates generatees the true ownership of the certificate, and can also be verified on the buidl explorer page by looking up for the cerfiticate hash.

- # IPFS and On-chain encryption for premium contents
    We are encrypting video chunks to IPFS and storing the keys in the smart contract, this is how we have managed to protect premium contents on the platform, only the content subscribers account can retrieve the key to decrypt the video chunks.
    
    Protecting videos online is not 100% achievable, as it can still be recorded from the device's screen.
    
    The Buidl Video Player is a product we have added on your roadmap, which simply authenticates users with their wallet, interacts with our smart contracts to decrypt and play the encryted downloaded video (.bdl video file) on the device.

## Revenue Model
- We charge a 8% service fee from every earnings from the creators.

## Supported Media Types
  Video contents.

## Products
- # Buidl Token (ERC20)

  Use case: Payment, Refund and Staking.
  
- # Buidl Certificate (ERC4973)

  Use case: On-Chain Course Certification.
     
- # Buidl NFT (ERC721)
- Use case: Rewards and Coupon (discount).

![Screenshot 2022-10-31 155800](https://user-images.githubusercontent.com/81397790/199039025-80a5e274-222c-4a10-90f0-0b655973033a.png)
  
- # Buidl Video Player
- Use case: .bdl file extension video player.

![Group 133 (2)](https://user-images.githubusercontent.com/81397790/199038576-06daf10b-f865-44c6-84c2-b64c8a160c0f.png)

## Hackathon Track
  Binance Smart Chain => Social & Entertainment
  
## Hackathon Bounty
  Axelar

## Tech Stacks

- Binance Smart Chain (Testnet)
- Moralis Stream [#](https://github.com/devarogundade/Buidl/tree/master/plugins/moralis-api) and Web3 APIs [#](https://github.com/devarogundade/Buidl/tree/master/moralis-stream-api)
- IPFS (File System) [#](https://github.com/devarogundade/Buidl/tree/master/plugins/moralis-apis/ipfs.js)
- Solidity (Smart Contract) [#](https://github.com/devarogundade/Buidl/tree/master/contracts)
- Nuxtjs (Frontend)
- Nodejs (Backend) 
- Truffle
- Axelar (Cross Chain Messaging) [#](https://github.com/devarogundade/Buidl/tree/master/contracts/axelar)
- Google Cloud Firebase [#](https://github.com/devarogundade/Buidl/tree/master/plugins/firestore.js)

## Demo

- See mode at https://buidl.netflify.app/
- Buidl Token Faucet https://buidl.netlify.app/mint

## Screenshots
![Screenshot 2022-11-01 064225](https://user-images.githubusercontent.com/81397790/199166950-fc271011-4f1b-4228-a68e-5662bdd3e5e7.png)
![Screenshot 2022-11-01 064520](https://user-images.githubusercontent.com/81397790/199167156-b1843670-e5a9-4c3e-a3a2-623ad833c2c5.png)

## Other Services
- Netlify
- Heroku

## Roadmap
   https://buidl.netlify.app/#roadmap

## Tokenomics
   https://buidl.netlify.app/#bdl-token

## Contribution

Want to contribute? Great!

Reach out to me at https://linktr.ee/devarogundade

## Team
- Arogundade Ibrahim

## License

MIT
