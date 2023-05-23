set_property PACKAGE_PIN G19 [get_ports switch]
set_property PACKAGE_PIN E15 [get_ports led]
set_property DIRECTION OUT [get_ports led]
set_property IOSTANDARD LVCMOS25 [get_ports led]
set_property DRIVE 12 [get_ports led]
set_property SLEW SLOW [get_ports led]
set_property DIRECTION IN [get_ports switch]
set_property IOSTANDARD LVCMOS25 [get_ports switch]
#revert back to original instance
current_instance -quiet
