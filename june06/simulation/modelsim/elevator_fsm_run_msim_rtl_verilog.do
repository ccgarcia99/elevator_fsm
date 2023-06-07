transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06 {C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06/elevator_fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06 {C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06/floor_display.v}

vlog -vlog01compat -work work +incdir+C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06 {C:/Users/ACER/Desktop/3101L_FP/project_testbenches/june06/elevator_fsm_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  elevator_fsm_tb

add wave *
view structure
view signals
run -all
