library verilog;
use verilog.vl_types.all;
entity part3_vlg_sample_tst is
    port(
        KEY             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end part3_vlg_sample_tst;
