library verilog;
use verilog.vl_types.all;
entity ip_counter_vlg_sample_tst is
    port(
        aclr            : in     vl_logic;
        cin             : in     vl_logic;
        clock           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end ip_counter_vlg_sample_tst;
