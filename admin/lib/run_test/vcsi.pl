##---------------------------------------------------------------------- 
##   Copyright 2010 Synopsys, Inc. 
##   Copyright 2010 Verilab, Inc. 
##   All Rights Reserved Worldwide 
## 
##   Licensed under the Apache License, Version 2.0 (the 
##   "License"); you may not use this file except in 
##   compliance with the License.  You may obtain a copy of 
##   the License at 
## 
##       http://www.apache.org/licenses/LICENSE-2.0 
## 
##   Unless required by applicable law or agreed to in 
##   writing, software distributed under the License is 
##   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
##   CONDITIONS OF ANY KIND, either express or implied.  See 
##   the License for the specific language governing 
##   permissions and limitations under the License. 
##----------------------------------------------------------------------

#
# VCS-Specific test running script
#

#
# Make sure the version of VSC can run these tests
#
$vcs_bin = "vcsi";
$compiler_string = "Compiler version = VCS-MXi";

# Redefine $tool so it points to VCS so as not to break things like
# file names for compile arguments (vcs.comp.args) used in the main
# body of run_tests.
$tool = "vcs";

require "vcs.pl";

1;
