const Executable = artifacts.require("Executable");

/* axelar fantom testnet contract */
module.exports = async function(deployer) {
    await deployer.deploy(
        Executable,
        "0x97837985Ec0494E7b9C71f5D3f9250188477ae14",
        "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6"
    );
};
