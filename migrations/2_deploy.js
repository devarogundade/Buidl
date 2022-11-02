const Executable = artifacts.require("Executable");

module.exports = async function(deployer) {
    await deployer.deploy(Executable, "0x4D147dCb984e6affEEC47e44293DA442580A3Ec0", "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6");
};
