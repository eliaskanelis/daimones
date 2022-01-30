#!/bin/sh

text="
SSH login was successful, so here are some information for security:
  User:         ${PAM_USER}
  User IP Host: ${PAM_RHOST}
  Service:      ${PAM_SERVICE}
  TTY:          ${PAM_TTY}
  Date:         $(date)
  Server:       $(uname -a)
"

if [ "${PAM_TYPE}" = "open_session" ]; then
	/usr/local/bin/msg "${text}"
fi

exit 0
