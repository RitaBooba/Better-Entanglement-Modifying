goods = ["wood", "iron", "coal", "lead", "sulfur", "gold", "rubber", "oil"]

files = ["better-economy-mod/common/production_methods/zz_bem_mines.txt", "better-economy-mod/common/production_methods/zz_bem_misc_resource.txt"]

multiplier = 2

import re

# find anything with goods_output_{good}_add = {number} in the files
# replace {number} with {number} * multiplier

def adjust_goods_output():
    for file in files:
        with open(file, "r") as f:
            lines = f.readlines()

        with open(file, "w") as f:
            for line in lines:
                match = re.search(r"goods_output_(\w+)_add\s*=\s*([\d.]+)", line)
                if match:
                    good = match.group(1)
                    number = float(match.group(2))
                    if good in goods:
                        new_number = number * multiplier
                        line = re.sub(r"goods_output_(\w+)_add\s*=\s*[\d.]+", f"goods_output_{good}_add = {new_number:.0f}", line)
                f.write(line)

if __name__ == "__main__":
    adjust_goods_output()
    print("Goods output adjusted in the specified files.")