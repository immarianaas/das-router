# we have a grid of 4x4

from collections import defaultdict
from enum import Enum

SIDE = 4
SIDE = 10

nodes = []
for i in range(SIDE):
    for j in range(SIDE):
        nodes.append((i, j))


def coord_to_str(coord):
    return f"{coord[0]}{coord[1]}"


def is_larger(tuple1, tuple2):
    if tuple1[0] < tuple2[0]:
        return True
    elif tuple1[0] > tuple2[0]:
        return False
    elif tuple1[1] < tuple2[1]:
        return True
    elif tuple1[1] > tuple2[1]:
        return False

    assert False

def ordered_tuples(tuple1, tuple2):
    if tuple1[0] < tuple2[0]:
        return tuple1, tuple2
    elif tuple1[0] > tuple2[0]:
        return tuple2, tuple1
    elif tuple1[1] < tuple2[1]:
        return tuple1, tuple2
    elif tuple1[1] > tuple2[1]:
        return tuple2, tuple1

    assert False


strlist = []


class Dir(Enum):
    NW = 1,
    N = 2,
    NE = 3,
    E = 4,
    SE = 5,
    S = 6,
    SW = 7,
    W = 8


dir_list = [Dir.NW, Dir.N, Dir.NE, Dir.E, Dir.SE, Dir.S, Dir.SW, Dir.W]

def is_side(coord):
    return coord[0] in [0,SIDE-1] or coord[1] in [0,SIDE-1]

def dir_to_coordinates(coords: tuple, dir: Dir):
    match dir:
        case Dir.NW:
            return (coords[0]-1, coords[1]+1)
        case Dir.N:
            return (coords[0], coords[1]+1)
        case Dir.NE:
            return (coords[0]+1, coords[1]+1)
        case Dir.E:
            return (coords[0]+1, coords[1])
        case Dir.SE:
            return (coords[0]+1, coords[1]-1)
        case Dir.S:
            return (coords[0], coords[1]-1)
        case Dir.SW:
            return (coords[0]-1, coords[1]-1)
        case Dir.W:
            return (coords[0]-1, coords[1])


# 1) input to n2 -> {n1}_{n2}
def get_signal(n1, n2, signal, input: bool):

    #node1, node2 = ordered_tuples(n1, n2)
    node1 = n2 if input else n1
    node2 = n1 if input else n2
    return f"{signal}_{coord_to_str(node1)}_{coord_to_str(node2)}"

def get_port_signal_def(data, node1, dir):

    print(f'{data[node1][dir]["ack_signal"]["out"]}: out std_logic;')
    print(f'{data[node1][dir]["ack_signal"]["in"]}: in std_logic;')

    print(f'{data[node1][dir]["req_signal"]["out"]}: out std_logic;')
    print(f'{data[node1][dir]["req_signal"]["in"]}: in std_logic;')

    print(f'{data[node1][dir]["data_signal"]["out"]}: out std_logic_vector(DATA_WIDTH-1 downto 0);')
    print(f'{data[node1][dir]["data_signal"]["in"]}: in std_logic_vector(DATA_WIDTH-1 downto 0);')


def get_ack_signal_def(node1, node2, input: bool):
    signal_name = get_signal(node1, node2, 'ack', input)
    return f"signal {signal_name} : std_logic;"


def get_req_signal_def(node1, node2, input):
    signal_name = get_signal(node1, node2, 'req', input)
    return f"signal {signal_name} : std_logic;"


def get_data_signal_def(node1, node2, input):
    signal_name = get_signal(node1, node2, 'data', input)
    return f"signal {signal_name}: std_logic_vector(DATA_WIDTH-1 downto 0);"


pairs_done = defaultdict(list)


def is_out_of_bound(coord):
    return not (0 <= coord[0] < SIDE and 0 <= coord[1] < SIDE)


