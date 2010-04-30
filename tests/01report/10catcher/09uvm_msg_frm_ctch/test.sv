//---------------------------------------------------------------------- 
//   Copyright 2010 Synopsys, Inc. 
//   All Rights Reserved Worldwide 
// 
//   Licensed under the Apache License, Version 2.0 (the 
//   "License"); you may not use this file except in 
//   compliance with the License.  You may obtain a copy of 
//   the License at 
// 
//       http://www.apache.org/licenses/LICENSE-2.0 
// 
//   Unless required by applicable law or agreed to in 
//   writing, software distributed under the License is 
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//   CONDITIONS OF ANY KIND, either express or implied.  See 
//   the License for the specific language governing 
//   permissions and limitations under the License. 
//----------------------------------------------------------------------

//////////////distrib/src/base/uvm_object_globals.svh////////////////////////////
//////// uvm_severity   
////////
///////typedef enum uvm_severity
///////{
///////  UVM_INFO,
///////  UVM_WARNING,
///////  UVM_ERROR,
///////  UVM_FATAL
/////////} uvm_severity_type;
//////////////////////////


///////uvm_misc.svh////////////
/////////
////// typedef enum {UVM_APPEND, UVM_PREPEND} uvm_apprepend;
///////////////////////////////
///////////////////////////////



program top;

import uvm_pkg::*;

class my_catcher_info extends uvm_report_catcher;
   
   virtual function action_e catch();
      $write("Info Catcher Caught a message...\n");
     `uvm_info("INFO CATCHER", "From my_catcher_info catch()" ,UVM_MEDIUM);
     
      return THROW;
   endfunction
endclass

  class my_catcher_warning extends uvm_report_catcher;
   
   virtual function action_e catch();
      $write("Warning Catcher Caught a message...\n");
  `uvm_warning("WARNING CATCHER","From my_catcher_warning catch()");
  
     
      return THROW;
   endfunction
  endclass

  class my_catcher_error extends uvm_report_catcher;
   
   virtual function action_e catch();
      $write("Error Catcher Caught a message...\n");
  `uvm_error( "ERROR CATCHER ","From my_catcher_error catch() ");
  
     
      return THROW;
   endfunction
  endclass

  class my_catcher_fatal extends uvm_report_catcher;
   
   virtual function action_e catch();
      $write("Fatal Catcher Caught a Fatal message...\n");
  `uvm_info("FATAL CATCHER", "From my_catcher_fatal catch()", UVM_INFO );
  
    
      return THROW;
   endfunction
  endclass

  
  

class test extends uvm_test;


   `uvm_component_utils(test)

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual task run();
      $write("UVM TEST - Same catcher type - different IDs\n");
  
        begin
          my_catcher_info ctchr1 = new;
          my_catcher_warning ctchr2 = new;
          my_catcher_error ctchr3 = new;
          my_catcher_fatal ctchr4 = new;
          

          //add_report_id_catcher(string id, uvm_report_catcher catcher, uvm_apprepend ordering = UVM_APPEND);
          $write("adding a catcher of type my_catcher_info with id of Catcher1\n");
          uvm_report_catcher::add_report_id_catcher("Catcher1",ctchr1);
          
          $write("adding a catcher of type my_catcher_warning with id of Catcher2\n");
          uvm_report_catcher::add_report_id_catcher("Catcher2",ctchr2);

          $write("adding a catcher of type my_catcher_error with id of Catcher3\n");
          uvm_report_catcher::add_report_id_catcher("Catcher3",ctchr3);
          
          $write("adding a catcher of type my_catcher_fatal with id of Catcher4\n");
          uvm_report_catcher::add_report_id_catcher("Catcher4",ctchr4);
          
          `uvm_info("Catcher1", "This Info message is for Catcher1", UVM_MEDIUM);
          `uvm_warning("Catcher2", "This Warning message is for Catcher2");
          `uvm_error ("Catcher3", "This Error message is for Catcher3");
          //`uvm_fatal ("Catcher4", "This fatal message is for Catcher4");
          `uvm_info("XYZ", "This second message is for No One", UVM_MEDIUM);

          
        end // begin
  

  uvm_report_catcher::remove_all_report_catchers();
  
  $write("UVM TEST EXPECT 2 UVM_ERROR\n");
  
  uvm_top.stop_request();
   endtask

   virtual function void report();
  $write("** UVM TEST PASSED **\n");
   endfunction
endclass


initial
  begin
     run_test();
  end

endprogram
