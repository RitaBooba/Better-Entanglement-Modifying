import math

textfile = "better-economy-mod/common/buy_packages/00_buy_packages.txt"
with open(textfile, "r") as f:
    lines = f.readlines()

# parameters
a = 4830
b = 10 ** (3/69)

wealth_number = None

def wealth_function(wealth_number):
    if wealth_number <= 10:
        return wealth_number * 0.03
    elif wealth_number <= 25:
        return ((wealth_number - 10) ** (3)) * 0.48
    elif wealth_number <= 45:
        return ((wealth_number - 15) ** (5))
    else:
        return ((wealth_number - 45) ** (6)) * 2

with open(textfile, "w") as f:
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("wealth_"):
            try:
                wealth_number = int(stripped.split("=")[0].split("wealth_")[1].strip())
            except:
                wealth_number = None
            f.write(line)
        elif "political_strength" in stripped and wealth_number is not None:
            indent = line[:line.index("political_strength")]
            ps = round(wealth_function(wealth_number), 2)
            newline = f"{indent}political_strength = {ps}\n"
            f.write(newline)
        else:
            f.write(line)