# Buidl - SocialFi for Creators and Learners
## _A Moralis X Google Cloud Hackathon Project_

Buidl is a Social-Fi Decentralized Autonomous Organization for content creators (e.g instructors, youtubers, DIY makers, etc) basically anyone that shares their skills with other people online either for free or at a particular cost.

Today, there are various existing Web2 solutions for this particular aspect, but we are taking it further leveraging on the blockchain technology to provide a more secured, learning incentives and ownership to the community.

To become a creator on the buidl platform requires a minimum stake of 2000 BDL tokens for a minimum duration of one year, if staking is withdrawn after one year the user is not a creator anymore unstill they restake a minimum of 2000 BDL back.
A creator with suspicious activities and high report rate will be banned and their stake is locked in the smart contract, this features helps us maintain a safe community as a DAO (Decentralized Autonomous Organization).

We have heavily used moralis stream and smart contract events, which had help us maintain a very low gas cost on the platform.

## Core Features
- # Incentives for learning
    Non creators(i.e learners) cover the largest base of the platform size, it's a crucial part of the platform to motivate and reward learners to use.....
    On each every premium content a user purchase on the platform, given that they completed learning the content a Buidl NFT will be minted for them based on the content price. Click here to read more about the Buidl NFT
    
- # Cryptocurrency payment and Guaranteed refund system using DEFI Staking protocol
    The Buidl Token(BDL) is the only payment method of the platform, which can be available on DEX and CEX, cryptocurrency has given us the ability to ensure a guaranteed refund policy compared to web2 where it's complex to refund back through the channel funds was charged.
    Whenever a content is purchased on the platform, the tokens are staked in the smart contract, and released to the creator after two weeks. Learners are able to create a refund and instantly received back their tokens with deduction of the sections of the content consumed already.

- # On-chain certificate (ERC4973)
    Account Bound Certificate that is it cannot be transferred between addresses like normal Erc20 or Erc721. Creators can set quiz(exam) for each content they create and also mint a Account Bound certificate for subscribers(learners).

- # IPFS and On-chain encryption for premium contents
    Encrypting video chunks to IPFS and storing the keys on chain is how we have managed to protect premium contents on the platform, only the content subscribers account can retrieve the key to decrypt the video chunks.
    Protecting videos online is not 100% achievable, as it can still be recorded from the device's screen.
    The Buidl Video Player is a product we have added on your roadmap, which simplify authenticates users with their wallet and s

## Supported Media Types
  In this hackathon scope the platfoem only supports free or premium video contents.

## Products
 - # Buidl Token
  
 - # Buidl Certificate
     
-  # Buidl NFT
  
-  # Buidl Video Player

## Hackathon Track
  Binance Smart Chain => Social & Entertainment

## Tech Stacks

- Binance Smart Chain (Testnet)
- Moralis Stream and Web3 APIs
- IPFS (File System)
- Solidity (Smart Contract)
- Nuxtjs (Frontend)
- Laravel (Backend)
- Truffle
- Covalent APIs

## Demo

- See mode at https://buidl.netflify.app/
- Buidl Token Faucet https://buidl.netlify.app/mint

To see demo locally, clone the repo.

```sh
cd buidl
npm install
truffle migrate --network=development
npm run dev
http://localhost:3000/
```

## Screenshots

## Roadmap
   https://buidl.netlify.app/#roadmap

## Plugins

| Plugin | Installation |
| ------ | ------ |
| Axios |  |
| Tiny |  |
| HD Wallet Provider |  |
| Coinbase SDK |  |
| Walletconnect SDK |  |
| Truffle Contract |  |
| Moralis |  |
| Vue |  |

## Development

Want to contribute? Great!

=================

Open your favorite Terminal and run these commands.

## License

MIT
