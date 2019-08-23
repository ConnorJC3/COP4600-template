default: run
reset: clean-backup clean

run:
	@qemu-system-x86_64 -enable-kvm -m 4G -cpu host -smp `nproc` -net nic -net user,hostfwd=tcp:127.0.0.1:2222-:22 -vga qxl disk.qcow2 &
	@./ssh.sh -p 2222 reptilian@localhost
	@pkill qemu || true
clean:
	cp backup.qcow2 disk.qcow2
clean-backup:
	cp original.qcow2 backup.qcow2
set-backup:
	cp disk.qcow2 backup.qcow2
