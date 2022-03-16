#!/usr/bin/env python3

from struct import *
import socket, sys, time, datetime, argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('host', type=str, help='hostname or IP')
    parser.add_argument('port', type=int, help='port; default Mumble port is 64738')
    args = parser.parse_args()

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.settimeout(1)

    buf = pack(">iQ", 0, datetime.datetime.now().microsecond)
    s.sendto(buf, (args.host, args.port))

    try:
        data, addr = s.recvfrom(1024)
    except socket.timeout:
        print(f"{time.time()}:NaN:NaN")
        sys.exit()

    r = unpack(">bbbbQiii", data)

    users = r[5]

    if users > 0:
        print(users)
