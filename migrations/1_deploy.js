const BdlToken = artifacts.require("BdlToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");

module.exports = async function(deployer) {
    await deployer.deploy(BdlToken);
    await deployer.deploy(BdlNft);
    await deployer.deploy(BdlCertificate);
    await deployer.deploy(Buidl, BdlToken.address, BdlNft.address, BdlCertificate.address);
};