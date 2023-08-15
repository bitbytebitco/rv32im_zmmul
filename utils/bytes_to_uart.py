#!/usr/bin/python3

import re
import sys
from time import sleep
import serial
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('-f', '--filename')
parser.add_argument('-tf', '--to-file', action="store_true")

def get_hex(filename):
    ''' Obtain hex instructions from disassembled file. '''
    hex_inst = []
    print("\r\nfilename: %s" % sys.argv[1])
    #in_file = open(sys.argv[1], 'r')
    in_file = open(filename, 'r')
    for line in in_file.readlines():
        if re.search('^\s.*[0-9a-f]{8}', line, re.I):
            parts = line.split("\t") 	
            if len(parts)>1:
                #print(parts[1])
                hex_inst.append(parts[1].strip())
    return hex_inst

def send_uart(instrs):

    # start UART  	
    try:
        ser = serial.Serial(
                port='/dev/ttyUSB1',
                baudrate=115200,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                bytesize=serial.EIGHTBITS
                )	
        
        for inst in instrs:
            #print(inst)

            try:
                # break into bytes
                byte_chunks = bytes.fromhex(inst)

                # instantiate packet
                packet = bytearray()

                # little-endian order
                for i in reversed(range(4)):
                    packet.append(byte_chunks[i])

                # write packet
                ser.write(packet)
            except Exception as e:
                print('line parse error')
                print(e)

        ser.close()
    except Exception as e:
        print(e)


if __name__ == "__main__":

    args = parser.parse_args()
    instructions = get_hex(args.filename)
    print(instructions)

    print(args)
    
    if(args.to_file):
        print('meep') 
        file = open("sample.txt", "w+")
        for inst in instructions:
            file.write("%s\r\n" % inst)
        file.close()
    else:
        send_uart(instructions)
