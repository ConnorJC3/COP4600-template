default: kernel-compile kernel-install run
test: kernel-compile kernel-install run-test
reset: kernel-clean environment-reset
clean: environment-clean

kernel-compile:
	$(MAKE) -j `nproc` -C kernel

kernel-install:
	@mkdir -p mount/
	@export ARCH=x86_64
	guestmount -a environment/disk.qcow2 -o uid=`id -u` -o gid=`id -g` -m /dev/sda1 mount/
	$(MAKE) -C kernel install INSTALL_PATH=`pwd`/mount/boot/
	$(MAKE) -C kernel modules_install INSTALL_MOD_PATH=`pwd`/mount/system/
	guestunmount mount/
	@sleep 5

run:
	$(MAKE) -C environment run

run-test:
	@$(MAKE) -sC environment run REPTILIAN_QEMU_OPTIONS="-nographic" REPTILIAN_SSH_UPLOAD_SOURCE="`pwd`/test/" REPTILIAN_SSH_UPLOAD_TARGET="/tmp/test/" REPTILIAN_SSH_COMMAND="make -C /tmp/test/ test"

environment-clean:
	$(MAKE) -C environment clean

environment-reset:
	$(MAKE) -C environment reset

set-backup:
	$(MAKE) -C environment set-backup

kernel-clean:
	$(MAKE) -C kernel clean

bootstrap:
	mv environment/ temp/
	mkdir environment
	sudo chattr +C environment
	cp -r temp/* environment/
	rm -rf temp/
