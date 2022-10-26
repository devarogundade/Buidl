// const BdlToken = artifacts.require("BdlToken");
const BdlTestToken = artifacts.require("BdlTestToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");
// const PaymentFlow = artifacts.require("PaymentFlow");
const Staking = artifacts.require("Staking");
const BdlCourse = artifacts.require("BdlCourse");

module.exports = async function(deployer) {
    // await deployer.deploy(Staking);
    await deployer.deploy(BdlCourse);
    // await deployer.deploy(BdlTestToken, "Buidl Token", "BDL");
    // await deployer.deploy(BdlNft, "Buidl Monkeys", "BMON");
    // await deployer.deploy(BdlCertificate, "Buidl Certificate", "BCRT");

    // const token = await deployer.deploy(BdlToken, "0xEB796bdb90fFA0f28255275e16936D25d3418603");
    // await token.initialize(
    //     "0x0000000000000000000000000000000000000000",
    //     18,
    //     "BDL Token",
    //     "BDL"
    // );

    // await token.approve(BdlToken.address, "0x27B70BB58bB73373AFeDDF9da6A8534650e9941b", 1000000000000000);
    // await token.transferFrom(BdlToken.address, "0x27B70BB58bB73373AFeDDF9da6A8534650e9941b", 1000000000000000);

    // await deployer.deploy(PaymentFlow, BdlToken.address);

    // await deployer.deploy(Buidl,
    //     BdlTestToken.address,
    //     BdlNft.address,
    //     BdlCertificate.address,
    //     // PaymentFlow.address,
    //     BdlCourse.address,
    //     Staking.address
    // );
};
