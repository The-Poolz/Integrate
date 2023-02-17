# contracts
cp -a ./node_modules/poolz-locked-deal-v2/contracts/. ./contracts/LockedDealV2
cp -a ./node_modules/poolz-delay-vault/contracts/. ./contracts/DelayVault
cp -a ./node_modules/poolz-whitelist/contracts/. ./contracts/WhiteList
# tests
cp -a ./node_modules/poolz-locked-deal-v2/test/. ./test/LockedDealV2
cp -a ./node_modules/poolz-whitelist/test/. ./test/WhiteList
cp -a ./node_modules/poolz-delay-vault/test/. ./test/DelayVault

#temporary fix for naming error of TestToken in Benefit tests
#sed -i 's/"TestToken"/"Token"/g' test/4_Benefit/test.js