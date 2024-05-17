
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


def main(option: int, number_times: int = 1):
    counter = 0
    text = ""  # to be written on file

    match option:
        case 1:
            header = get_header((0, 0), (1, 3))
            # works:
            # header = get_header((3, 0), (0, 0))
            # ERROR next ??
            # header = get_header((0, 0), (3, 3))
            # header = get_header((3, 0), (0, 3))

            msg_list = []
            for _ in range(number_times):
                msg_list += [f'{counter:048b}'+header]
                counter += 1
            text = "\n".join(msg_list)
        case _:
            raise Exception("Invalid option")

    file_path = ROOT_PATH + f"test_{option}_x{number_times}.txt"
    with open(file_path, "+w") as f:
        f.write(text)
    print(f"Saved on: {file_path}")

main(1, 5)
