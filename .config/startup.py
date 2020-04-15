import atexit
import os
import readline

if 'XDG_CACHE_HOME' in os.environ:
    cache = os.environ['XDG_CACHE_HOME']
else:
    cache = os.path.join(os.path.expanduser('~'), '.cache')

histfile = os.path.abspath(os.path.join(cache, 'python', 'python_history'))
_dir, _ = os.path.split(histfile)
os.makedirs(_dir, exist_ok=True)

try:
    readline.read_history_file(histfile)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, 'wb').close()
    h_len = 0

def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)
atexit.register(save, h_len, histfile)
