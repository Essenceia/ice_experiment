
example: example.v example.pcf
	yosys -p 'synth_ice40 -top top -blif example.blif' example.v
	arachne-pnr -d 1k -o example.asc -p example.pcf example.blif
	icepack example.asc example.bin
