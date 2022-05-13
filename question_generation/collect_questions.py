import argparse, pathlib, json, operator, contextlib

parser = argparse.ArgumentParser()
parser.add_argument("paths", metavar="FILE", type=pathlib.Path, nargs="+")
parser.add_argument("--out-file", dest="out_path", type=pathlib.Path, required=True)
parser.add_argument("--clean", action="store_true")

args = parser.parse_args()


def get_start_idx(path):
    return int(path.stem.split("_")[-1])


out = {
    "info": {},
    "questions": [],
}

args.paths.sort(key=get_start_idx)

question_dicts = []

for path in args.paths:
    with open(path) as file:
        print(f"Reading {path}")
        question_dicts.append(json.load(file))

split = question_dicts[0]["info"]["split"]
assert all(
    qd["info"]["split"] == split for qd in question_dicts
), "You are mixing splits dawg :-/"

for qd in question_dicts:
    qd["questions"].sort(key=operator.itemgetter("question_index"))

for i, q in enumerate(q for qd in question_dicts for q in qd["questions"]):
    q["question_index"] = i
    out["questions"].append(q)

with open(args.out_path, "w") as out_file:
    print(f"Writing to {args.out_path}")
    json.dump(out, out_file)

if args.clean:
    for path in args.paths:
        path.unlink()
