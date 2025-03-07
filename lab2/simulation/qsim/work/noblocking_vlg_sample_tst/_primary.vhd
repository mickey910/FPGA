library verilog;
use verilog.vl_types.all;
entity noblocking_vlg_sample_tst is
    port(
        \IN\            : in     vl_logic;
        clk             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end noblocking_vlg_sample_tst;
