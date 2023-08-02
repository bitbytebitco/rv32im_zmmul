#!/usr/bin/python3

import re
import sys
from time import sleep
import serial

def get_hex():
	''' Obtain hex instructions from disassembled file. '''
	hex_inst = []
	print("filename: %s" % sys.argv[1])
	in_file = open(sys.argv[1], 'r')
	for line in in_file.readlines():
		if re.search('^\s*[0-9a-f]', line, re.I):
			parts = line.split("\t") 	
			if len(parts)>1:
				#print(parts[1])
				hex_inst.append(parts[1].strip())
	return hex_inst

def send_uart(instrs):

	# start UART  	
	try:
		print(instrs)
		ser = serial.Serial(
				port='/dev/ttyUSB1',
				baudrate=115200,
				parity=serial.PARITY_NONE,
				stopbits=serial.STOPBITS_ONE,
				bytesize=serial.EIGHTBITS
				)	
		'''
		print(sys.argv[1])
		in_file = open(sys.argv[1], 'r')
		for line in in_file.readlines():
			byte_chunks = bytes.fromhex(line)

			packet = bytearray()

			for i in reversed(range(4)):
				#print(byte_chunks[i])
				#ser.write(byte_chunks[i])
				packet.append(byte_chunks[i])
			ser.write(packet)
		'''

		for inst in instrs:
			print(inst)

			# break into bytes
			byte_chunks = bytes.fromhex(inst)
	
			# instantiate packet
			packet = bytearray()

			# little-endian order
			for i in reversed(range(4)):
				packet.append(byte_chunks[i])
	
			# write packet
			ser.write(packet)

		ser.close()
	except Exception as e:
		print(e)


if __name__ == "__main__":

	instructions = get_hex()
	send_uart(instructions)
