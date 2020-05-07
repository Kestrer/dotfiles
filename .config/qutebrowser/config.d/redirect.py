import operator, re, typing
from urllib.parse import urljoin

from qutebrowser.api import interceptor, message
from PyQt5.QtCore import QUrl

REDIRECT_REGEXES = [
    (
        r"^https://doc\.rust-lang\.org(?:/stable|/beta|/nightly|)/(?:std|alloc|core)",
        r"https://doc.rust-lang.org/stable/std",
    ),
    (
        r"^https://docs\.rs/serde/(?:[^/]+)/",
        r"https://docs.serde.rs/",
    ),
    (
        r"^https://docs\.rs/unicode-(normalization|segmentation|width|xid)/(?:[^/]+)/",
        r"https://unicode-rs.github.io/unicode-\1/",
    ),
]

def int_fn(info: interceptor.Request):
    url = info.request_url.toString()

    subbed = False

    for (regex, replace) in REDIRECT_REGEXES:
        (url, subs) = re.subn(regex, replace, url, 1)
        if subs != 0:
            subbed = True

    if subbed:
        message.info("Redirecting to " + url)
        info.redirect(QUrl(url))

interceptor.register(int_fn)
