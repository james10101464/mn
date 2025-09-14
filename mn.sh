#!/bin/bash
set -e

# Update & install dependencies
sudo apt update
sudo apt install -y git build-essential cmake automake libtool autoconf libhwloc-dev libuv1-dev libssl-dev

# Clone XMRig if not present
if [ ! -d "xmrig" ]; then
  git clone https://github.com/xmrig/xmrig.git
fi

# Build XMRig
mkdir -p xmrig/build
cd xmrig/build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j"$(nproc)"
strip xmrig

# Run XMRig (70% CPU usage limit)
./xmrig -o pool.supportxmr.com:443 -u 42KJEwM2z3wPPCebT9VSjKbJYaVTtGP1AN7gH6yyLnoWMCU1JenWuXGF4Aa1FE5exx4ToRfB5xKsGAM1G4Ez9jX1PeCvVVL -k --tls -p vm1 --cpu-max-threads-hint=70
