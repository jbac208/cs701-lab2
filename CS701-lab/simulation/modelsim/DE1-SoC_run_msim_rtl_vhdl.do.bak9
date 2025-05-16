transcript on
if ![file isdirectory vhdl_libs] {
	file mkdir vhdl_libs
}

vlib vhdl_libs/altera
vmap altera ./vhdl_libs/altera
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_syn_attributes.vhd}
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_standard_functions.vhd}
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/alt_dspbuilder_package.vhd}
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_europa_support_lib.vhd}
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_primitives_components.vhd}
vcom -93 -work altera {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_primitives.vhd}

vlib vhdl_libs/lpm
vmap lpm ./vhdl_libs/lpm
vcom -93 -work lpm {c:/intelfpga/18.1/quartus/eda/sim_lib/220pack.vhd}
vcom -93 -work lpm {c:/intelfpga/18.1/quartus/eda/sim_lib/220model.vhd}

vlib vhdl_libs/sgate
vmap sgate ./vhdl_libs/sgate
vcom -93 -work sgate {c:/intelfpga/18.1/quartus/eda/sim_lib/sgate_pack.vhd}
vcom -93 -work sgate {c:/intelfpga/18.1/quartus/eda/sim_lib/sgate.vhd}

vlib vhdl_libs/altera_mf
vmap altera_mf ./vhdl_libs/altera_mf
vcom -93 -work altera_mf {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_mf_components.vhd}
vcom -93 -work altera_mf {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_mf.vhd}

vlib vhdl_libs/altera_lnsim
vmap altera_lnsim ./vhdl_libs/altera_lnsim
vlog -sv -work altera_lnsim {c:/intelfpga/18.1/quartus/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv}
vcom -93 -work altera_lnsim {c:/intelfpga/18.1/quartus/eda/sim_lib/altera_lnsim_components.vhd}

vlib vhdl_libs/cyclonev
vmap cyclonev ./vhdl_libs/cyclonev
vlog -vlog01compat -work cyclonev {c:/intelfpga/18.1/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vcom -93 -work cyclonev {c:/intelfpga/18.1/quartus/eda/sim_lib/cyclonev_atoms.vhd}
vcom -93 -work cyclonev {c:/intelfpga/18.1/quartus/eda/sim_lib/cyclonev_components.vhd}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib ip
vmap ip ip
vlog -vlog01compat -work ip +incdir+H:/CS701/ip/AudioClock_1/submodules {H:/CS701/ip/AudioClock_1/submodules/AudioClock_audio_pll_0.v}
vlog -vlog01compat -work ip +incdir+H:/CS701/ip/AudioClock_1/submodules {H:/CS701/ip/AudioClock_1/submodules/altera_up_avalon_reset_from_locked_signal.v}
vlog -vlog01compat -work ip +incdir+H:/CS701/ip/AudioClock_1/submodules {H:/CS701/ip/AudioClock_1/submodules/AudioClock_audio_pll_0_audio_pll.v}
vcom -93 -work ip {H:/CS701/ip/AudioClock_1/AudioClock.vhd}
vcom -93 -work ip {H:/CS701/ip/AudioFifo/AudioFifo.vhd}
vcom -93 -work ip {H:/CS701/ip/AudioRom/AudioRom.vhd}
vcom -93 -work ip {H:/CS701/ip/TdmaMinFifo/TdmaMinFifo.vhd}
vcom -93 -work work {H:/CS701/src/Audio/AudioControl.vhd}
vcom -93 -work work {H:/CS701/src/Misc/HexSeg.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinSlots.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinTypes.vhd}
vcom -93 -work work {H:/CS701/src/Audio/AudioIn.vhd}
vcom -93 -work work {H:/CS701/src/Audio/AudioOut.vhd}
vcom -93 -work work {H:/CS701/src/Audio/AudioTones.vhd}
vcom -93 -work work {H:/CS701/src/Misc/HexSeg6.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinInterface.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinSwitch.vhd}
vcom -93 -work work {H:/CS701/src/AspDp.vhd}
vcom -93 -work work {H:/CS701/src/AspAdc.vhd}
vcom -93 -work work {H:/CS701/src/AspDac.vhd}
vcom -93 -work work {H:/CS701/src/Audio/Audio.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinStage.vhd}
vcom -93 -work work {H:/CS701/src/AspExample.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMinFabric.vhd}
vcom -93 -work work {H:/CS701/src/TdmaMin/TdmaMin.vhd}
vcom -93 -work work {H:/CS701/src/TopLevel.vhd}

vcom -93 -work work {H:/CS701/test/TestAdc.vhd}
vcom -93 -work work {H:/CS701/test/TestDac.vhd}
vcom -93 -work work {H:/CS701/test/TestTopLevel.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -L ip -voptargs="+acc"  TEST1

add wave *
view structure
view signals
run -all
