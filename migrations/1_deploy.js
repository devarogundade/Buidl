const BdlToken = artifacts.require("BdlToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");
const PaymentFlow = artifacts.require("PaymentFlow");

module.exports = async function(deployer) {
    await deployer.deploy(BdlNft);
    await deployer.deploy(BdlCertificate);
    await deployer.deploy(BdlToken, "0xEB796bdb90fFA0f28255275e16936D25d3418603");
    await deployer.deploy(PaymentFlow, "0xEB796bdb90fFA0f28255275e16936D25d3418603", BdlToken.address);
    await deployer.deploy(Buidl, BdlToken.address, BdlNft.address, BdlCertificate.address, PaymentFlow.address);
};