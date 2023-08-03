if [ ! -z "$buffer_section" ]; then

    sed -i "${buffer_section}s/.*/innodb_log_buffer_size=$buffer_size/" $my_cnf

    echo "Transaction log buffer size updated to $buffer_size bytes"

else

    echo "Transaction log buffer section not found in $my_cnf"

fi