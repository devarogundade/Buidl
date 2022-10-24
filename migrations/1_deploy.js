const BdlToken = artifacts.require("BdlToken");
const BdlNft = artifacts.require("BdlNft");
const BdlCertificate = artifacts.require("BdlCertificate");
const Buidl = artifacts.require("Buidl");
const PaymentFlow = artifacts.require("PaymentFlow");
const Staking = artifacts.require("Staking");

module.exports = async function(deployer) {
    await deployer.deploy(BdlNft, "Buidl Monkeys", "BMON");
    await deployer.deploy(BdlCertificate, "Buidl Certificate", "BCRT");
    await deployer.deploy(Staking);

    const token = await deployer.deploy(BdlToken, "0xEB796bdb90fFA0f28255275e16936D25d3418603");
    await token.initialize(
        "0x0000000000000000000000000000000000000000",
        18,
        "BDL Token",
        "BDL"
    );

    await deployer.deploy(PaymentFlow, BdlToken.address);
    await deployer.deploy(Buidl,
        BdlToken.address,
        BdlNft.address,
        BdlCertificate.address,
        PaymentFlow.address,
        Staking.address
    );
};
