library verilog;
use verilog.vl_types.all;
entity noblocking_vlg_check_tst is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end noblocking_vlg_check_tst;
