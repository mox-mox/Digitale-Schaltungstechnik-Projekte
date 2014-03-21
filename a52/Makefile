# Verilog makefile

# The top level module must be named $PROGNAME and reside in a file called $PROGNAME.v.
# So for example, if PROGNAME is set to "my_fancy_pantsy_program", the top level module should be called my_fancy_pantsy_program.
PROGNAME=a51

# Use the shell to get a list of all verilog files
SRC := $(shell find $(CURDIR) -name '*.v')

CLEAN = $(PROGNAME).bgn $(PROGNAME).drc $(PROGNAME).mrp $(PROGNAME).ngd $(PROGNAME).pcf \
	$(PROGNAME).bld $(PROGNAME).lso $(PROGNAME).ncd $(PROGNAME).ngm $(PROGNAME).srp \
	$(PROGNAME).bit $(PROGNAME)_signalbrowser.* $(PROGNAME)-routed_pad.tx \
	$(PROGNAME).map $(PROGNAME)_summary.xml timing.twr \
	$(PROGNAME)-routed* $(PROGNAME)_usage* $(PROGNAME).ngc param.opt netlist.lst \
	webtalk.log usage_statistics_webtalk.html $(PROGNAME)_bitgen.xwbt _xmsgs xlnx_auto_0_xdb\
	xst $(PROGNAME).prj $(PROGNAME)*.xrpt smartpreview.twr $(PROGNAME).svf _impactbatch.log\
	$(PROGNAME).xst

all: $(PROGNAME).bit

$(PROGNAME).prj: $(SRC)
	rm -f $(PROGNAME).prj
	@for i in `echo $^`; do \
		echo $i; \
	    echo "verilog worlk $$i" >> $(PROGNAME).prj; \
	done

#.PHONY: $(PROGNAME).xst
$(PROGNAME).xst:
	@rm -f $(PROGNAME).xst
	@echo "...Generating $(PROGNAME).xst..."
	@echo "run"                     >> $(PROGNAME).xst;
	@echo "-ifn $(PROGNAME).prj"    >> $(PROGNAME).xst;
	@echo "-top $(PROGNAME)"        >> $(PROGNAME).xst;
	@echo "-ifmt MIXED"             >> $(PROGNAME).xst;
	@echo "-opt_mode AREA"          >> $(PROGNAME).xst;
	@echo "-opt_level 2"            >> $(PROGNAME).xst;
	@echo "-ofn $(PROGNAME).ngc"    >> $(PROGNAME).xst;
	@echo "-p xc3s500e-fg320-4"     >> $(PROGNAME).xst;
	@echo "-register_balancing yes" >> $(PROGNAME).xst;


$(PROGNAME).ngc: $(PROGNAME).prj $(PROGNAME).xst
	xst -ifn $(PROGNAME).xst

$(PROGNAME).ngd: $(PROGNAME).ngc user_constraints.ucf
	ngdbuild -uc user_constraints.ucf $(PROGNAME).ngc

$(PROGNAME).ncd: $(PROGNAME).ngd
	map $(PROGNAME).ngd

$(PROGNAME)-routed.ncd: $(PROGNAME).ncd
	par -ol high -w $(PROGNAME).ncd $(PROGNAME)-routed.ncd

$(PROGNAME).bit: $(PROGNAME)-routed.ncd
	bitgen -g StartupClk:JtagClk -w $(PROGNAME)-routed.ncd $(PROGNAME).bit

# Will build the project and upload it -> THIS IS WHAT YOU WILL WANT TO USE MOST OF THE TIME
prog: $(PROGNAME).bit upload
	@echo ""

# Will only upload current bit file, if it exists, but won't attemt to build the project
.PHONY: upload
upload:
	@echo -e "\n\n================Uploading the bit file to the board===============================\n\n"
	djtgcfg prog -d Nexys2 -i 0 -f $(PROGNAME).bit
	@echo -e "\n\n============================Upload done===========================================\n\n"

.PHONY: clean
clean:
	rm -Rf $(CLEAN)

.PHONY: clean view
