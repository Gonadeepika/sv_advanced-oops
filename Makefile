# Makefile for Deepcopy/Inheritance/Polymorphism - SV Lab04

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS

help:
	@echo ==============================================================================================================
	@echo " USAGE   		--  make target										"
	@echo " clean   		=>  clean the earlier log and intermediate files.					"
	@echo " run_sim   		=>  compile & run the simulation in batch mode with test_inheritance.sv file.		"
	@echo " run_sim1  		=>  compile & run the simulation in batch mode with test_deep_copy.sv file.		"
	@echo " run_sim2  		=>  compile & run the simulation in batch mode with test_polymorphism.sv file.		"
	@echo " run_inherit  		=>  clean, compile & run the simulation in batch mode with test_inheritance.sv file.	"
	@echo " run_copy		=>  clean, compile & run the simulation in batch mode with test_deep_copy.sv file.	"
	@echo " run_poly 		=>  clean, compile & run the simulation in batch mode with test_polymorphism.sv file.	"
	@echo ==============================================================================================================
	
clean : clean_$(SIMULATOR)
run_sim : run_sim_$(SIMULATOR)
run_sim1 : run_sim1_$(SIMULATOR)
run_sim2 : run_sim2_$(SIMULATOR)
run_inherit : run_inherit_$(SIMULATOR)
run_copy : run_copy_$(SIMULATOR)
run_poly : run_poly_$(SIMULATOR)	
	

# ---- Start of Definitions for Mentor's Questa Specific Targets -----#

run_inherit_Questa: clean_Questa run_sim_Questa

run_copy_Questa: clean_Questa run_sim1_Questa

run_poly_Questa: clean_Questa run_sim2_Questa

run_sim_Questa: 
	qverilog ../tb/test_inheritance.sv
	
run_sim1_Questa: 
	qverilog ../tb/test_deep_copy.sv
	
run_sim2_Questa: 
	qverilog ../tb/test_polymorphism.sv	
	
clean_Questa:
	rm -rf transcript* *log* work *.wlf modelsim.ini 
	clear
	
# ---- End of Definitions for Mentor's Questa Specific Targets -----#	

# ---- Start of Definitions for Synopsys VCS Specific Targets -----#

run_inherit_VCS: clean_VCS run_sim_VCS

run_copy_VCS: clean_VCS run_sim1_VCS

run_poly_VCS: clean_VCS run_sim2_VCS

run_sim_VCS: 
	vcs -l comp.log -sverilog ../tb/test_inheritance.sv
	./simv

run_sim1_VCS: 
	vcs -l comp.log -sverilog ../tb/test_deep_copy.sv
	./simv

run_sim2_VCS: 
	vcs -l comp.log -sverilog ../tb/test_polymorphism.sv
	./simv
	
clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h
	clear 
	
# ---- End of Definitions for Synopsys VCS Specific Targets -----#	
