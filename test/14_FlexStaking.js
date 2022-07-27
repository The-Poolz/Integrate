const FlexStakingUser = artifacts.require("FlexStakingUser");
const LockedDeal = artifacts.require("LockedDealV2");
const Token = artifacts.require("ERC20Token");
const { assert } = require("chai");
const timeMachine = require("ganache-time-traveler");
const BigNumber = require("bignumber.js");
const truffleAssert = require("truffle-assertions");

contract("Flex Staking with LockedDealV2 integration", (accounts) => {
  const projectOwner = accounts[0], amount = '1000000000000', APR = '50' // Annual Percentage Rate
  const minAmount = '10000000', maxAmount = '1000000000', user = accounts[5]
  const oneMonth = 60 * 60 * 24 * 30 // seconds
  const twoMonths = 60 * 60 * 24 * 60
  const halfYear = '15768000'
  const date = new Date()
  const startTime = Math.floor(date.getTime() / 1000) + 60
  let finishTime, poolId, lockId, rwdId, poolId2
  let flexStaking, rwdToken, lockToken, lockedDeal

  before(async () => {
      flexStaking = await FlexStakingUser.new()
      rwdToken = await Token.new("REWARD", "REWARD")
      lockToken = await Token.new("LOCK", "LOCK")
      lockedDeal = await LockedDeal.new()
      date.setDate(date.getDate() + 365)   // add a year
      finishTime = Math.floor(date.getTime() / 1000) + 60
      await flexStaking.SetLockedDealAddress(lockedDeal.address)
  })

  it('should create new pool', async () => {
      await rwdToken.approve(flexStaking.address, amount, { from: projectOwner })
      const tx = await flexStaking.CreateStakingPool(lockToken.address, rwdToken.address, amount, startTime, finishTime, APR, oneMonth, halfYear, minAmount, maxAmount, '0')
      const pool = tx.logs[tx.logs.length - 1].args
      assert.equal(projectOwner, pool.Owner, 'invalid owner')
      assert.equal('1', pool.Id, 'invalid pool id')
      assert.equal(lockToken.address, pool.LockedToken, 'invalid lock token')
      assert.equal(rwdToken.address, pool.RewardToken, 'invalid reward token')
      assert.equal(amount, pool.TokensAmount, 'invalid tokens amount')
      assert.equal(startTime, pool.StartTime, 'invalid start time')
      assert.equal(finishTime, pool.FinishTime, 'invalid finish time')
      assert.equal(APR, pool.APR, 'invalid APR')
      assert.equal(oneMonth, pool.MinDuration, 'invalid min duration')
      assert.equal(halfYear, pool.MaxDuration, 'invalid max duration')
      assert.equal(minAmount, pool.MinAmount, 'invalid min amount')
      assert.equal(maxAmount, pool.MaxAmount, 'invalid max amount')
      assert.equal('0', pool.EarlyWithdraw, 'invalid min early withdraw')
      poolId = pool.Id

      await lockToken.approve(flexStaking.address, amount, { from: projectOwner })
      const tx2 = await flexStaking.CreateStakingPool(lockToken.address, lockToken.address, amount, startTime, finishTime, APR, oneMonth, halfYear, minAmount, maxAmount, '0')
      const pool2 = tx2.logs[tx.logs.length - 1].args.Id
      poolId2 = pool2.Id
  })

  it('should stake', async () => {
      await timeMachine.advanceBlockAndSetTime(startTime)
      const amount = minAmount
      const duration = halfYear
      await lockToken.transfer(user, amount)
      await lockToken.approve(flexStaking.address, amount, { from: user })
      await flexStaking.Stake(poolId, amount, duration, { from: user })
      rwdId = '0'
      lockId = '1'
  })

  it("should stake with different tokens", async () => {
    const amount = minAmount;
    const duration = halfYear;
    await lockToken.transfer(user, amount);
    await lockToken.approve(flexStaking.address, amount, { from: user });
    await flexStaking.Stake(poolId2, amount, duration, { from: user });
  });

  it("should return reward tokens", async () => {
    await timeMachine.advanceBlockAndSetTime(finishTime);
    const reward = (minAmount * APR * halfYear) / 365 / 24 / 60 / 60 / 100;
    const oldBal = new BigNumber(await rwdToken.balanceOf(user));
    const tx = await lockedDeal.WithdrawToken(rwdId, { from: user });
    const actualRwd = tx.logs[tx.logs.length - 1].args.Amount;
    const actualBal = new BigNumber(await rwdToken.balanceOf(user));
    assert.equal(
      parseInt(reward).toString(),
      actualRwd.toString(),
      "invalid reward amount"
    );
    assert.equal(
      BigNumber.sum(oldBal, reward).toString(),
      actualBal.toString(),
      "invalid balance"
    );
  });

  it("should return locked tokens", async () => {
    await timeMachine.advanceBlockAndSetTime(finishTime);
    const locked = minAmount;
    const oldBal = new BigNumber(await lockToken.balanceOf(user));
    const tx = await lockedDeal.WithdrawToken(lockId, { from: user });
    const result = tx.logs[tx.logs.length - 1].args.Amount;
    const actualBal = new BigNumber(await lockToken.balanceOf(user));
    assert.equal(
      parseInt(locked).toString(),
      result.toString(),
      "invalid locked amount"
    );
    assert.equal(
      BigNumber.sum(oldBal, result).toString(),
      actualBal.toString(),
      "invalid balance"
    );
  });

  it("should mass stake", async () => {
    const users = [accounts[1], accounts[2], accounts[3], accounts[4]];
    const amounts = [minAmount, minAmount, maxAmount, maxAmount / 10];
    const durations = [oneMonth, twoMonths, halfYear, halfYear];
    for (
      let i = 0, rwdId = 2, lockId = 3;
      i < users.length;
      i++, rwdId += 2, lockId += 2
    ) {
      const reward =
        (amounts[i] * APR * durations[i]) / 365 / 24 / 60 / 60 / 100;
      await lockToken.transfer(users[i], amounts[i]);
      await lockToken.approve(flexStaking.address, amounts[i], {
        from: users[i],
      });
      await timeMachine.advanceBlockAndSetTime(startTime);
      await flexStaking.Stake(poolId, amounts[i], durations[i], {
        from: users[i],
      });
      await timeMachine.advanceBlockAndSetTime(finishTime);
      const rwdTx = await lockedDeal.WithdrawToken(rwdId, { from: user });
      const lockTx = await lockedDeal.WithdrawToken(lockId, { from: user });
      const actualRwd = rwdTx.logs[rwdTx.logs.length - 1].args.Amount;
      const actualLock = lockTx.logs[lockTx.logs.length - 1].args.Amount;
      assert.equal(
        parseInt(reward).toString(),
        actualRwd.toString(),
        "invalid reward amount"
      );
      assert.equal(
        parseInt(amounts[i]).toString(),
        actualLock.toString(),
        "invalid locked amount"
      );
    }
  });

  it("should revert when pause", async () => {
    await rwdToken.approve(flexStaking.address, amount, { from: projectOwner });
    await flexStaking.Pause();
    await truffleAssert.reverts(
      flexStaking.CreateStakingPool(
        lockToken.address,
        rwdToken.address,
        amount,
        startTime,
        finishTime,
        APR,
        oneMonth,
        halfYear,
        minAmount,
        maxAmount,
        "0"
      ),
      "Pausable: paused"
    );
    await timeMachine.advanceBlockAndSetTime(startTime);
    await lockToken.transfer(user, amount);
    await lockToken.approve(flexStaking.address, amount, { from: user });
    await truffleAssert.reverts(
      flexStaking.Stake(poolId, minAmount, halfYear, { from: user }),
      "Pausable: paused"
    );
    await flexStaking.Unpause();
  });

  it("should withdraw tokens", async () => {
    date.setDate(date.getDate() + 1);
    finishTime = Math.floor(date.getTime() / 1000) + 60;
    await timeMachine.advanceBlockAndSetTime(finishTime);
    const rewardReserve = new BigNumber(
      await rwdToken.balanceOf(flexStaking.address)
    );
    const ownerBal = new BigNumber(await rwdToken.balanceOf(projectOwner));
    await flexStaking.WithdrawLeftOver(poolId, { from: projectOwner });
    const actualBal = new BigNumber(await rwdToken.balanceOf(projectOwner));
    const actualReserv = new BigNumber(
      await rwdToken.balanceOf(flexStaking.address)
    );
    assert.equal(actualReserv, "0", "invalid reserve amount");
    assert.equal(
      actualBal.toString(),
      BigNumber.sum(rewardReserve, ownerBal).toString(),
      "invalid owner balance"
    );
  });

  after(async () => {
    await timeMachine.advanceBlockAndSetTime(Math.floor(Date.now() / 1000));
  });
});
