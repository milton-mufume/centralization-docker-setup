BASH_ENV=/etc/profile.d/automated_bkp_env.sh
SHELL=/bin/bash

*/2 * * * * $HOME_DIR/db/scripts/mgt_bkp_db.sh
