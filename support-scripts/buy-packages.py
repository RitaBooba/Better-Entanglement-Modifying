import math

textfile = "better-economy-mod/common/buy_packages/00_buy_packages.txt"
with open(textfile, "r") as f:
    lines = f.readlines()

# parameters
a = 4830
b = 10 ** (3/69)

wealth_number = None

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
            ps = round(a * b ** wealth_number)
            newline = f"{indent}political_strength = {ps}\n"
            f.write(newline)
        else:
            f.write(line)