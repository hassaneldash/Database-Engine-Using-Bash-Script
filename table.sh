#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Table Menu: '
cd ./.db/$1

select var in "Create table" "List table" "Drop table" "Insert to table" "Select From table" "Delete From table" "Update From table" "Exit"
do 
    case $var in 
        "Create table")

            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi
            name=`echo "$name" | tr " " "_"`
            if [[ $name =~ ^[a-zA-Z_]+$  ]]; then
                if [[ -f ./$dbname/$name ]]; then
                    echo "Sorry , Dr.Mina <3 ; There is an error, Table '$name' Already Exists."
                else 
                    read -p "Please, Enter Count Columns, Dr.Mina <3: " num_columns
                    touch ./$dbname/$name  ## ../$name/$name.meta
                    chmod u+rwx ./$dbname/$name  ##../$name/$name.meta
                    arr=()
                    for ((i=1; i<=$num_columns; i++)); do
                        read -p "Please,Enter Column [$i] Name, Dr.Mina <3: " col
                        select data in "Integer" "String"
                        do
                            case $data in
                                "Integer" ) datatype+="<int> :"; break;;
                                "String" ) datatype+="<str> :"; break;;
                                * ) 
                echo "Sorry , Dr.Mina <3 ; Invalid Choice"
                echo "--------------------------------------------------------";;
                            esac
                        done
                    echo -n " $col : " >> $name.meta 
                    echo -n " $col : " >> $name 
                    done

                    echo "" >> $name.meta 
                    echo "" >> $name 
                    echo -n "$datatype" >> $name.meta 
            
                    echo "Table '$name' created successfully, Dr.Mina <3."
                fi
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Invalid name."
            fi
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"

        ;;
        "List table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Drop table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                    echo 
                    echo "! @ # $ % ^ () + . -  are not allowed!"
                    continue
                fi
            if [[ -f $name ]]; then
                rm -r "$name"
                rm -r "$name.meta"
                echo "Table [$name] deleted successfully, Dr.Mina <3"
            else 
                echo "Sorry , Dr.Mina <3 ; There is an error, Can't find Table."
            fi
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Insert to table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed!"
                continue
            fi
            source_file="${name}"
            if [[ -f $name ]]; then

                # Here I will make a while loop until entering a unique id
                # make variable to save file name with .sh
                while true; do
                    # first columns
                    read -p "Please, Enter first columns value As PK, Dr.Mina <3: " id

                    is_unique=true

                    # Check uniqueness of ID
                    for field in $(cut -f1 -d: "./$dbname/$name"); do
                        if [[ $field = "$id" ]]; then
                            echo "Sorry, Dr.Mina <3; ID is not unique. Please enter a unique ID."
                            is_unique=false
                            break
                        fi
                    done

                    if [[ $is_unique == true ]]; then
                        echo -n "$id : " >> "$source_file"
                        for ((i = 2; i <= num_columns; i++)); do
                            read -p "Please, Enter Data for Column $i, Dr.Mina <3: " data
                            echo -n "$data : " >> "$source_file"
                        done
                        echo " " >> "$source_file"
                        echo "Values inserted successfully, Dr.Mina <3."
                        break
                    fi
                done
                echo "Values inserted successfully, Dr.Mina <3."
                
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Please, Enter the name of an existing table."
            fi
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Select From table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            # read table name you want to Select
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed!"
                continue
            fi
            if [[ -f "$name" ]]; then
                # show with cat table selected with number of items
                cat -n "$name" 
                # Extract the line with the specified ID using sed
                read -p "Please, Enter item number, Dr.Mina <3 : " num
                sed -n "${num}p" "$name"
                echo "You selected item number : $num from table $name, Dr.Mina <3"
            else
                echo "Sorry , Dr.Mina <3 ; Table not found."
            fi
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Delete From table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            # read name of table
            # select item from table 
            # delete item from table 

            # read table name you want to Select
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                    echo 
                    echo "! @ # $ % ^ () + . -  are not allowed!"
                    continue
                fi
            # show with cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Please, Enter item number, Dr.Mina <3 : " num
            # use sed to extract number line (contents)
            sed -n "${num}p" "$name"
            # delete from table {name} with id {selected}
            # chmod to give access to delete line from file
            chmod u+rwx "$name" 
            # use sed to delete number with $id and added d to remove
            sed -i "${num}d"  "$name"
            echo "Item number : [ $num ] deleted successfully, Dr.Mina <3."
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Update From table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            # select table name 
            # select item want to update with read 
            # update and after enter make change and save with 
            # same line that records lastly

            # read table name you want to Select
            read -p "Please, Enter table Name, Dr.Mina <3 : " name 
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed!"
                continue
            fi
            # show with cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Please, Enter item number, Dr.Mina <3 : " num
            # use sed to extract number line (contents)
            sed -n "${num}p" "$name"
            # save old id ${num} in variable
            old_id=$num
            # read new input for data user want to update
            read -p "Please, Enter new data want to update to this line, Dr.Mina <3: " new_data
            # use awk with (-v passes variable) to change number content with new and save at the end 
            awk -v id="$old_id" -v new_number="$new_data" '{if(NR==id) print new_number; else print $0}' "$name" > modifiy_file && mv modifiy_file "$name"

            echo "Item number : [ $num ] updated successfully, Dr.Mina <3."
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Select From table"
            echo "2) List table         6) Delete From table"
            echo "3) Drop table         7) Update From table"
            echo "4) Insert to table    8) Exit"
        ;;
        "Exit")
            echo "1-Create DB" 
            echo "2-List DB"
            echo "3-Connect DB"
            echo "4-Remove DB"
            echo "5-Exit"
            break
        ;;
        *)
            echo "Sorry , Dr.Mina <3 ; Wrong Choice"
        ;;
    esac
done
