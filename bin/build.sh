mkdir ./contracts/PoolzBack
cp -a ./node_modules/poolz-back/contracts/. ./contracts/PoolzBack

mkdir ./contracts/LockedDeal
cp -a ./node_modules/poolz-locked-deal/contracts/. ./contracts/LockedDeal

mkdir ./contracts/WhiteList
cp -a ./node_modules/poolz-whitelist/contracts/. ./contracts/WhiteList

mkdir ./contracts/Benefit
cp -a ./node_modules/poolz-benefit/contracts/. ./contracts/Benefit


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