/* contracts */
const BdlToken = artifacts.require("BdlToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");
const Staking = artifacts.require("Staking");
const BdlCourse = artifacts.require("BdlCourse");
const Base64 = artifacts.require("Base64")
const Message = artifacts.require("Message")

/* AXELAR */
const binanceGateway = "0x4D147dCb984e6affEEC47e44293DA442580A3Ec0";

/* binance smart chain testnet */
module.exports = async function(deployer) {
    await deployer.deploy(Base64)
    deployer.link(Base64, Buidl)

    await deployer.deploy(Message)
    deployer.link(Message, Buidl)

    await deployer.deploy(Staking);
    await deployer.deploy(BdlToken, "Buidl Token", "BDL");
    await deployer.deploy(BdlCourse);
    await deployer.deploy(BdlNft, "Buidl Monkeys", "BMON");
    await deployer.deploy(BdlCertificate, "Buidl Certificate", "BCRT");



    await deployer.deploy(Buidl,
        BdlToken.address,
        BdlNft.address,
        BdlCertificate.address,
        BdlCourse.address,
        Staking.address,
        binanceGateway
    );
};
