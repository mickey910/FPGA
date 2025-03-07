library verilog;
use verilog.vl_types.all;
entity ip_counter is
    port(
        aclr            : in     vl_logic;
        cin             : in     vl_logic;
        clock           : in     vl_logic;
        q               : out    vl_logic_vector(15 downto 0)
    );
end ip_counter;