def is_interface_with_exterior(neighbor, coord):
    if coord in [(0, 0), (0, SIDE-1), (SIDE-1, SIDE-1), (SIDE-1, 0)]:
        return abs(neighbor[0]-coord[0]) == 1 and abs(neighbor[1]-coord[1]) == 1

    if neighbor[0] == coord[0]:
        return abs(neighbor[1]-coord[1]) == 1

    return neighbor[1] == coord[1] and abs(neighbor[0]-coord[0]) == 1


    


def get_node_data(print_port_definition: bool = False, print_internal_signals: bool = False) -> defaultdict:
    ports_done = set()
    data = defaultdict(lambda: defaultdict(list))

    for coord in nodes:

        for dir in dir_list:
            neighbor = dir_to_coordinates(coord, dir)

            if is_out_of_bound(neighbor):
                data[coord][dir] = {
                    "neighbor": neighbor,
                    "is_border": True,
                    "ack_signal":   {"out": f"ack_{coord_to_str(coord)}_in", "in": f"ack_{coord_to_str(coord)}_out"},
                    "req_signal":   {"out": f"req_{coord_to_str(coord)}_out", "in": f"req_{coord_to_str(coord)}_in"},
                    "data_signal":  {"out": f"data_{coord_to_str(coord)}_out", "in": f"data_{coord_to_str(coord)}_in"},
                }

                if print_port_definition and coord not in ports_done:
                    ports_done.add(coord)
                    get_port_signal_def(data, coord, dir)
                    print()

                continue

            if is_side(coord):
                pass


            data[coord][dir] = {
                "neighbor": neighbor,
                "is_border": False,
                "ack_signal": {"out": get_signal(coord, neighbor, "ack", False), "in": get_signal(coord, neighbor, "ack", True)},
                "req_signal": {"out": get_signal(coord, neighbor, "req", False), "in": get_signal(coord, neighbor, "req", True)},
                "data_signal": {"out": get_signal(coord, neighbor, "data", False), "in": get_signal(coord, neighbor, "data", True)},
            }

            if coord in pairs_done[neighbor]:
                continue
            pairs_done[coord].append(neighbor)

            if print_internal_signals:
                print(f'{get_ack_signal_def(coord, neighbor, True)}')
                print(f'{get_req_signal_def(coord, neighbor, True)}')
                print(f'{get_data_signal_def(coord, neighbor, True)}')
                print(f'{get_ack_signal_def(coord, neighbor, False)}')
                print(f'{get_req_signal_def(coord, neighbor, False)}')
                print(f'{get_data_signal_def(coord, neighbor, False)}')
                print()

    return data

data = get_node_data()


