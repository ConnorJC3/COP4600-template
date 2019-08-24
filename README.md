# COP4600 on Linux

This repository contains the necessary infrastructure to develop for the reptilian kernel on linux.

## Requirements

- GCC, make, and all other dependencies needed to compile the linux kernel
- QEMU (for x86\_64)
- libguestfs
- tar
- ssh

## Setup

1. If (and only if) running on btrfs or another CoW filesystem run `make bootstrap`
2. Download the reptilian OVA image (URL available in ex0)
3. Extract the image using `tar -xf Reptilian-latest.ova`
4. Convert the VMDK disk to QCOW2 format using `qemu-img convert -O qcow2 Reptilian-19.01-A8.1-x64-disk001.vmdk original.qcow2`
5. Place `original.qcow2` in `environment/`
6. Change the kernel submodule to your (private) repository of the reptilian kernel: `git config --file=.gitmodules submodule.kernel.url YOUR_GIT_REPO_URL`
7. Update the submodule using `git submodule sync` and `git submodule update --init --recursive --remote`
8. Run `make reset`
9. Obtain the file `/usr/rep/build/config/reptilian-x86_64_defconfig` from the reptilian VM (you can run the VM with `make run`) and place it in `kernel/` named `.config`

## Usage

`make` - Compile the kernel and run a VM with the compiled kernel  
`make run` - Run the VM (using the existing kernel)  
`make set-backup` - Set the backup state for the VM (Useful to preload the VM with configs/tools)  
`make clean` - Reset the VM state to the backup state  
`make reset` - Reset the VM backup state to the original state and kernel compile cache

## Contributing

Contributions via PR are welcome. If reporting an issue please be detailed.
