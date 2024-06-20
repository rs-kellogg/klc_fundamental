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
    cleaned = re.sub(r" {2,}", " ", cleaned)

    # # Remove lines with only whitespaces
    # cleaned = re.sub(r"\n\s{1,}\n", "\n", cleaned)

    return cleaned.strip()


# ------------------------------------------------------------------------------
def extract_mda(text):
    mda_text = None

    # Obtain the second occurrence of "Discussion and Analysis of Financial Condition" with wildcards
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
    input_dir: Path = Path("./data/raw"),
    output_file: Path = Path("./data/annual_report_output.csv"),
    num_files: int = 5,
):
    # Validate input parameters
    assert input_dir.exists() and input_dir.is_dir()
    assert num_files > 0
    output_file.touch(exist_ok=True)

    # Get listing of 10K files
    files = list(input_dir.glob("*.txt"))[:num_files]
    files.sort()

    # Load and clean text
    list_files = []
    list_mda_text = []
    for f in files:
        print(f"loading: {f.name}")

        clean_text = clean_html(f.read_text())
        clean_text_file = output_file.parent / (f.stem + "_cleaned.txt")
        with open(clean_text_file, "w") as f_out:
            f_out.write(clean_text)

        mda_text = extract_mda(clean_text)
        if mda_text is None:
            continue

        list_files.append(f.name)
        list_mda_text.append(mda_text)

    df = pd.DataFrame({'filename': list_files, 'mda_text': list_mda_text})
    df.to_csv(output_file, index=False)


# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------
if __name__ == "__main__":
    main()
