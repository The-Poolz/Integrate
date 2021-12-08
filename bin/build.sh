mkdir ./contracts/PoolzBack
cp -a ./node_modules/poolz-back/contracts/. ./contracts/PoolzBack

mkdir ./contracts/LockedDeal
cp -a ./node_modules/poolz-locked-deal/contracts/. ./contracts/LockedDeal

mkdir ./contracts/WhiteList
cp -a ./node_modules/poolz-whitelist/contracts/. ./contracts/WhiteList

mkdir ./contracts/Benefit
cp -a ./node_modules/poolz-benefit/contracts/. ./contracts/Benefit

mkdir ./contracts/HodlersWhitelist
cp -a ./node_modules/poolz-hodlers-whitelist/contracts/. ./contracts/HodlersWhitelist

mkdir ./contracts/EnvelopToken
cp -a ./node_modules/poolz-envelop-token/contracts/. ./contracts/EnvelopToken


mkdir ./test/01_PoolzBack
cp -a ./node_modules/poolz-back/test/General/. ./test/01_PoolzBack

mkdir ./test/02_WhiteList
cp -a ./node_modules/poolz-whitelist/test/. ./test/02_WhiteList

mkdir ./test/03_LockedDeal
cp -a ./node_modules/poolz-locked-deal/test/. ./test/03_LockedDeal

mkdir ./test/04_Benefit
cp -a ./node_modules/poolz-benefit/test/. ./test/04_Benefit

mkdir ./test/05_HodlersWhitelist
cp -a ./node_modules/poolz-hodlers-whitelist/test/. ./test/05_HodlersWhitelist

mkdir ./test/06_EnvelopToken
cp -a ./node_modules/poolz-envelop-token/test/. ./test/06_EnvelopToken

#temporary fix for naming error of TestToken in Benefit tests
sed -i 's/"TestToken"/"Token"/g' test/4_Benefit/test.js