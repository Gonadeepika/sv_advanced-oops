/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_deep_copy.sv   

Description		:	Example for Shallow and Deep Copy

Author Name		:	Putta Satish

Support e-mail  :	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_deep_copy;


	// In class parity_calc_c	
	class parity_calc_c;

		// Declare parity (bit type, size 8), initialize it with some random value
		bit [7:0] parity = 30;
	  
		// Write copy method that returns parity_calc_c class type
		function parity_calc_c copy();
			
			// Create copy instance
			copy = new;
		
			// Copy all the current properties into copy object
			copy.parity = this.parity;
			
		endfunction: copy

	endclass: parity_calc_c

	// In class packet_c

	class packet_c;

		// Declare header (bit type , size 8), initialize it with some random value
		bit [7:0] header = 20;
			
		// Declare data (bit type , size 8), initialize it with some random value
		bit [7:0] data = 40;
		
		// Declare and create an instance of parity_calc_c
		parity_calc_c par_h = new;

		// Define copy method that returns packet_c class type
		function packet_c copy();
		
			// Create copy instance
			copy = new;
		
			// Copy all the current class properties into copy object
			copy.header = this.header;
			copy.data = this.data;
			copy.par_h = this.par_h.copy();
			
		endfunction: copy

	endclass: packet_c

	// Declare 2 handles pkt_h1 & pkt_h2 for packet_c class 
	packet_c pkt_h1;
	packet_c pkt_h2;

	// Within initial
	
	initial
		begin
		// Create pkt_h1 object
		pkt_h1 = new;
	
		// Use shallow copy method to copy pkt_h1 to pkt_h2 
		pkt_h2 = new pkt_h1;
	
		// Display the properties of parent class and sub class properties of pkt_h1 and pkt_h2
		$display("PERFORMING SHALLOW COPY");
		$display("pkt_h1 after shallow copy {Header=%d, Data=%d, parity=%d}",pkt_h1.header, pkt_h1.data,pkt_h1.par_h.parity);
		$display("pkt_h2 after shallow copy {Header=%d, Data=%d, parity=%d}",pkt_h2.header, pkt_h2.data,pkt_h2.par_h.parity);
	
		// Assign random value to the header of pkt_h2

		pkt_h2.header=50;

		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe pkt_h1.header does not change
		$display("\nCHANGING THE VALUE OF pkt_h2 HEADER---Note pkt_h1 header is not changed since pkt_h1 and pkt_h2 are two different copies of packet_c objects");
		$display("pkt_h1 after updating header {Header=%d, Data=%d, parity=%d}",pkt_h1.header, pkt_h1.data,pkt_h1.par_h.parity);
		$display("pkt_h2 after updating header {Header=%d, Data=%d, parity=%d}",pkt_h2.header, pkt_h2.data,pkt_h2.par_h.parity);

		// Change parity of pkt_h2 using subclass handle from the parent class packet_c
		// Ex: pkt_h2.par.parity=19;
		pkt_h2.par_h.parity=19;

		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe that change reflected in pkt_h1 as the subclass handle in pkt_h1 and pkt_h2 are pointing to same subclass object
		$display("\nCHANGING THE VALUE OF pkt_h2 PARITY AFTER SHALLOW COPY---Note parity of both pkt_h1 and pkt_h2 are changed since both copies are pointing to same parity_calc_c object which implies shallow copy");
		$display("pkt_h1 after updating parity {Header=%d, Data=%d, parity=%d}",pkt_h1.header, pkt_h1.data,pkt_h1.par_h.parity);
		$display("pkt_h2 after updating parity {Header=%d, Data=%d, parity=%d}",pkt_h2.header, pkt_h2.data,pkt_h2.par_h.parity);

		// Perform deep copy by calling parent class copy method
		// Ex: pkt_h2=pkt_h1.copy;
		pkt_h2=pkt_h1.copy();

		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe the parent and subclass properties
		$display("\nPERFORMING DEEP COPY");
		$display("pkt_h1 after deep copy {Header=%d, Data=%d, parity=%d}",pkt_h1.header, pkt_h1.data,pkt_h1.par_h.parity);
		$display("pkt_h2 after deep copy {Header=%d, Data=%d, parity=%d}",pkt_h2.header, pkt_h2.data,pkt_h2.par_h.parity);

		// Change parity of pkt_h2
		// Ex:pkt_h2.par.parity=210;
		pkt_h2.par_h.parity=210;
	
		// Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
		// observe that parity doesnot change for pkt_h1 as they are two differnt subclass objects
		$display("\nCHANGING THE VALUE OF pkt_h2 PARITY AFTER DEEP COPY---Note parity of pkt_h1 is not changed since both copies are now pointing to two different parity_calc_c objects which implies deep copy");
		$display("pkt_h1 after updating parity {Header=%d, Data=%d, parity=%d}",pkt_h1.header, pkt_h1.data,pkt_h1.par_h.parity);
		$display("pkt_h2 after updating parity {Header=%d, Data=%d, parity=%d}",pkt_h2.header, pkt_h2.data,pkt_h2.par_h.parity);

		end

endmodule
