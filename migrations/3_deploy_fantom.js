/* contracts */
const MessageSender = artifacts.require("MessageSender");
const Message = artifacts.require("Message")

/* AXELAR */
const fantomGateway = "0x97837985Ec0494E7b9C71f5D3f9250188477ae14";
const fantomReceiver = "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6";
const destinationName = "binance";
const destinationAddress = "0x82aC7E9F2f81D70618D688Bab1F83847E64D7667";

/* AXELAR fantom contract */
module.exports = async function(deployer) {
    await deployer.deploy(Message)
    deployer.link(Message, MessageSender)

    await deployer.deploy(
        MessageSender,
        fantomGateway,
        fantomReceiver,
        destinationName,
        destinationAddress
    );
};
