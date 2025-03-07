onerror {exit -code 1}
vlib work
vlog -work work lab2.vo
vlog -work work counter.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.part3_vlg_vec_tst -voptargs="+acc"
vcd file -direction lab2.msim.vcd
vcd add -internal part3_vlg_vec_tst/*
vcd add -internal part3_vlg_vec_tst/i1/*
run -all
quit -f
