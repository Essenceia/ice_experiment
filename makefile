PROJ=comp

# board support package
BSP=bsp.pcf
# board using package vq100 
PKG=vq100
DEVICE=hx1k

sv_files=$(PROJ).v asc_to_7seg.v fifo_2_deep.v

$(PROJ).blif: $(sv_files)
	yosys -p 'synth_ice40 -top top -blif $(PROJ).blif' -p 'read -sv $^' -p 'show' $^ 

$(PROJ).asc: $(PROJ).blif $(BSP)
	arachne-pnr -P $(PKG) -d 1k -o $(PROJ).asc -p $(BSP) $(PROJ).blif
	
$(PROJ).bin: $(PROJ).asc
	icepack $(PROJ).asc $(PROJ).bin

syn: $(PROJ).blif
	echo "Syn finished"

place: $(PROJ).bin
	echo "Build finished"

explain: $(PROJ).asc 
	icebox_explain $(PROJ).asc

vlog: $(PROJ).asc
	icebox_vlog -p $(PROJ).pcf $(PROJ).asc

prog: $(PROJ).bin
	iceprog $(PROJ).bin

time: $(PROJ).asc	
	icetime -p $(BSP) -d $(DEVICE) -t $(PROJ).asc -r timeing.txt

tb: fifo_2_deep.v tb/tb.v
	iverilog -Wall -s fifo_2_deep -o build/fifo_2_deep $^

lint_top: $(PROJ).v
	iverilog -Wall -s top -o build/top $^

TB_DIR=tb
TB_FILE=$(PROJ)_tb.v
tb_top: $(PROJ).v $(TB_DIR)/$(TB_FILE)
	iverilog -Wall -s top_tb -o build/top_tb $^

clean:
	rm -f *.asc
	rm -f *.bin
	rm -f *.blif
