###################################
### Automate Cleaning a Dataset ###
###################################

#load libraries
import pandas as pd
from pathlib import Path


#######################
# Individualzied Fixes
#######################
def clean_form2000(filename, output_file):
    # Read in one file
    df_ir = pd.read_csv(filename, encoding='utf8')

    # Change one Value - The interest rate in April 2021 is off by a decimal
    print(df_ir.iloc[10,3])
    df_ir.iloc[10,3] = 7.8
    print(df_ir.iloc[10,3])

    # Remove an Extra Header Row
    print(df_ir.iloc[6,])
    df_ir = df_ir.drop(index=6)
    print(df_ir.iloc[6,])

    # Change NDs to NAs
    print(df_ir.iloc[22,4])
    df_ir.iloc[22,4] = pd.NA
    print(df_ir.iloc[22,4])

    # Save Results to another file
    df_ir.to_csv(output_file, index=False)

    return


def clean_form(filename, output_file):
    # Read in one File
    df_ir = pd.read_csv(filename, encoding='utf8')

    # Remove an Extra Header Row
    df_ir = df_ir[df_ir.Month != 'Month']

    # Change one Value - The interest rate in April 2021 is off by a decimal
    df_ir['Prime_Rate'] = df_ir['Prime_Rate'].astype('float')
    df_ir.loc[df_ir['Prime_Rate'] < 1, 'Prime_Rate'] = df_ir['Prime_Rate'] * 10

    # Change NDs to NAs
    df_ir.loc[df_ir['Treasury_Rate_3_Month'] == "ND", 'Treasury_Rate_3_Month'] = pd.NA

    # # Split the Month and Year into separate columns
    # df_ir['Year'] = df_ir['Month'].str.split('-', expand=True)[0]
    # df_ir['Month'] = df_ir['Month'].str.split('-', expand=True)[1]
    # # Reorder column names to start with Year and Month
    # new_col_order = ['Year'] + df_ir.columns[:-1].tolist()
    # df_ir = df_ir[new_col_order]

    # Save Results to another file
    if output_file.exists():
        df_ir.to_csv(output_file, index=False, mode='a', header=False)
    else:
        df_ir.to_csv(output_file, index=False)
    return


if __name__ == "__main__":
    workdir = Path("./data/raw")
    outdir = Path("./data")
    
    file = workdir / "ir2000.csv"
    output_file = outdir / (file.stem + "_new.csv")
    clean_form2000(file, output_file)

    file_list = list(workdir.glob("*.csv"))
    file_list.sort()
    output_file = outdir / "ir_all.csv"
    for file in file_list:
        clean_form(file, output_file)

