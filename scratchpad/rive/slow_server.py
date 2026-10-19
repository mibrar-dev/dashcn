#!/usr/bin/env python3
"""Slow a built docs web dir for cold-load capture only (never shipped).

Usage: python3 slow_server.py <dir> <port> [delay_s]
Delays main.dart.js by delay_s (default 6) so the Rive loader is visible
for the whole load. Serves <dir> otherwise normally.
"""
import sys
import time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

def main():
    if len(sys.argv) < 3:
        print("usage: slow_server.py <dir> <port> [delay_s]")
        sys.exit(2)
    root = sys.argv[1]
    port = int(sys.argv[2])
    delay = float(sys.argv[3]) if len(sys.argv) > 3 else 6.0

    class Handler(SimpleHTTPRequestHandler):
        def __init__(self, *args, **kwargs):
            super().__init__(*args, directory=root, **kwargs)

        def do_GET(self):
            if self.path.split("?")[0].endswith("main.dart.js"):
                time.sleep(delay)
            super().do_GET()

        def log_message(self, *args):
            pass

    ThreadingHTTPServer(("127.0.0.1", port), Handler).serve_forever()

if __name__ == "__main__":
    main()
