SIDE = 4
SIDE = 10

print("""
io2: process(req_out_sig) is
\tvariable line_v : line;
\tvariable data : std_logic_vector(DATA_WIDTH-1 downto 0);

\tvariable x,y,dx,dy : integer;
\tvariable curr_ack_in : t_bit_matrix := (others => (others =>'0')); 

\tvariable i, j: integer;
    
procedure handle_output_transition(
        i : Integer;
        j : Integer
        ) is 
begin
        write(line_v, data_out_sig(i,j));
        write(line_v, string'(","));
        write(line_v, time'image(now));
        write(line_v, string'(",(") & integer'image(i) & string'(".") & integer'image(j) & string'(")"));
        writeline(write_output_file, line_v);
        ack_out_sig(i,j) <= req_out_sig(i,j);
end procedure;


begin

\tif req_out_sig'event then
    """)

for i in range(SIDE):
    for j in range(SIDE):

        if i in range(1,SIDE-1) and j in range(1,SIDE-1): continue

        print(f"\tif req_out_sig({i},{j})'event then")
        print(f"\t\ti:={i}; j:= {j};")
        print(f"\t\thandle_output_transition({i},{j});")
        print(f"\tend if;")
        print()    

print("\tend if;")
print("end process;")
