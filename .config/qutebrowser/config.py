from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

config.load_autoconfig()
config.source('config.d/redirect.py')
