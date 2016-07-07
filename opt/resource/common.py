import json
import sys
import tempfile


def get_payload():
    payload = json.load(sys.stdin)
    _, fname = tempfile.mkstemp()
    print("Logging payload to {}".format(fname), file=sys.stderr)
    with open(fname, 'w') as fp:
        fp.write(json.dumps(payload))
    return payload
