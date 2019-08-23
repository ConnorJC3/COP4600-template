default: kernel-compile kernel-install environment-run

kernel-compile:
	$(MAKE) -j `nproc` -C kernel

kernel-install:
	@mkdir -p mount/
	@export ARCH=x86_64
	guestmount -a environment/disk.qcow2 -o uid=`id -u` -o gid=`id -g` -m /dev/sda1 mount/
	$(MAKE) -C kernel install INSTALL_PATH=`pwd`/mount/boot/
	$(MAKE) -C kernel modules_install INSTALL_MOD_PATH=`pwd`/mount/system/
	guestunmount mount/
	@sleep 3

environment-clean:
	$(MAKE) -C environment clean

environment-run:
	$(MAKE) -C environment

bootstrap:
	mv environment/ temp/
	mkdir environment
	sudo chattr +C environment
	cp -r temp/* environment/
	rm -rf temp/
