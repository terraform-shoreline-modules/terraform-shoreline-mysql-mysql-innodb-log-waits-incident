bash

#!/bin/bash


 NEW_FLUSH_LOG_VALUE="PLACEHOLDER"

 NEW_BUFFER_POOL_SIZE="PLACEHOLDER"

 NEW_WRITE_IO_THREADS="PLACEHOLDER"

 MYSQL_CONFIG_FILE_PATH="PLACEHOLDER"

 NEW_LOG_BUFFER_SIZE="PLACEHOLDER"


# Set the MySQL configuration file path

CONFIG_FILE=${MYSQL_CONFIG_FILE_PATH}



# Set the server settings to allocate more resources to the database

sed -i 's/innodb_buffer_pool_size=.*/innodb_buffer_pool_size=${NEW_BUFFER_POOL_SIZE}/' $CONFIG_FILE

sed -i 's/innodb_log_buffer_size=.*/innodb_log_buffer_size=${NEW_LOG_BUFFER_SIZE}/' $CONFIG_FILE

sed -i 's/innodb_flush_log_at_trx_commit=.*/innodb_flush_log_at_trx_commit=${NEW_FLUSH_LOG_VALUE}/' $CONFIG_FILE

sed -i 's/innodb_write_io_threads=.*/innodb_write_io_threads=${NEW_WRITE_IO_THREADS}/' $CONFIG_FILE



# Restart the MySQL service

systemctl restart mysql