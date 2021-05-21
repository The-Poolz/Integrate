#!/bin/bash

truffle-flattener poolz-back/contracts/ThePoolz.sol > contracts/PoolzBack.sol

sed -i 's/SPDX-License-Identifier: MIT//g' contracts/PoolzBack.sol
sed -i '1i// SPDX-License-Identifier: MIT' contracts/PoolzBack.sol

echo "contract PoolzBack is ThePoolz{}" >> contracts/PoolzBack.sol