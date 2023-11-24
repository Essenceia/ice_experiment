PROJ=example

# board using package vq100 
PKG=vq100

$(PROJ).blif: $(PROJ).v $(PROJ).pcf
	yosys -p 'synth_ice40 -top top -blif example.blif' -p 'read -sv $<' $< 

$(PROJ).asc: $(PROJ).blif
	arachne-pnr -P $(PKG) -d 1k -o example.asc -p example.pcf example.blif
	
$(PROJ).bin: $(PROJ).asc
	icepack example.asc example.bin

build: $(PROJ).bin
	echo "Build finished"

explain: $(PROJ).asc 
	icebox_explain $(PROJ).asc

vlog: $(PROJ).asc
	icebox_vlog -p $(PROJ).pcf $(PROJ).asc

prog: $(PROJ).bin
	iceprog $(PROJ).bin
	
clean:
	rm -f *.asc
	rm -f *.bin
	rm -f *.blif
