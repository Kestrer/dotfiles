import re

from qutebrowser.api import interceptor, message
from PyQt5.QtCore import QUrl

REDIRECT_REGEXES = [
    (
        r"^https://doc\.rust-lang\.org(?!/stable/std)(?:/stable|/beta|/nightly|)/(?:std|alloc|core(?!/arch))",
        r"https://doc.rust-lang.org/stable/std",
    ),
    (
        r"^https://docs\.serde\.rs/(erased_serde|serde|serde_bytes|serde_derive|serde_json|serde_test|serde_transcode|serde_yaml)/",
        r"https://docs.rs/\1/*/\1/",
    ),
    (
        r"^https://unicode-rs\.github\.io/unicode-(normalization|segmentation|width|xid)/",
        r"https://docs.rs/unicode-\1/*/",
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
