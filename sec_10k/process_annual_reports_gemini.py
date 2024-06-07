###########################
#  Process Annual Reports #
###########################

# from datasets import Dataset
from pathlib import Path
import pandas as pd
import re
import os


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
def clean_html(html):
    # First we remove inline JavaScript/CSS:
    cleaned = re.sub(r"(?is)<(script|style).*?>.*?(</\1>)", "", html.strip())

    # Then we remove html comments. This has to be done before removing regular
    # tags since comments can contain '>' characters.
    cleaned = re.sub(r"(?s)<!--(.*?)-->[\n]?", "", cleaned)

    # Next we can remove the remaining tags:
    cleaned = re.sub(r"(?s)<.*?>", " ", cleaned)

    # Finally, we deal with whitespace
    cleaned = re.sub(r"&nbsp;", " ", cleaned)
    cleaned = re.sub(r"  ", " ", cleaned)
    cleaned = re.sub(r"  ", " ", cleaned)
    return cleaned.strip()


# ------------------------------------------------------------------------------
def extract_mda(text):
    mda_text = None

    # obtain the second occurrence of "Discussion and Analysis of Financial Condition" with wildcards
    pattern = r"Discussion[\s,.-]*and[\s,.-]*Analysis[\s,.-]*of[\s,.-]*Financial[\s,.-]*Condition"
    mda_matches = list(re.finditer(pattern, text, re.IGNORECASE))
    if len(mda_matches) >= 2:
        m = mda_matches[1]
        mda_text = text[m.end() :]
        return " ".join(mda_text.split()[:250])
    
    return mda_text


# ------------------------------------------------------------------------------
def main(
    # input_dir: Path = Path("/kellogg/data/EDGAR/10-K/2023"),
    input_dir: Path = Path("/kellogg/proj/plu781/project_consult/workshop_2024summer/klc_fundamental/sec_10k/forms_10-K"),
    output_file: Path = Path("/kellogg/proj/plu781/project_consult/workshop_2024summer/klc_fundamental/sec_10k/annual_report_output.csv"),
    num_files: int = 5,
):
    # validate input parameters
    assert input_dir.exists() and input_dir.is_dir()
    assert num_files > 0
    output_file.touch(exist_ok=True)

    # get listing of 10K files
    files = list(input_dir.glob("*.txt"))[:num_files]
    files.sort()

    # load and clean text, extr
    list_files = []
    list_mda_text = []
    for f in files:
        print(f"loading: {f.name}")
        list_files.append(f.name)

        mda_text = extract_mda(clean_html(f.read_text()))
        if mda_text is None:
            continue
        list_mda_text.append(mda_text)

    # print(data_dict)
    for file, text in zip(list_files, list_mda_text):
        print(f"== Filename: {file}")
        print(f"== MDA text: {text}")

    df = pd.DataFrame({'filename': list_files, 'mda_text': list_mda_text})
    df.to_csv(output_file, index=False)


# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------
if __name__ == "__main__":
    main()
