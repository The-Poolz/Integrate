const ThePoolz = artifacts.require("ThePoolz");
const Token = artifacts.require("Token");
const WhiteList = artifacts.require("WhiteList");
const WhiteListConvertor = artifacts.require("WhiteListConvertor");
const { assert } = require("chai");
const truffleAssert = require("truffle-assertions");
const constants = require("@openzeppelin/test-helpers/src/constants");
const BN = web3.utils.BN;

contract("Integration Between PoolzBack and WhiteListConvertor", (accounts) => {
  let poolzBack,
    testToken,
    whiteList,
    firstAddress = accounts[0];
  let whiteListConvertor,
    secondAddress = accounts[1];
  let whiteListId, ethPoolId;

  before(async () => {
    poolzBack = await ThePoolz.deployed();
    whiteList = await WhiteList.deployed();
    whiteListConvertor = await WhiteListConvertor.new(whiteList.address);
    testToken = await Token.new("TestToken", "TEST", { from: firstAddress });
  });

  it("should create white list", async () => {
    const now = Date.now() / 1000; // current timestamp in seconds
    const timestamp = Number(now.toFixed()) + 3600; // timestamp one hour from now
    const whiteListCost = web3.utils.toWei("0.01", "ether");
    await whiteList.CreateManualWhiteList(
      timestamp,
      whiteListConvertor.address,
      { from: firstAddress, value: whiteListCost }
    );
    whiteListId = ((await whiteList.WhiteListCount()) - 1).toString();
    assert.equal(whiteListId, "1");
  });

  it("should create new pool with ETH as Main Coin", async () => {
    const date = new Date();
    date.setDate(date.getDate() + 1); // add a day
    const future = Math.floor(date.getTime() / 1000) + 60;
    const pozRate = new web3.utils.BN("1000000000");
    const publicRate = new web3.utils.BN("500000000");
    const amount = new BN("100000000");
    await testToken.approve(poolzBack.address, amount, { from: firstAddress });
    const tx = await poolzBack.CreatePool(
      testToken.address,
      future,
      publicRate,
      pozRate,
      amount,
      0,
      constants.ZERO_ADDRESS,
      true,
      0,
      whiteListId,
      { from: firstAddress }
    );
    ethPoolId = tx.logs[1].args[1].toString();
    const result = await poolzBack.GetPoolExtraData(ethPoolId);
    assert.equal(whiteListId, result[1].toString());
  });

  it("should add Main Coin Address to Whitelist", async () => {
    const addressArray = [testToken.address];
    const amount = "100000000";
    const allowanceArray = [amount]; // random allowance
    await whiteList.AddAddress(whiteListId, addressArray, allowanceArray, {
      from: firstAddress,
    });
    const result = await whiteList.Check(testToken.address, whiteListId);
    assert.equal(result, amount);
    await poolzBack.SetWhiteList_Address(whiteListConvertor.address);
    await poolzBack.setMCWhitelistId(whiteListId);
    await poolzBack.SwapTokenFilter();
    const data = await poolzBack.IsTokenFilterOn();
    assert.equal(true, data);
  });

  it("add user to WhiteList", async () => {
    const addressArray = [secondAddress];
    const allowanceArray = [web3.utils.toWei("100")]; // 100 ETH
    await whiteList.AddAddress(whiteListId, addressArray, allowanceArray);
    const result = await whiteList.Check(secondAddress, whiteListId);
    assert.equal(
      result.toString(),
      web3.utils.toWei("100"),
      "check value in original white list"
    );
  });

  it("should revert with new price", async () => {
    const divide = false;
    const price = "10";
    const tx = await whiteListConvertor.SetPrice(
      whiteListId,
      price,
      divide,
      poolzBack.address
    );
    const currentPrice = tx.logs[0].args.Price.toString();
    const currentOperation = tx.logs[0].args.Operation.toString();
    const currentId = tx.logs[0].args.Id.toString();
    assert.equal(currentId, whiteListId);
    assert.equal(currentPrice, price);
    assert.equal(currentOperation, divide.toString());
    const result = await whiteListConvertor.Check(secondAddress, whiteListId);
    assert.equal(
      result.toString(),
      web3.utils.toWei("10"),
      "check value in convertor white list"
    );
    await truffleAssert.reverts(
      poolzBack.InvestETH(ethPoolId, {
        from: secondAddress,
        value: web3.utils.toWei("50"),
      }),
      "Sorry, no alocation for Subject"
    );
  });

  it("should invest", async () => {
    await poolzBack.InvestETH(ethPoolId, {
      from: secondAddress,
      value: web3.utils.toWei("5"),
    });
    const convertorResult = await whiteListConvertor.Check(
      secondAddress,
      whiteListId
    ); // convertor WhiteList
    assert.equal(
      convertorResult.toString(),
      web3.utils.toWei("5"),
      "check value in convertor whitelist"
    );
    const originalResult = await whiteList.Check(secondAddress, whiteListId); // original WhiteList
    assert.equal(
      originalResult.toString(),
      web3.utils.toWei("50"),
      "check value in original whitelist"
    );
  });

  it("should last round register", async () => {
    const contractAddress = accounts[9];
    const now = Date.now() / 1000; // current timestamp in seconds
    const timestamp = Number(now.toFixed()) + 3600; // timestamp one hour from now
    await whiteList.CreateManualWhiteList(
      timestamp,
      whiteListConvertor.address,
      { from: contractAddress }
    );
    const id = ((await whiteList.WhiteListCount()) - 1).toString();
    await whiteListConvertor.SetPrice(id, "10", false, contractAddress);
    await whiteListConvertor.LastRoundRegister(secondAddress, id, {
      from: contractAddress,
    });

    const userLimit = await whiteListConvertor.Check(secondAddress, id);
    const MAX_INT = constants.MAX_UINT256 / 10;
    assert.equal(userLimit.toString(), MAX_INT);
  });

  it("should return nothing, because id is 0", async () => {
    await whiteList.LastRoundRegister(secondAddress, 0, { from: accounts[9] });
    await whiteList.Register(secondAddress, 0, 1000, { from: accounts[9] });
  });

  describe("should invoke only by creator", async () => {
    let now, timestamp, whiteListCost;

    before(async () => {
      now = Date.now() / 1000; // current timestamp in seconds
      timestamp = Number(now.toFixed()) + 3600; // timestamp one hour from now
      whiteListCost = web3.utils.toWei("0.01", "ether");
      await whiteList.CreateManualWhiteList(
        timestamp,
        whiteListConvertor.address,
        { from: secondAddress, value: whiteListCost }
      );
      whiteListId = ((await whiteList.WhiteListCount()) - 1).toString();
    });

    it("Only creator can change creator", async () => {
      await truffleAssert.reverts(
        whiteList.ChangeCreator(whiteListId, secondAddress),
        "Only creator can access"
      );
    });

    it("Only creator can change contract", async () => {
      await truffleAssert.reverts(
        whiteList.ChangeContract(whiteListId, secondAddress),
        "Only creator can access"
      );
    });

    it("Only creator can add address", async () => {
      const addressArray = [testToken.address];
      const amount = "100000000";
      const allowanceArray = [amount]; // random allowance

      await truffleAssert.reverts(
        whiteList.AddAddress(whiteListId, addressArray, allowanceArray, {
          from: firstAddress,
        }),
        "Only creator can access"
      );
    });

    it("Only creator can remove address", async () => {
      const addressArray = [testToken.address];

      await truffleAssert.reverts(
        whiteList.RemoveAddress(whiteListId, addressArray, {
          from: firstAddress,
        }),
        "Only creator can access"
      );
    });

    it("should set max users limit", async () => {
      const previousLimit = await whiteList.MaxUsersLimit();
      await whiteList.setMaxUsersLimit(100);
      const newLimit = await whiteList.MaxUsersLimit();
      assert.equal(100, newLimit);
      assert.notEqual(previousLimit, newLimit);
    });

    it("should set whitelist cost", async () => {
      const previousCost = await whiteList.WhiteListCost();
      await whiteList.setWhiteListCost(1);
      const newCost = await whiteList.WhiteListCost();
      assert.equal(1, newCost);
      assert.notEqual(previousCost, newCost);
    });

    it("should change a contract", async () => {
      const previousContract = await whiteList.WhitelistSettings(whiteListId);
      await whiteList.ChangeContract(whiteListId, secondAddress, {
        from: secondAddress,
      });
      const newContract = await whiteList.WhitelistSettings(whiteListId);
      assert.notEqual(previousContract.Contract, newContract.Contract);
      assert.equal(newContract.Contract, secondAddress);
    });

    it("should remove a contract", async () => {
      await whiteList.AddAddress(whiteListId, [firstAddress], ["100000000"], {
        from: secondAddress,
      });
      const res1 = await whiteList.WhitelistDB(whiteListId, firstAddress);
      await whiteList.RemoveAddress(whiteListId, [firstAddress], {
        from: secondAddress,
      });
      const res = await whiteList.WhitelistDB(whiteListId, firstAddress);
      assert.notEqual(res1.toString(), res.toString());
      assert.equal(0, res.toString());
    });

    it("should change a creator", async () => {
      const previousContract = await whiteList.WhitelistSettings(whiteListId);
      await whiteList.ChangeCreator(whiteListId, accounts[5], {
        from: secondAddress,
      });
      const newContract = await whiteList.WhitelistSettings(whiteListId);
      assert.notEqual(previousContract.Creator, newContract.Creator);
      assert.equal(newContract.Creator, accounts[5]);
    });

    it("should withdraw eth fee", async () => {
      const tx = await whiteList.WithdrawETHFee(firstAddress);
    });

    it("should return true so whitelist is ready", async () => {
      const res = await whiteList.isWhiteListReady(whiteListId);
      assert.equal(true, res);
    });

    it('should set white list address', async () => {
      const previousAddress = await whiteListConvertor.WhiteListAddress();
      await whiteListConvertor.SetWhiteListAddress(accounts[2])
      const newAddress = await whiteListConvertor.WhiteListAddress();
      assert.notEqual(previousAddress, newAddress)
      assert.equal(newAddress, accounts[2])
    })
  });

  describe("should fail", async () => {
    it("should fail because only contract can call this", async () => {
      await truffleAssert.reverts(
        whiteList.LastRoundRegister(secondAddress, 1, { from: accounts[9] }),
        "Only the Contract can call this"
      );
      await truffleAssert.reverts(
        whiteList.Register(secondAddress, 1, 1000, { from: accounts[9] }),
        "Only the Contract can call this"
      );
    });

    it("should fail with incorrect number of users", async () => {
      await truffleAssert.reverts(
        whiteList.AddAddress(
          whiteListId,
          [firstAddress],
          ["100000000", "100"],
          { from: accounts[5] }
        ),
        "Number of users should be same as the amount length"
      );
    });

    it("should fail with need in something", async () => {
      await truffleAssert.reverts(
        whiteList.AddAddress(whiteListId, [], [], { from: accounts[5] }),
        "Need something..."
      );
    });

    it("should fail with ether not enough", async () => {
      const now = Date.now() / 1000; // current timestamp in seconds
      const timestamp = Number(now.toFixed()) + 3600; // timestamp one hour from now
      await truffleAssert.reverts(
        whiteList.CreateManualWhiteList(timestamp, whiteListConvertor.address, {
          from: secondAddress,
          value: 0,
        }),
        "ether not enough"
      );
    });

    it("should return nothing in check", async () => {
      await whiteList.Check(accounts[5], 0);
    });

    it("should fail with only creator can access", async () => {
      await truffleAssert.reverts(
        whiteList.ChangeCreator(whiteListId, accounts[5], {
          from: accounts[7],
        }),
        "Only creator can access"
      );
    });
  });
});