def get_node_def(coord):
    a = f'''

  router{coord_to_str(coord)}: entity router_node_top
        port map (
        rst => rst,
        
        ia_nw =>    {data[coord][Dir.NW]["ack_signal"]["out"]},
        ia_n =>     {data[coord][Dir.N]["ack_signal"]["out"]},
        ia_ne =>    {data[coord][Dir.NE]["ack_signal"]["out"]},
        ia_e =>     {data[coord][Dir.E]["ack_signal"]["out"]},
        ia_se =>    {data[coord][Dir.SE]["ack_signal"]["out"]},
        ia_s =>     {data[coord][Dir.S]["ack_signal"]["out"]},
        ia_sw =>    {data[coord][Dir.SW]["ack_signal"]["out"]},
        ia_w =>     {data[coord][Dir.W]["ack_signal"]["out"]},

        ir_nw   => {data[coord][Dir.NW]["req_signal"]["in"]},
        ir_n    => {data[coord][Dir.N]["req_signal"]["in"]},
        ir_ne   => {data[coord][Dir.NE]["req_signal"]["in"]},
        ir_e    => {data[coord][Dir.E]["req_signal"]["in"]},
        ir_se   => {data[coord][Dir.SE]["req_signal"]["in"]},
        ir_s    => {data[coord][Dir.S]["req_signal"]["in"]},
        ir_sw   => {data[coord][Dir.SW]["req_signal"]["in"]},
        ir_w    => {data[coord][Dir.W]["req_signal"]["in"]},
        
        id_nw   => {data[coord][Dir.NW]["data_signal"]["in"]},
        id_n    => {data[coord][Dir.N]["data_signal"]["in"]},
        id_ne   => {data[coord][Dir.NE]["data_signal"]["in"]},
        id_e    => {data[coord][Dir.E]["data_signal"]["in"]},
        id_se   => {data[coord][Dir.SE]["data_signal"]["in"]},
        id_s    => {data[coord][Dir.S]["data_signal"]["in"]},
        id_sw   => {data[coord][Dir.SW]["data_signal"]["in"]},
        id_w    => {data[coord][Dir.W]["data_signal"]["in"]},

        oa_nw   => {data[coord][Dir.NW]["ack_signal"]["in"]},
        oa_n    => {data[coord][Dir.N]["ack_signal"]["in"]},
        oa_ne   => {data[coord][Dir.NE]["ack_signal"]["in"]},
        oa_e    => {data[coord][Dir.E]["ack_signal"]["in"]},
        oa_se   => {data[coord][Dir.SE]["ack_signal"]["in"]},
        oa_s    => {data[coord][Dir.S]["ack_signal"]["in"]},
        oa_sw   => {data[coord][Dir.SW]["ack_signal"]["in"]},
        oa_w    => {data[coord][Dir.W]["ack_signal"]["in"]},

        or_nw   => {data[coord][Dir.NW]["req_signal"]["out"]},
        or_n    => {data[coord][Dir.N]["req_signal"]["out"]},
        or_ne   => {data[coord][Dir.NE]["req_signal"]["out"]},
        or_e    => {data[coord][Dir.E]["req_signal"]["out"]},
        or_se   => {data[coord][Dir.SE]["req_signal"]["out"]},
        or_s    => {data[coord][Dir.S]["req_signal"]["out"]},
        or_sw   => {data[coord][Dir.SW]["req_signal"]["out"]},
        or_w    => {data[coord][Dir.W]["req_signal"]["out"]},

        od_nw   => {data[coord][Dir.NW]["data_signal"]["out"]},
        od_n    => {data[coord][Dir.N]["data_signal"]["out"]},
        od_ne   => {data[coord][Dir.NE]["data_signal"]["out"]},
        od_e    => {data[coord][Dir.E]["data_signal"]["out"]},
        od_se   => {data[coord][Dir.SE]["data_signal"]["out"]},
        od_s    => {data[coord][Dir.S]["data_signal"]["out"]},
        od_sw   => {data[coord][Dir.SW]["data_signal"]["out"]},
        od_w    => {data[coord][Dir.W]["data_signal"]["out"]}
     );
      
   '''

    print(a)


def get_corner_num(coord):
    # -- 0 nw north west
    # -- 1 ne north east
    # -- 2 se south east
    # -- 3 sw south west
    if coord == (0, 0): return 3
    if coord == (0, SIDE-1): return 0
    if coord == (SIDE-1, SIDE-1): return 1
    if coord == (SIDE-1, 0): return 2

def side_to_direction(side, orient):
    # 0 - north
    # 1 - west
    # 2 - south
    # 3 - east
    match side:
        case 0: # NORTH
            match orient:
                case "right": return Dir.W
                case "righto": return Dir.SW
                case "straight": return Dir.S
                case "lefto": return Dir.SE
                case "left": return Dir.E

        case 3: # EAST
            match orient:
                case "right": return Dir.N
                case "righto": return Dir.NW
                case "straight": return Dir.W
                case "lefto": return Dir.SW
                case "left": return Dir.S

        case 2: # SOUTH
            match orient:
                case "right": return Dir.E
                case "righto": return Dir.NE
                case "straight": return Dir.N
                case "lefto": return Dir.NW
                case "left": return Dir.W

        case 1: # WEST
            match orient:
                case "right": return Dir.S
                case "righto": return Dir.SE
                case "straight": return Dir.E
                case "lefto": return Dir.NE
                case "left": return Dir.N


