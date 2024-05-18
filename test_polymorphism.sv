/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	test_polymorphism.sv   

Description		:	Example for Polymorphism

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/

module test_polymorphism;

	// In class packet_c

	class packet_c;
		// In task send
		// Display message "Sending base class packet"
	virtual task send();
			$display("Send is called from an object of %s class, and it is sending base class packet", $typename(this));
		endtask:send
	endclass: packet_c


	// Extend badpacket_c from packet_c

	class badpacket_c extends packet_c;
		// Override task send
		// Display message "Sending derived class packet"
		task send();
			$display("Send is called from an object of %s class, and it is sending derived class packet", $typename(this));
		endtask:send
	endclass: badpacket_c

	// Within initial
		
		initial
			begin
		// Create instances for badpacket_c and packet_c 
			badpacket_c bp_h=new;
			packet_c pkt_h=new;

		// Call send tasks using base and extended handles
			pkt_h.send();
			bp_h.send();

		// Assign extended class handle to base class handle
			pkt_h = bp_h;
		// Call send task using base class object
			pkt_h.send(); 
		
			end

endmodule
