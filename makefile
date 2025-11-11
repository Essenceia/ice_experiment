PROJ=comp

# board support package
BSP=bsp.pcf
# board using package vq100 
PKG=vq100
DEVICE=hx1k

BUILD_DIR=build

sv_files=$(wildcard *.v)

.PHONY: syn build explain vlog prog time tb lint waves

$(PROJ).blif: $(sv_files)
	yosys -p 'synth_ice40 -top top -blif $(PROJ).blif' -p 'read -sv $^' -p 'show' $^ 

$(PROJ).asc: $(PROJ).blif $(BSP)
	arachne-pnr -P $(PKG) -d 1k -o $(PROJ).asc -p $(BSP) $(PROJ).blif
	
$(PROJ).bin: $(PROJ).asc
	icepack $(PROJ).asc $(PROJ).bin

syn: $(PROJ).blif
	echo "Syn finished"

build: $(PROJ).bin
	echo "Build finished"

explain: $(PROJ).asc 
	icebox_explain $(PROJ).asc

vlog: $(PROJ).asc
	icebox_vlog -p $(PROJ).pcf $(PROJ).asc

prog: $(PROJ).bin
	iceprog $(PROJ).bin

time: $(PROJ).asc	
	icetime -p $(BSP) -d $(DEVICE) -t $(PROJ).asc -r timeing.txt

lint: $(sv_files)
	iverilog -Wall -s top -o $(BUILD_DIR)/top $^

TB_DIR=tb
TB_NAME=top_tb
$(BUILD_DIR)/$(TB_NAME): $(sv_files) $(TB_DIR)/$(TB_NAME).v
	iverilog -Wall -s $(TB_NAME) -o $(BUILD_DIR)/$(TB_NAME) $^

$(BUILD_DIR)/$(TB_NAME).vcd: $(BUILD_DIR)/$(TB_NAME) 
	vvp $(BUILD_DIR)/$(TB_NAME)

tb: $(BUILD_DIR)/$(TB_NAME).vcd

waves: $(BUILD_DIR)/$(TB_NAME).vcd  
	gtkwave $^ &

clean:
	rm -f *.asc
	rm -f *.bin
	rm -f *.blif
