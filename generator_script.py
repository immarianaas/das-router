SIDE = 4
SIDE = 10

print("""
\tmesh: entity router_mesh_top
\tport map (
\trst => rst,
      
    """)

for i in range(SIDE):
    for j in range(SIDE):

        if i in range(1,SIDE-1) and j in range(1,SIDE-1): continue

        print(f"\tdata_{i}{j}_in => data_in_sig({i},{j}),")
        print(f"\treq_{i}{j}_in => req_in_sig({i},{j}),")
        print(f"\tack_{i}{j}_out => ack_out_sig({i},{j}),")
        print(f"\tdata_{i}{j}_out => data_out_sig({i},{j}),")
        print(f"\treq_{i}{j}_out => req_out_sig({i},{j}),")
        print(f"\tack_{i}{j}_in => ack_in_sig({i},{j})",
              end="\n" if i == SIDE and j == SIDE else ",\n")
        print()

print("\t);")
