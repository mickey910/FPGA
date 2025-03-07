library verilog;
use verilog.vl_types.all;
entity noblocking is
    port(
        \IN\            : in     vl_logic;
        A               : out    vl_logic;
        B               : out    vl_logic;
        C               : out    vl_logic;
        clk             : in     vl_logic
    );
end noblocking;
