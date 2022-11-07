/* contracts */
const MessageSender = artifacts.require("MessageSender");
const Message = artifacts.require("Message")

/* AXELAR */
const mumbaiGateway = "0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B";
const mumbaiGasReceiver = "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6";
const destinationName = "binance";
const destinationAddress = "0x699BF53075806AA905c93D840517d8382D3E8e2C";

/* AXELAR polygon mumbai contract */
module.exports = async function(deployer) {
    await deployer.deploy(Message)
    deployer.link(Message, MessageSender)

    await deployer.deploy(
        MessageSender,
        mumbaiGateway,
        mumbaiGasReceiver,
        destinationName,
        destinationAddress
    );
};