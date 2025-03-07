library verilog;
use verilog.vl_types.all;
entity blocking is
    port(
        \in\            : in     vl_logic;
        a               : out    vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        clk             : in     vl_logic
    );
end blocking;
