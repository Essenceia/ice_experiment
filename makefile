PROJ=example

# board support package
BSP=bsp.pcf
# board using package vq100 
PKG=vq100

sv_files=example.v asc_to_7seg.v

$(PROJ).blif: $(sv_files)
	yosys -p 'synth_ice40 -top top -blif example.blif' -p 'read -sv $^' $^ 

$(PROJ).asc: $(PROJ).blif $(BSP)
	arachne-pnr -P $(PKG) -d 1k -o example.asc -p $(BSP) example.blif
	
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