def orientation_to_direction(coord, orient):
    assert orient in ["vertical", "horizontal", "oblique"]

    corner = get_corner_num(coord)
    match corner:
        case 0:
            match orient:
                case "vertical": return Dir.S
                case "horizontal": return Dir.E
                case "oblique": return Dir.SE

        case 1:
            match orient:
                case "vertical": return Dir.S
                case "horizontal": return Dir.W
                case "oblique": return Dir.SW

        case 2:
            match orient:
                case "vertical": return Dir.N
                case "horizontal": return Dir.W
                case "oblique": return Dir.NW

        case 3:
            match orient:
                case "vertical": return Dir.N
                case "horizontal": return Dir.E
                case "oblique": return Dir.NE


def get_side(coord):
    assert not is_coord_corner(coord)
    if coord[0] == 0:
        return 1 # WEST
    if coord[0] == SIDE-1:
        return 3 # EAST
    if coord[1] == 0:
        return 2 # SOUTH
    if coord[1] == SIDE-1:
        return 0 # NORTH
    


def get_side_node_def(coord):

    side = get_side(coord)
    straight = side_to_direction(side, "straight")
    left = side_to_direction(side, "left")
    lefto = side_to_direction(side, "lefto")
    right = side_to_direction(side, "right")
    righto = side_to_direction(side, "righto")

    ret = f'''
    router{coord_to_str(coord)}: entity side_node_top
    generic map( 
        SIDE => {side}
    )
    port map (
        rst => rst,
        ia  => ack_{coord_to_str(coord)}_in,
        ir  => req_{coord_to_str(coord)}_in,
        id  => data_{coord_to_str(coord)}_in,
        oa  => ack_{coord_to_str(coord)}_out,
        orr => req_{coord_to_str(coord)}_out,
        od  => data_{coord_to_str(coord)}_out,
        
        or_straight => {data[coord][straight]["req_signal"]["out"]},
        oa_straight => {data[coord][straight]["ack_signal"]["in"]},
        od_straight => {data[coord][straight]["data_signal"]["out"]},
        
        ir_straight => {data[coord][straight]["req_signal"]["in"]},
        ia_straight => {data[coord][straight]["ack_signal"]["out"]},
        id_straight => {data[coord][straight]["data_signal"]["in"]},
        
        or_left => {data[coord][left]["req_signal"]["out"]},
        oa_left => {data[coord][left]["ack_signal"]["in"]},
        od_left => {data[coord][left]["data_signal"]["out"]},
        
        ir_left => {data[coord][left]["req_signal"]["in"]},
        ia_left => {data[coord][left]["ack_signal"]["out"]},
        id_left => {data[coord][left]["data_signal"]["in"]},
        
        or_right => {data[coord][right]["req_signal"]["out"]},
        oa_right => {data[coord][right]["ack_signal"]["in"]},
        od_right => {data[coord][right]["data_signal"]["out"]},
        
        ir_right => {data[coord][right]["req_signal"]["in"]},
        ia_right => {data[coord][right]["ack_signal"]["out"]},
        id_right => {data[coord][right]["data_signal"]["in"]},
        
        or_lefto => {data[coord][lefto]["req_signal"]["out"]},
        oa_lefto => {data[coord][lefto]["ack_signal"]["in"]},
        od_lefto => {data[coord][lefto]["data_signal"]["out"]},
        
        ir_lefto => {data[coord][lefto]["req_signal"]["in"]},
        ia_lefto => {data[coord][lefto]["ack_signal"]["out"]},
        id_lefto => {data[coord][lefto]["data_signal"]["in"]},
        
        or_righto => {data[coord][righto]["req_signal"]["out"]},
        oa_righto => {data[coord][righto]["ack_signal"]["in"]},
        od_righto => {data[coord][righto]["data_signal"]["out"]},
        
        ir_righto => {data[coord][righto]["req_signal"]["in"]},
        ia_righto => {data[coord][righto]["ack_signal"]["out"]},
        id_righto => {data[coord][righto]["data_signal"]["in"]}
    );
    '''

    print(ret)
    

