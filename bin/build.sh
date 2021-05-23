#!/bin/bash

truffle-flattener poolz-back/contracts/ThePoolz.sol > contracts/PoolzBack.sol
sed -i 's/SPDX-License-Identifier: MIT//g' contracts/PoolzBack.sol
sed -i '1i// SPDX-License-Identifier: MIT' contracts/PoolzBack.sol


truffle-flattener poolz-whitelist/contracts/WhiteList.sol > contracts/WhiteList.sol
sed -i 's/SPDX-License-Identifier: MIT//g' contracts/WhiteList.sol
sed -i '1i// SPDX-License-Identifier: MIT' contracts/WhiteList.sol


truffle-flattener poolz-locked-deal/contracts/LockedDeal.sol > contracts/LockedDeal.sol
sed -i 's/SPDX-License-Identifier: MIT//g' contracts/LockedDeal.sol
sed -i '1i// SPDX-License-Identifier: MIT' contracts/LockedDeal.sol

truffle-flattener poolz-benefit/contracts/Benefit.sol > contracts/Benefit.sol
sed -i 's/SPDX-License-Identifier: MIT//g' contracts/Benefit.sol
sed -i '1i// SPDX-License-Identifier: MIT' contracts/Benefit.sol


# # Fixing Name Duplication Warning
# sed -i 's/Context/PB_Context/g' contracts/PoolzBack.sol
# sed -i 's/ERC20/PB_ERC20/g' contracts/PoolzBack.sol
# sed -i 's/IERC20/PB_IERC20/g' contracts/PoolzBack.sol
# sed -i 's/Ownable/PB_Ownable/g' contracts/PoolzBack.sol
# sed -i 's/SafeMath/PB_SafeMath/g' contracts/PoolzBack.sol
# sed -i 's/ERC20Helper/PB_ERC20Helper/g' contracts/PoolzBack.sol
# sed -i 's/ETHHelper/PB_ETHHelper/g' contracts/PoolzBack.sol
# sed -i 's/GovManager/PB_GovManager/g' contracts/PoolzBack.sol
# sed -i 's/IPOZBenefit/PB_IPOZBenefit/g' contracts/PoolzBack.sol
# sed -i 's/IWhiteList/PB_IWhiteList/g' contracts/PoolzBack.sol
# sed -i 's/Manageable/PB_Manageable/g' contracts/PoolzBack.sol
# sed -i 's/PozBenefit/PB_PozBenefit/g' contracts/PoolzBack.sol

# sed -i 's/Context/WL_Context/g' contracts/WhiteList.sol
# sed -i 's/ERC20/WL_ERC20/g' contracts/WhiteList.sol
# sed -i 's/IERC20/WL_IERC20/g' contracts/WhiteList.sol
# sed -i 's/Ownable/WL_Ownable/g' contracts/WhiteList.sol
# sed -i 's/SafeMath/WL_SafeMath/g' contracts/WhiteList.sol
# sed -i 's/ERC20Helper/WL_ERC20Helper/g' contracts/WhiteList.sol
# sed -i 's/ETHHelper/WL_ETHHelper/g' contracts/WhiteList.sol
# sed -i 's/GovManager/WL_GovManager/g' contracts/WhiteList.sol
# sed -i 's/IPOZBenefit/WL_IPOZBenefit/g' contracts/WhiteList.sol
# sed -i 's/IWhiteList/WL_IWhiteList/g' contracts/WhiteList.sol
# sed -i 's/Manageable/WL_Manageable/g' contracts/WhiteList.sol
# sed -i 's/PozBenefit/WL_PozBenefit/g' contracts/WhiteList.sol

# sed -i 's/Context/LD_Context/g' contracts/LockedDeal.sol
# sed -i 's/ERC20/LD_ERC20/g' contracts/LockedDeal.sol
# sed -i 's/IERC20/LD_IERC20/g' contracts/LockedDeal.sol
# sed -i 's/Ownable/LD_Ownable/g' contracts/LockedDeal.sol
# sed -i 's/SafeMath/LD_SafeMath/g' contracts/LockedDeal.sol
# sed -i 's/ERC20Helper/LD_ERC20Helper/g' contracts/LockedDeal.sol
# sed -i 's/ETHHelper/LD_ETHHelper/g' contracts/LockedDeal.sol
# sed -i 's/GovManager/LD_GovManager/g' contracts/LockedDeal.sol
# sed -i 's/IPOZBenefit/LD_IPOZBenefit/g' contracts/LockedDeal.sol
# sed -i 's/IWhiteList/LD_IWhiteList/g' contracts/LockedDeal.sol
# sed -i 's/Manageable/LD_Manageable/g' contracts/LockedDeal.sol
# sed -i 's/PozBenefit/LD_PozBenefit/g' contracts/LockedDeal.sol

# sed -i 's/Context/B_Context/g' contracts/Benefit.sol
# sed -i 's/ERC20/B_ERC20/g' contracts/Benefit.sol
# sed -i 's/IERC20/B_IERC20/g' contracts/Benefit.sol
# sed -i 's/Ownable/B_Ownable/g' contracts/Benefit.sol
# sed -i 's/SafeMath/B_SafeMath/g' contracts/Benefit.sol
# sed -i 's/ERC20Helper/B_ERC20Helper/g' contracts/Benefit.sol
# sed -i 's/ETHHelper/B_ETHHelper/g' contracts/Benefit.sol
# sed -i 's/GovManager/B_GovManager/g' contracts/Benefit.sol
# sed -i 's/IPOZBenefit/B_IPOZBenefit/g' contracts/Benefit.sol
# sed -i 's/IWhiteList/B_IWhiteList/g' contracts/Benefit.sol
# sed -i 's/Manageable/B_Manageable/g' contracts/Benefit.sol
# sed -i 's/PozBenefit/B_PozBenefit/g' contracts/Benefit.sol

mkdir ./test/1_PoolzBack
cp -a ./node_modules/poolz-back/test/General/. ./test/1_PoolzBack

mkdir ./test/2_WhiteList
cp -a ./node_modules/poolz-whitelist/test/. ./test/2_WhiteList

mkdir ./test/3_LockedDeal
cp -a ./node_modules/poolz-locked-deal/test/. ./test/3_LockedDeal

mkdir ./test/4_Benefit
cp -a ./node_modules/poolz-benefit/test/. ./test/4_Benefit

#temporary fix for naming error of TestToken in Benefit tests
sed -i 's/"TestToken"/"Token"/g' test/4_Benefit/test.js