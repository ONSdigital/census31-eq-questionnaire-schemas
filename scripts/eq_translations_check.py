import logging
import sys

import eq_translations
import requests
from requests.exceptions import RequestException

logger = logging.getLogger(__name__)

try:
    response = requests.get(
        "https://api.github.com/repos/ONSdigital/census31-eq-translations/releases", timeout=120
    )
    if response.status_code == 200:
        version = f"v{eq_translations.__version__}"
        latest_tag = response.json()[0]["tag_name"]
        if latest_tag != version:
            latest_tag_with_prefix = r"\#" + latest_tag
            logger.error(
                f"census31-eq-translations is out of date. Update using: "
                f"'poetry add git+https://github.com/ONSDigital/census31-eq-translations{latest_tag_with_prefix}'"
            )
            sys.exit(1)
    else:
        logger.error("Can't check census31-eq-translations version")
        sys.exit(0)

except RequestException:
    logger.error("Can't check census31-eq-translations version")
    sys.exit(0)
