const BdlToken = artifacts.require("BdlToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");
const Staking = artifacts.require("Staking");
const BdlCourse = artifacts.require("BdlCourse");

module.exports = async function(deployer) {
    // await deployer.deploy(Staking);
    await deployer.deploy(BdlCourse);
    // await deployer.deploy(BdlToken, "Buidl Token", "BDL");
    // await deployer.deploy(BdlNft, "Buidl Monkeys", "BMON");
    // await deployer.deploy(BdlCertificate, "Buidl Certificate", "BCRT");

    // await deployer.deploy(Buidl,
    //     BdlToken.address,
    //     BdlNft.address,
    //     BdlCertificate.address,
    //     BdlCourse.address,
    //     Staking.address
    // );
};
