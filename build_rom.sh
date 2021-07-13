# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RohieOS/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Prashant1873/manifest_personal --depth=1 -b caf .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_jasmine_sprout-userdebug
export TZ=Asia/Kolkata 
m rohie

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
# rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P 
rclone copy out/target/product/jasmine_sprout/*20210713*jasmine_sprout-OFFICIAL-GApps.zip cirrus:jasmine_sprout -P  
