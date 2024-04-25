# Variables
GHDL=ghdl
SRC=$(wildcard src/*.vhd)
TB_SRC=$(wildcard tb/*.vhd)
OBJ=$(SRC:.vhd=.o)
TB_OBJ=$(TB_SRC:.vhd=.o)
ENTITIES=$(basename $(notdir $(SRC)))
TESTBENCHES=$(basename $(notdir $(TB_SRC)))

# Default target
all: elaborate runtests

# Rule to compile VHDL files
%.o: %.vhd
	$(GHDL) -a $<

# Rule to elaborate the design
elaborate: $(OBJ)
	@echo "Entities: $(ENTITIES)"
	@$(foreach entity,$(ENTITIES),powershell -Command "$(GHDL) -e $(entity);" )

# Rule to run the testbenches
runtests: elaborate $(TB_OBJ)
	@echo "Running testbenches: $(TESTBENCHES)"
	@$(foreach tb,$(TESTBENCHES),powershell -Command "$(GHDL) -r $(tb) --vcd=$(tb).vcd --stop-time=100ns;" )

# Rule to clean the workspace
clean:
	$(GHDL) --clean
	rm -f $(OBJ) $(TB_OBJ)