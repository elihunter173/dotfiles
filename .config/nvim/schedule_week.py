#!/usr/bin/env python3

# Use via `:.-1read !this_script_path`

import argparse
import datetime


if __name__ == "__main__":
    now = datetime.date.today()
    monday = now - datetime.timedelta(days=now.weekday())
    sunday = monday + datetime.timedelta(days=6)
    print(f"# {monday} - {sunday}")
    print(f"F:\nH:\nW:\nT:\nM:\n")
