cp -a ./node_modules/poolz-back/test/General/. ./test/01_PoolzBack

cp -a ./node_modules/poolz-whitelist/test/. ./test/02_WhiteList

cp -a ./node_modules/poolz-locked-deal/test/. ./test/03_LockedDeal

cp -a ./node_modules/poolz-benefit/test/. ./test/04_Benefit

cp -a ./node_modules/poolz-hodlers-whitelist/test/. ./test/05_HodlersWhitelist

cp -a ./node_modules/poolz-envelop-token/test/. ./test/06_EnvelopToken

cp -a  ./node_modules/uniswap-v2-test/. ./test/00_Uniswap-V2-Core

cp -a ./node_modules/poolz-whitelist-converter/test/. ./test/12_WhitelistConverter

cp -a ./node_modules/poolz-locked-deal-v2/test/. ./test/14_LockedDealV2

cp -a ./node_modules/poolz-flex-staking/test/. ./test/FlexStaking

#temporary fix for naming error of TestToken in Benefit tests
#sed -i 's/"TestToken"/"Token"/g' test/4_Benefit/test.js
