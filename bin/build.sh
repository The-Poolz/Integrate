mkdir contracts &&

cp -a ./node_modules/poolz-back/contracts/. ./contracts/PoolzBack

cp -a ./node_modules/poolz-locked-deal/contracts/. ./contracts/LockedDeal

cp -a ./node_modules/poolz-locked-deal-v2/contracts/. ./contracts/LockedDealV2

cp -a ./node_modules/poolz-whitelist/contracts/. ./contracts/WhiteList

cp -a ./node_modules/poolz-benefit/contracts/. ./contracts/Benefit

cp -a ./node_modules/poolz-hodlers-whitelist/contracts/. ./contracts/HodlersWhitelist

cp -a ./node_modules/poolz-envelop-token/contracts/. ./contracts/EnvelopToken

cp -a ./node_modules/@uniswap/v2-core/contracts/. ./contracts/Uniswap-V2-Core

cp -a ./node_modules/poolz-whitelist-converter/contracts/. ./contracts/WhitelistConvertor

cp -a ./node_modules/poolz-flex-staking/contracts/. ./contracts/FlexStaking

cp -a ./node_modules/poolz-multi-sender/contracts/. ./contracts/MultiSender

cp -a ./node_modules/poolz-delay-vault/contracts/. ./contracts/DelayVault

cp -a ./node_modules/poolz-multi-withdraw/contracts/. ./contracts/MultiWithdraw

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

cp -a ./node_modules/poolz-multi-sender/test/. ./test/MultiSender

cp -a ./node_modules/poolz-delay-vault/test/. ./test/DelayVault

cp -a ./node_modules/poolz-multi-withdraw/test/. ./test/MultiWithdraw

#temporary fix for naming error of TestToken in Benefit tests
#sed -i 's/"TestToken"/"Token"/g' test/4_Benefit/test.js