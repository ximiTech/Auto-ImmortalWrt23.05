#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

########### 修改默认 IP ###########
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

########### 更改大雕源码（可选）###########
# sed -i "s/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=5.15/g" target/linux/x86/Makefile

cd feeds/packages/net

rm -rf chinadns-ng/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng chinadns-ng/
rm -rf chinadns-ng/.svn/

rm -rf brook/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook brook/
rm -rf brook/.svn/

rm -rf hysteria/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria hysteria/
rm -rf hysteria/.svn/

rm -rf naiveproxy/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy naiveproxy/
rm -rf naiveproxy/.svn/

########### 维持v2ray-core的版本 ###########
rm -rf v2ray-core/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core v2ray-core/
rm -rf v2ray-core/.svn/

########### 维持v2ray-plugin的版本 ###########
rm -rf v2ray-plugin/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin v2ray-plugin/
rm -rf v2ray-plugin/.svn/

########### 维持xray-core的版本 ###########
rm -rf xray-core/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core xray-core/
rm -rf xray-core/.svn/

########### 维持xray-plugin的版本 ###########
rm -rf xray-plugin/
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin xray-plugin/
rm -rf xray-plugin/.svn/

########### 替换immortal的内置的smartdns版本 ###########
rm -rf smartdns/
svn co https://github.com/coolsnowwolf/packages/trunk/net/smartdns smartdns/
rm -rf smartdns/.svn/
sed -i 's/1.2023.41/1.2023.42/g' smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=45346705d8f24d5b8146d0261e330005341c8ee3/g' smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=skip/g' smartdns/Makefile

cd ../../..

########### 添加immortal的upx包 ###########
cd feeds/packages/utils
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.0.2/g' upx/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' upx/Makefile
cd ../../..

cd feeds/luci/applications
########### 修改immortal的内置的passwall版本 ###########
rm -rf luci-app-passwall/
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall luci-app-passwall/
rm -rf luci-app-passwall/.svn/

########### 修改immortal的内置的luci-app-smartdns版本 ###########
rm -rf luci-app-smartdns/
git clone -b master https://github.com/pymumu/luci-app-smartdns.git luci-app-smartdns
rm -rf luci-app-smartdns/.git/

########### 修改immortal的内置的openclash版本 ###########
rm -rf luci-app-openclash/
svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash luci-app-openclash/
rm -rf luci-app-openclash/.svn/
# git init
# git remote add -f origin https://github.com/vernesong/OpenClash.git
# git config core.sparsecheckout true
# echo "luci-app-openclash" >> .git/info/sparse-checkout
# git pull --depth 1 origin dev
# git branch --set-upstream-to=origin/dev
# git reset --hard 516f32579b66f31a7e533178a11b1b99fd4b30ea
# rm -rf .git/
sed -i 's/clashversion_check();/\/\/&/g' luci-app-openclash/luasrc/view/openclash/status.htm
rm luci-app-openclash/root/www/luci-static/resources/openclash/img/version.svg
wget -P luci-app-openclash/root/www/luci-static/resources/openclash/img https://github.com/ximiTech/intelligentclicker/raw/main/version.svg

########### 修改immortal的内置的luci-app-msd_lite版本 ###########
rm -rf luci-app-msd_lite/
wget https://github.com/ximiTech/intelligentclicker/raw/main/luci-app-msd_lite.zip
unzip -q ./luci-app-msd_lite.zip
rm ./luci-app-msd_lite.zip

cd ../../..
