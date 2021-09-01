const itemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", accounts => {
    it("... should be able to add an item", async function(){
        //similar to a web3 instance but now it gives back a truffle contract.
        const itemManagerInstance = await itemManager.deployed(); 
        const itemName = "test1";
        const itemPrice = 500;

        const result = await itemManagerInstance.createItem(itemName, itemPrice, {from: accounts[0]});
        assert.equal(result.logs[0].args._itemIndex, 0, "It's not the first item");

        const item = await itemManagerInstance.items(0);
        assert.equal(item._identifier, itemName, "The identifier was different")

    })
});