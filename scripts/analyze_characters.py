#!/usr/bin/env python

# Export my Anki deck 中文词汇 as notes in plain text and make sure every box is unchecked.
# Then run `./analyze_characters.py < 中文词汇.txt`
#
# This assumes that stdin is a TSV file where the first column is the vocabulary in Chinese characters

import argparse
import sys


# This is shamelessly stolen from
# https://stackoverflow.com/questions/30069846/how-to-find-out-chinese-or-japanese-character-in-a-string-in-python
RANGES = [
  {"from": ord(u"\u3300"), "to": ord(u"\u33ff")},         # compatibility ideographs
  {"from": ord(u"\ufe30"), "to": ord(u"\ufe4f")},         # compatibility ideographs
  {"from": ord(u"\uf900"), "to": ord(u"\ufaff")},         # compatibility ideographs
  {"from": ord(u"\U0002F800"), "to": ord(u"\U0002fa1f")}, # compatibility ideographs
  {'from': ord(u'\u3040'), 'to': ord(u'\u309f')},         # Japanese Hiragana
  {"from": ord(u"\u30a0"), "to": ord(u"\u30ff")},         # Japanese Katakana
  {"from": ord(u"\u2e80"), "to": ord(u"\u2eff")},         # cjk radicals supplement
  {"from": ord(u"\u4e00"), "to": ord(u"\u9fff")},
  {"from": ord(u"\u3400"), "to": ord(u"\u4dbf")},
  {"from": ord(u"\U00020000"), "to": ord(u"\U0002a6df")},
  {"from": ord(u"\U0002a700"), "to": ord(u"\U0002b73f")},
  {"from": ord(u"\U0002b740"), "to": ord(u"\U0002b81f")},
  {"from": ord(u"\U0002b820"), "to": ord(u"\U0002ceaf")}  # included as of Unicode 8.0
]

def is_cjk(char):
  return any([rng["from"] <= ord(char) <= rng["to"] for rng in RANGES])


# Print out all hanzi "known" in sorted order with some stats
def known():
    known_hanzi = set()
    for line in sys.stdin:
        if line.startswith("#"):
            # Ignore comments
            continue
        word, _ = line.split("\t", 1)
        known_hanzi.update(filter(is_cjk, word))
    known_hanzi = sorted(known_hanzi)

    print("Num. characters known:", len(known_hanzi))
    print("All 'known' characters:")
    print("".join(known_hanzi))


# Print out all characters known in order that they show up in the input
# This is for use with https://www.chinesecalligrapher.com/
def worksheet():
    # There are 10 characters per sheet and in my experience the app starts struggling
    # around 50+ pages. So I do 28 pages at a time since that's 8 weeks worth of worksheets if I do one every day
    BATCH_SIZE = 560
    seen = set()
    hanzi_list = list()
    for line in sys.stdin:
        if line.startswith("#"):
            continue
        word, _ = line.split("\t", 1)
        for char in word:
            if is_cjk(char) and char not in seen:
                if len(hanzi_list) == BATCH_SIZE:
                    print("".join(hanzi_list))
                    hanzi_list.clear()
                hanzi_list.append(char)
                seen.add(char)

    print("".join(hanzi_list))
    hanzi_list.clear()



if __name__ == "__main__":
    parser = argparse.ArgumentParser("analyze characters")
    parser.add_argument("command")
    args = parser.parse_args()

    cmd = args.command
    if cmd == "known":
        known()
    elif cmd == "worksheet":
        worksheet()
    else:
        print(f"Unknown command '{cmd}'")
        sys.exit(1)
