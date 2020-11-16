import sys                              # Support argv.
from urllib.request import urlopen


def fetch_words(url):
    """Fetches a list of words from a URL."""
    story = urlopen(url)
    story_words = []
    for line in story:
        line_words = line.decode('utf-8').split()
        for word in line_words:
            story_words.append(word)
    story.close()
    return story_words


def print_items(items):
    """Displays a list of items."""
    for item in items:
        print(item)


def main(url):
    words = fetch_words(url)
    print_items(words)


# Execute the function immediately if run via the Python command line. If imported from the
# REPL, the name is the module name. If run via the Python command line, the name is main.
#
# Command line:
#   py words.py http://sixty-north.com/c/t.txt
if __name__ == "__main__":
    main(sys.argv[1])