def get_corner_node_def(coord):

    hori_dir = orientation_to_direction(coord, "horizontal")
    vert_dir = orientation_to_direction(coord, "vertical")
    obli_dir = orientation_to_direction(coord, "oblique")

    ret = f'''
    router{coord_to_str(coord)}: entity corner_node_top
    generic map(
        CORNER => {get_corner_num(coord)}
    )
    port map(
        rst => rst,
        ia  => ack_{coord_to_str(coord)}_in,
        ir  => req_{coord_to_str(coord)}_in,
        id  => data_{coord_to_str(coord)}_in,
        oa  => ack_{coord_to_str(coord)}_out,
        orr => req_{coord_to_str(coord)}_out,
        od  => data_{coord_to_str(coord)}_out,
        
        oa_horizontal => {data[coord][hori_dir]["ack_signal"]["in"]},
        oa_vertical   => {data[coord][vert_dir]["ack_signal"]["in"]},
        oa_oblique    => {data[coord][obli_dir]["ack_signal"]["in"]},
        ia_horizontal => {data[coord][hori_dir]["ack_signal"]["out"]},
        ia_vertical   => {data[coord][vert_dir]["ack_signal"]["out"]},
        ia_oblique    => {data[coord][obli_dir]["ack_signal"]["out"]},
        
        or_horizontal => {data[coord][hori_dir]["req_signal"]["out"]},
        or_vertical   => {data[coord][vert_dir]["req_signal"]["out"]},
        or_oblique    => {data[coord][obli_dir]["req_signal"]["out"]},
        ir_horizontal => {data[coord][hori_dir]["req_signal"]["in"]},
        ir_vertical   => {data[coord][vert_dir]["req_signal"]["in"]},
        ir_oblique    => {data[coord][obli_dir]["req_signal"]["in"]},
        
        od_horizontal => {data[coord][hori_dir]["data_signal"]["out"]},
        od_vertical   => {data[coord][vert_dir]["data_signal"]["out"]},
        od_oblique    => {data[coord][obli_dir]["data_signal"]["out"]},
        id_horizontal => {data[coord][hori_dir]["data_signal"]["in"]},
        id_vertical   => {data[coord][vert_dir]["data_signal"]["in"]},
        id_oblique    => {data[coord][obli_dir]["data_signal"]["in"]}
    );
    '''

    print(ret)


def is_coord_corner(coord):
    return coord in [(0, 0), (0, SIDE-1), (SIDE-1, SIDE-1), (SIDE-1, 0)]


def get_mesh_architecture():
    for elem in nodes:
        if is_coord_corner(elem):
            get_corner_node_def(elem)
        elif is_side(elem):
            get_side_node_def(elem)
        else:
            get_node_def(elem)


def begining():
    print("""
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use work.defs.all;
    use work.router_node_top;
    use work.corner_node_top;
    use work.side_node_top;

    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

    entity router_mesh_top is
        Port (        
            rst : in STD_LOGIC;

    """)

def middle():
    print(""");
          
    end router_mesh_top;

    architecture Behavioral of router_mesh_top is
    """)

def end():
    print()
    print("end Behavioral;")

def main():
    begining()
    get_node_data(print_port_definition=True)
    middle()
    get_node_data(print_internal_signals=True)
    print()
    print("begin")
    print()
    get_mesh_architecture()
    end()



if __name__ == "__main__":
    main()
    # pass

    # run as: python ... | xclip -sel clip
