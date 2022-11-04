/* contracts */
const MessageSender = artifacts.require("MessageSender");
const Message = artifacts.require("Message")

/* AXELAR */
const fantomGateWay = "0x97837985Ec0494E7b9C71f5D3f9250188477ae14";
const fantomGasReceiver = "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6";
const destinationName = "binance";
const destinationAddress = "";

/* AXELAR fantom testnet contract */
module.exports = async function(deployer) {
    await deployer.deploy(
        MessageSender,
        fantomGateWay,
        fantomGasReceiver,
        destinationName,
        destinationAddress
    );
};
