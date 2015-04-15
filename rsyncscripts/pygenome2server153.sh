#!/bin/sh
rsync -vaH --progress --delete /Users/wubin/Sites/pygenome -e ssh root@211.64.140.153:/var/www/
