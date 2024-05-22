
#   OPTION 1:
# ----------------
#   [ ][ ][ ][4]
#   [ ][ ][3][ ]
#   [ ][2][ ][ ]
#   [1][ ][ ][ ]
#    ^

import random

ROOT_PATH = "/home/mar/DTU/das-24/das-router/"
NODES = []
SIDE = 4
SIDE = 10
for i in range(SIDE):
    for j in range(SIDE):

        if i in range(1,SIDE-1) and j in range(1,SIDE-1):
            continue

        NODES.append((i, j))


def get_header(begin: tuple, end: tuple):
    return f'{begin[1]:04b}{begin[0]:04b}{end[1]:04b}{end[0]:04b}'


def packets(begin: tuple, end: tuple, number_times: int, msg_counter: int) -> tuple[list[str], int]:
    header = get_header(begin, end)
    msg_list = []
    for _ in range(number_times):
        msg_list += [f'{msg_counter:048b}'+header]
        msg_counter += 1
    return msg_list


def five_lines(begin: tuple, end: tuple, counter: int) -> tuple[list[str], int]:
    header = get_header(begin, end)
    msg_list = []
    for _ in range(5):
        msg_list += [f'{counter:048b}'+header]
        counter += 1
    return msg_list


def main(option: int, number_times: int = 1):
    counter = 0
    text = ""  # to be written on file

    match option:
        case 1:
            msg_list = []

            msg_list += five_lines((0, 0), (2, 3), len(msg_list))
            msg_list += five_lines((0, 0), (3, 3), len(msg_list))
            msg_list += five_lines((0, 0), (3, 2), len(msg_list))
            msg_list += five_lines((0, 0), (3, 1), len(msg_list))

            # work:
            msg_list += five_lines((0, 0), (2, 0), len(msg_list))
            msg_list += five_lines((0, 0), (0, 1), len(msg_list))
            msg_list += five_lines((0, 0), (0, 2), len(msg_list))
            msg_list += five_lines((0, 0), (1, 0), len(msg_list))
            msg_list += five_lines((0, 0), (0, 3), len(msg_list))
            msg_list += five_lines((0, 0), (1, 3), len(msg_list))
            msg_list += five_lines((0, 0), (3, 0), len(msg_list))

            text = "\n".join(msg_list)

        case 2:
            msg_list = []
            # no
            # msg_list += five_lines((0, 3), (2, 0), len(msg_list))
            # msg_list += five_lines((0, 3), (3, 0), len(msg_list))
            # msg_list += five_lines((0, 3), (3, 1), len(msg_list))
            # msg_list += five_lines((0, 3), (3, 2), len(msg_list))

            msg_list += five_lines((0, 3), (2, 3), len(msg_list))
            msg_list += five_lines((0, 3), (3, 3), len(msg_list))
            msg_list += five_lines((0, 3), (0, 1), len(msg_list))
            msg_list += five_lines((0, 3), (0, 2), len(msg_list))
            msg_list += five_lines((0, 3), (0, 0), len(msg_list))
            msg_list += five_lines((0, 3), (1, 0), len(msg_list))
            msg_list += five_lines((0, 3), (1, 3), len(msg_list))

            text = "\n".join(msg_list)

        case 3:
            msg_list = []
            # no
            # msg_list += five_lines((3, 3), (0, 1), len(msg_list))
            # msg_list += five_lines((3, 3), (0, 2), len(msg_list))
            # msg_list += five_lines((3, 3), (0, 0), len(msg_list))
            # msg_list += five_lines((3, 3), (1, 0), len(msg_list))

            # the following work:
            msg_list += five_lines((3, 3), (2, 0), len(msg_list))
            msg_list += five_lines((3, 3), (3, 0), len(msg_list))
            msg_list += five_lines((3, 3), (0, 3), len(msg_list))
            msg_list += five_lines((3, 3), (3, 2), len(msg_list))
            msg_list += five_lines((3, 3), (3, 1), len(msg_list))
            msg_list += five_lines((3, 3), (2, 3), len(msg_list))
            msg_list += five_lines((3, 3), (1, 3), len(msg_list))
            text = "\n".join(msg_list)

        case 4:
            msg_list = []
            # no
            # msg_list += five_lines((3, 0), (0, 1), len(msg_list))
            # msg_list += five_lines((3, 0), (0, 2), len(msg_list))
            # msg_list += five_lines((3, 0), (0, 3), len(msg_list))
            # msg_list += five_lines((3, 0), (1, 3), len(msg_list))

            # work:
            msg_list += five_lines((3, 0), (0, 0), len(msg_list))
            msg_list += five_lines((3, 0), (1, 0), len(msg_list))
            msg_list += five_lines((3, 0), (2, 0), len(msg_list))
            msg_list += five_lines((3, 0), (3, 3), len(msg_list))
            msg_list += five_lines((3, 0), (2, 3), len(msg_list))
            msg_list += five_lines((3, 0), (3, 2), len(msg_list))
            msg_list += five_lines((3, 0), (3, 1), len(msg_list))
            text = "\n".join(msg_list)

        case 5:

            # these work:
            msg_list = []
            msg_list += five_lines((0, 1), (0, 0), len(msg_list))
            msg_list += five_lines((0, 1), (0, 3), len(msg_list))
            msg_list += five_lines((0, 1), (1, 3), len(msg_list))
            msg_list += five_lines((0, 1), (2, 3), len(msg_list))
            msg_list += five_lines((0, 1), (3, 3), len(msg_list))
            msg_list += five_lines((0, 1), (3, 2), len(msg_list))
            msg_list += five_lines((0, 1), (3, 1), len(msg_list))
            msg_list += five_lines((0, 1), (3, 0), len(msg_list))
            msg_list += five_lines((0, 1), (2, 0), len(msg_list))
            msg_list += five_lines((0, 1), (1, 0), len(msg_list))
            msg_list += five_lines((0, 1), (0, 2), len(msg_list))

            text = "\n".join(msg_list)

        case 6:

            # these work:
            msg_list = []
            msg_list += five_lines((0, 2), (1, 3), len(msg_list))
            msg_list += five_lines((0, 2), (0, 0), len(msg_list))
            msg_list += five_lines((0, 2), (0, 1), len(msg_list))
            msg_list += five_lines((0, 2), (0, 3), len(msg_list))
            msg_list += five_lines((0, 2), (2, 3), len(msg_list))
            msg_list += five_lines((0, 2), (3, 3), len(msg_list))
            msg_list += five_lines((0, 2), (3, 2), len(msg_list))

            msg_list += five_lines((0, 2), (1, 0), len(msg_list))

            # dont work
            msg_list += five_lines((0, 2), (3, 1), len(msg_list))
            msg_list += five_lines((0, 2), (3, 0), len(msg_list))
            msg_list += five_lines((0, 2), (2, 0), len(msg_list))

            text = "\n".join(msg_list)

        case 7:

            # none of these work
            msg_list = []
            msg_list += five_lines((2, 0), (0, 0), len(msg_list))
            msg_list += five_lines((2, 0), (0, 2), len(msg_list))
            msg_list += five_lines((2, 0), (0, 3), len(msg_list))
            msg_list += five_lines((2, 0), (1, 3), len(msg_list))
            msg_list += five_lines((2, 0), (2, 3), len(msg_list))
            msg_list += five_lines((2, 0), (3, 3), len(msg_list))
            msg_list += five_lines((2, 0), (3, 2), len(msg_list))
            msg_list += five_lines((2, 0), (3, 1), len(msg_list))
            msg_list += five_lines((2, 0), (3, 0), len(msg_list))
            msg_list += five_lines((2, 0), (0, 1), len(msg_list))
            msg_list += five_lines((2, 0), (1, 0), len(msg_list))

            text = "\n".join(msg_list)

        case 8:
            msg_list = []
            for origin in NODES:
                for dest in NODES:
                    if origin == dest:
                        continue

                    #if origin != (3,1): continue

                    #if dest in [(1,3), (2,0)]: continue

                    #if origin ==(3,1) and dest == (1,3):
                    #    continue

                    msg_list += packets(origin, dest,
                                        number_times, len(msg_list))
                    
                    print(origin, dest)

            text = "\n".join(msg_list)

        case 9:
            msg_list = []
            msg_list += five_lines((3, 1), (2, 0), len(msg_list))
            text = "\n".join(msg_list)

        case 10:
            subnodes = [(0,0),(1,0),(2,0), (3,0)]
            # subnodes = NODES
            msg_list = []
            for _ in range(number_times):
                nodes = random.choices(subnodes, k=2)
                # while nodes[0] == nodes[1] or nodes[0][0] == 0 : nodes = random.choices(NODES, k=2)
                while nodes[0] == nodes[1]: nodes = random.choices(subnodes, k=2)
                msg_list += packets(nodes[0], nodes[1], 1, len(msg_list))
                print(nodes)
            text = "\n".join(msg_list)
            

        case _:
            raise Exception("Invalid option")

    # file_path = ROOT_PATH + f"test_{option}_x{number_times}.txt"
    file_path = ROOT_PATH + f"test_1_x{number_times}.txt"
    with open(file_path, "+w") as f:
        f.write(text)
    print(f"Saved on: {file_path}")


main(option=8, number_times=100)

