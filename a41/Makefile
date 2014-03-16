PROGNAME=a41
SRC = $(PROGNAME).v counter.v

CLEAN = $(PROGNAME).bgn $(PROGNAME).drc $(PROGNAME).mrp $(PROGNAME).ngd $(PROGNAME).pcf \
	$(PROGNAME).bld $(PROGNAME).lso $(PROGNAME).ncd $(PROGNAME).ngm $(PROGNAME).srp \
	$(PROGNAME).bit $(PROGNAME)_signalbrowser.* $(PROGNAME)-routed_pad.tx \
	$(PROGNAME).map $(PROGNAME)_summary.xml timing.twr \
	$(PROGNAME)-routed* $(PROGNAME)_usage* $(PROGNAME).ngc param.opt netlist.lst \
	webtalk.log usage_statistics_webtalk.html $(PROGNAME)_bitgen.xwbt _xmsgs xlnx_auto_0_xdb\
	xst $(PROGNAME).prj $(PROGNAME)*.xrpt smartpreview.twr $(PROGNAME).svf _impactbatch.log

all: $(PROGNAME).bit

$(PROGNAME).prj: $(SRC)
	rm -f $(PROGNAME).prj
	@for i in `echo $^`; do \
		echo $i; \
	    echo "verilog worlk $$i" >> $(PROGNAME).prj; \
	done

$(PROGNAME).ngc: $(PROGNAME).prj
	xst -ifn $(PROGNAME).xst

$(PROGNAME).ngd: $(PROGNAME).ngc $(PROGNAME).ucf
	ngdbuild -uc $(PROGNAME).ucf $(PROGNAME).ngc

$(PROGNAME).ncd: $(PROGNAME).ngd
	map $(PROGNAME).ngd

$(PROGNAME)-routed.ncd: $(PROGNAME).ncd
	par -ol high -w $(PROGNAME).ncd $(PROGNAME)-routed.ncd

$(PROGNAME).bit: $(PROGNAME)-routed.ncd
	bitgen -g StartupClk:JtagClk -w $(PROGNAME)-routed.ncd $(PROGNAME).bit

upload:
	djtgcfg prog -d Nexys2 -i 0 -f $(PROGNAME).bit

clean:
	rm -Rf $(CLEAN)

.PHONY: clean view
