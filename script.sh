DATABASE="test"
USER="root"
PASSWORD="root"
FILE="/var/backups/mysql/${DATABASE}.$(date +"%m-%d-%Y-%T").sql.gz"
if [ -f "$FILE" ]; then
        echo " backup file  ${FILE} already exists !"
else
        mysqldump -u $USER -p$PASSWORD $DATABASE | gzip > $FILE  && find /var/backups/mysql/. -mtime +29 -exec rm {} \; || echo "Could not generate backup file ${FILE} for database ${DATABASE}"

        if [ -f "$FILE" ]; then
         echo "Generated new mysql backup file ${FILE} for database ${DATABASE}"
           #scp $FILE username@server_ip:/path_to_remote_directory
           #echo "password"
        else
         echo "Could not generate backup file ${FILE} for database ${DATABASE}"
        fi

fi
#description 

#execute mysqldump if everything goes right execute  #find /var/backups/mysql/. -mtime +29 -exec rm {} \; 
#else echo Could not generate backup file 

#find /var/backups/mysql/. -mtime +29 -exec rm {} \; simply deletes every file that is older than 29 days , we only need to keep the last 30 files 

#crontab to execute script everyday at 1 am 
#0 1 * * * /var/backups/script.sh
