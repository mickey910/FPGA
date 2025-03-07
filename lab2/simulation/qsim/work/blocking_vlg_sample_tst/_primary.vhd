library verilog;
use verilog.vl_types.all;
entity blocking_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end blocking_vlg_sample_tst;
