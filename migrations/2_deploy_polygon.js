const Executable = artifacts.require("Executable");

/* axelar polygon mumbai contract */
module.exports = async function(deployer) {
    await deployer.deploy(
        Executable,
        "0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B",
        "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6"
    );
};
