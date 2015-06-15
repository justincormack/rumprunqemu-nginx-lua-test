#!/bin/sh

export RUMPRUN_WARNING_STFU=please

docker run justincormack/rumprunqemu-nginx-lua-test cat /usr/local/bin/nginx.hw_virtio > nginx.hw_virtio
docker run justincormack/rumprunqemu-nginx-lua-test cat /usr/src/rumprun/app-tools/rumprun > rumprun
docker run justincormack/rumprunqemu-nginx-lua-test cat /usr/src/rump-nginx-lua-test/data.iso > data.iso
docker run justincormack/rumprunqemu-nginx-lua-test cat /usr/src/rump-nginx-lua-test/etc.iso > etc.iso

chmod +x rumprun nginx.hw_virtio

rumprun qemu -i -I 'qnet0,vioif,-net tap,ifname=tap0' -W qnet0,inet,dhcp -b etc.iso,/etc -b data.iso,/data nginx.hw_virtio -- -c /data/conf/nginx.conf
