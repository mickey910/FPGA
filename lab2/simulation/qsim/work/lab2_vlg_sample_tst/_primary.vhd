library verilog;
use verilog.vl_types.all;
entity lab2_vlg_sample_tst is
    port(
        KEY             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end lab2_vlg_sample_tst;
