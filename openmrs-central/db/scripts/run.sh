#!/bin/sh
#set -ex

if [ ! -d "/run/mysqld" ]; then
        mkdir -p /run/mysqld
fi

if [ -d "$MYSQL_DATA_DIRECTORY" ]; then
        echo 'MySQL data directory exists'
else
        echo 'MySQL data directory does not exist'

  	echo 'Initializing database'
        mkdir -p "$MYSQL_DATA_DIRECTORY"
        mysql_install_db --user=root --datadir="$MYSQL_DATA_DIRECTORY" --rpm
        echo 'Database initialized'

        tfile=$(mktemp)
	echo "The tmp file is $tfile"

  	if [ ! -f "$tfile" ]; then
		echo "The tfile cannot be created"
      		return 1
 	fi
	
	echo "Starting runn command on mysql"

   	echo "USE mysql;" >> $tfile
  	echo "FLUSH PRIVILEGES;" >> $tfile
  	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> $tfile
	echo "UPDATE user SET password=PASSWORD(\"$MYSQL_ROOT_PASSWORD\") WHERE user='root';" >> $tfile
   	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> $tfile
   	echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
   	echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile

  	echo "Running mysql command "
  	cat $tfile

  	/usr/sbin/mysqld --user=root --bootstrap --verbose=0 < "$tfile"
  	rm -f "$tfile"

fi

echo 'Starting server'
exec /usr/sbin/mysqld --user=root --console
