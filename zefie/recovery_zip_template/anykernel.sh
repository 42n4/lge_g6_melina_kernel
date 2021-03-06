# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string="%NAME% kernel for %MANU% %MODEL% by %KERNELDEV%"
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=%MODEL_WHITELIST%
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc
#backup_file init.rc;
#replace_string init.rc "cpuctl cpu,timer_slack" "mount cgroup none /dev/cpuctl cpu" "mount cgroup none /dev/cpuctl cpu,timer_slack";

# init.tuna.rc
#backup_file init.tuna.rc;
#insert_line init.tuna.rc "nodiratime barrier=0" after "mount_all /fstab.lucye" "\tmount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data remount nosuid nodev noatime nodiratime barrier=0";
#append_file init.tuna.rc "bootscript" init.tuna;

# fstab.lucye
#backup_file fstab.lucye;
#patch_fstab fstab.lucye /system ext4 options "noatime,barrier=1" "noatime,nodiratime,barrier=0";
#patch_fstab fstab.lucye /cache ext4 options "barrier=1" "barrier=0,nomblk_io_submit";
#patch_fstab fstab.lucye /data ext4 options "data=ordered" "nomblk_io_submit,data=writeback";
#append_file fstab.lucye "usbdisk" fstab;

# end ramdisk changes

ui_print " "
ui_print "Kernel Device: %MANU% %MODEL% (%DEVMODEL%)"
ui_print "Kernel Name: %NAME%"
ui_print "Kernel Maintainer: %KERNELDEV%"
ui_print "Kernel Version: %VERSION%"
ui_print " "
ui_print "Toolchain Info:"
ui_print "gcc: %TOOLCHAIN_VERSION%"
%EXTRA_CMDS%
ui_print " "

write_boot;

ui_print "******************************************"
ui_print "If you find this release useful, please"
ui_print "consider supporting zefie on Patreon"
ui_print " "
ui_print "http://zef.pw/patreon"
ui_print "******************************************"

## end install

