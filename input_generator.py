
#   OPTION 1:
# ----------------
#   [ ][ ][ ][4]
#   [ ][ ][3][ ]
#   [ ][2][ ][ ]
#   [1][ ][ ][ ]
#    ^

ROOT_PATH = "/home/mar/DTU/das-24/das-router/"


def get_header(begin: tuple, end: tuple):
    return f'{begin[1]:04b}{begin[0]:04b}{end[1]:04b}{end[0]:04b}'


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
            # work:
            msg_list += five_lines((0, 0), (2, 0), len(msg_list))
            msg_list += five_lines((0, 0), (0, 1), len(msg_list))
            msg_list += five_lines((0, 0), (0, 2), len(msg_list))
            msg_list += five_lines((0, 0), (1, 0), len(msg_list))
            msg_list += five_lines((0, 0), (0, 3), len(msg_list))
            msg_list += five_lines((0, 0), (1, 3), len(msg_list))
            msg_list += five_lines((0, 0), (3, 0), len(msg_list))
            
            # really don't work (even alone)
            #msg_list += five_lines((0, 0), (2, 3), len(msg_list))
            #msg_list += five_lines((0, 0), (3, 3), len(msg_list))
            #msg_list += five_lines((0, 0), (3, 2), len(msg_list))
            #msg_list += five_lines((0, 0), (3, 1), len(msg_list))
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
            msg_list += five_lines((3, 3), (0, 0), len(msg_list))
            # msg_list += five_lines((3, 3), (1, 0), len(msg_list))

            # the following work:
            # msg_list += five_lines((3, 3), (2, 0), len(msg_list))
            # msg_list += five_lines((3, 3), (3, 0), len(msg_list))
            # msg_list += five_lines((3, 3), (2, 3), len(msg_list))
            # msg_list += five_lines((3, 3), (0, 3), len(msg_list))
            # msg_list += five_lines((3, 3), (3, 2), len(msg_list))
            # msg_list += five_lines((3, 3), (3, 1), len(msg_list))
            # msg_list += five_lines((3, 3), (2, 3), len(msg_list))
            # msg_list += five_lines((3, 3), (1, 3), len(msg_list))
            text = "\n".join(msg_list)

        case 4:
            msg_list = []
            # no
            # msg_list += five_lines((3, 0), (0, 1), len(msg_list))
            # msg_list += five_lines((3, 0), (0, 2), len(msg_list))
            # msg_list += five_lines((3, 0), (0, 3), len(msg_list))
            # msg_list += five_lines((3, 0), (1, 3), len(msg_list))

            msg_list += five_lines((3, 0), (0, 0), len(msg_list))
            msg_list += five_lines((3, 0), (1, 0), len(msg_list))
            msg_list += five_lines((3, 0), (2, 0), len(msg_list))
            msg_list += five_lines((3, 0), (3, 3), len(msg_list))
            msg_list += five_lines((3, 0), (2, 3), len(msg_list))
            msg_list += five_lines((3, 0), (3, 2), len(msg_list))
            msg_list += five_lines((3, 0), (3, 1), len(msg_list))
            msg_list += five_lines((3, 0), (2, 3), len(msg_list))
            text = "\n".join(msg_list)


        case _:
            raise Exception("Invalid option")

    # file_path = ROOT_PATH + f"test_{option}_x{number_times}.txt"
    file_path = ROOT_PATH + f"test_1_x{number_times}.txt"
    with open(file_path, "+w") as f:
        f.write(text)
    print(f"Saved on: {file_path}")


main(3
     , 5)
