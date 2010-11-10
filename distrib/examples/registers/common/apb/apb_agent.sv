// 
// -------------------------------------------------------------
//    Copyright 2004-2008 Synopsys, Inc.
//    Copyright 2010 Mentor Graphics Corp.
//    All Rights Reserved Worldwide
// 
//    Licensed under the Apache License, Version 2.0 (the
//    "License"); you may not use this file except in
//    compliance with the License.  You may obtain a copy of
//    the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in
//    writing, software distributed under the License is
//    distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//    CONDITIONS OF ANY KIND, either express or implied.  See
//    the License for the specific language governing
//    permissions and limitations under the License.
// -------------------------------------------------------------
// 


`ifndef APB_AGENT__SV
`define APB_AGENT__SV


typedef class apb_agent;


class apb_agent extends uvm_agent;

   apb_sequencer sqr;
   apb_master    drv;
   apb_monitor   mon;

   `uvm_component_utils_begin(apb_agent)
      `uvm_field_object(sqr, UVM_ALL_ON)
      `uvm_field_object(drv, UVM_ALL_ON)
      `uvm_field_object(mon, UVM_ALL_ON)
   `uvm_component_utils_end
   
   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      sqr = new("sqr", this);
      drv = new("drv", this);
      mon = new("mon", this);
   endfunction: new

   virtual function void connect();
      drv.seq_item_port.connect(sqr.seq_item_export);
   endfunction
endclass: apb_agent

`endif


