const BdlToken = artifacts.require("BdlToken");
const Talent = artifacts.require("Talent");
const User = artifacts.require("User");

module.exports = async function(deployer) {
    await deployer.deploy(BdlToken);
    await deployer.deploy(Talent);
    await deployer.deploy(User, BdlToken.address);
};