from optparse import OptionParser
from os import listdir
from os.path import isfile, join
import re
import sys

"""
A python script template for to demonstrate reading arguments and processing a
directory.
"""

def parse_options():
    parser = OptionParser()
    parser.add_option(
        "--source-dir",
        dest="source_dir",
        default=None,
        type="string",
        help="Source directory",
    )
    opt, args = parser.parse_args()
    if not opt.source_dir:
        sys.exit(
            "Error: You need to supply a directory name using the --source-dir argument."
        )
    return opt


def get_all_files_from_directory(directory):
    files = []
    onlyfiles = [f for f in listdir(directory) if isfile(join(directory, f))]
    for f in onlyfiles:
        full_path = join(directory, f)
        files.append(full_path)
    return files


def process_a_file(filename):
    content = open(filename).read()
    print("doing something with content: %s" % content[:20])
    paragraphs = extract_html_paragraphs(content)
    print("got %d html paragraphs from %s" % (len(paragraphs), filename))
    if len(paragraphs) > 0:
        print("first paragraph is %s..." % paragraphs[0][20:])


def extract_html_paragraphs(content):
    """Extract all html paragraphs from a string"""
    para_regex = re.compile("""<p>.*?</p>""", re.DOTALL)
    para_matches = para_regex.findall(content)
    matches_only = [p[3:-4] for p in para_matches]
    return matches_only


def test_extract_html_paragraphs():
    assert extract_html_paragraphs("start<p>value 1</p>")[0] == "value 1"
    assert extract_html_paragraphs("<p>value 1</p><p>value 2</p>")[1] == "value 2"
    assert extract_html_paragraphs("<p>value\n 1</p>")[0] == "value\n 1"


if __name__ == "__main__":
    opt = parse_options()
    files = get_all_files_from_directory(opt.source_dir)
    for f in files:
        process_a_file(f)
