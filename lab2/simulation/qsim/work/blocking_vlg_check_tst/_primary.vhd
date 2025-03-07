library verilog;
use verilog.vl_types.all;
entity blocking_vlg_check_tst is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end blocking_vlg_check_tst;
