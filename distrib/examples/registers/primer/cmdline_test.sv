// 
// -------------------------------------------------------------
//    Copyright 2004-2008 Synopsys, Inc.
//    Copyright 2010 Mentor Graphics Corp.
//    Copyright 2010 Cadence Design Systems, Inc.
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


typedef class dut_reset_seq;
class cmdline_test extends uvm_test;

   `uvm_component_utils(cmdline_test)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual task run();
      tb_env env;
      $cast(env, uvm_top.find("env"));

      begin
         uvm_sequence_base rst_seq;
         rst_seq = dut_reset_seq::type_id::create("rst_seq", this);
         rst_seq.start(null);
      end
      env.model.reset();

      begin
         uvm_cmdline_processor opts = uvm_cmdline_processor::get_inst();

         uvm_reg_sequence  seq;
         string            seq_name;

         opts.get_arg_value("+UVM_REG_SEQ", seq_name);
         if (seq_name[0] == "=")
            seq_name = seq_name.substr(1, seq_name.len()-1);
         
         if (!$cast(seq, factory.create_object_by_name(seq_name,
                                                       get_full_name(),
                                                       "seq"))
             || seq == null) begin
            `uvm_fatal("TEST/CMD/BADSEQ", {"Sequence ", seq_name,
                                           " is not a known sequence"})
         end
         seq.model = env.model;
         seq.start(null);
      end
      global_stop_request();

   endtask : run

endclass : cmdline_test



