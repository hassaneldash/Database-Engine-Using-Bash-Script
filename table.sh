#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Table Menu: '
cd ./.db/$1

select var in "Create table" "List table" "Drop table" "Insert row" "Show data" "Delete row" "Update cell" "Exit"
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
                    touch ./$dbname/$name
                    chmod u+rwx ./$dbname/$name
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
                    done
                    echo "" >> $name.meta
                    echo -n "$datatype" >> $name.meta
                    echo "Table '$name' created successfully, Dr.Mina <3."
                fi
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Invalid name."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;











        "List table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;













        "Drop table")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                    echo 
                    echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                    continue
                fi
            if [[ -f $name ]]; then
                rm -r "$name"
                rm -r "$name.meta"
                echo "Table [$name] deleted successfully, Dr.Mina <3"
            else 
                echo "Sorry , Dr.Mina <3 ; There is an error, Can't find Table."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;










        "Insert row")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi
            source_file="${name}"
            function getDatatype {
                awk -v col="$1" 'NR==2 {split($0, types, ":"); print types[col]}' "$name.meta"
            }
            if [[ -f $name ]]; then
                while true; do
                    read -p "Please, Enter first columns value As PK, Dr.Mina <3: " id
                    is_unique=true
                    # Check uniqueness of ID
                    for field in $(cut -f1 -d: "./$dbname/$name"); do
                        if [[ $field = "$id" ]]; then
                            echo "Sorry, Dr.Mina <3; ID is not unique. Please enter a unique ID."
                            is_unique=false
                            break
                        else is_unique=true
                        fi
                    done
                    if [[ $is_unique == true ]]; then
                        echo -n "$id : " >> "$source_file"
                        for ((i=2; i<=$num_columns; i++)); do
                            read -p "Please, Enter Data for Column $i, Dr.Mina <3: " data
                            if [[ $data == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                                echo
                                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                                continue
                            fi
                            colDatatype=$(getDatatype "$i")
                            case $colDatatype in
                                    "<int> ")
                                        if ! [[ $data =~ ^[0-9]+$ ]]; then
                                            echo "Invalid Datatype, Dr.Mina <3."
                                            continue
                                        fi
                                        ;;
                                    "<str> ")
                                        if [[ $data =~ ^[0-9]+$ ]]; then
                                            echo "Invalid Datatype, Dr.Mina <3."
                                            continue
                                        fi
                                        ;;
                                esac
                            echo -n "$data : " >> "$source_file"
                        done
                        echo " " >> "$source_file"
                        break
                    fi
                done
                echo "Values inserted successfully, Dr.Mina <3."
                
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Please, Enter the name of an existing table."
            fi
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;










        "Show data")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            while true; do
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                        echo 
                        echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                        continue
            fi
            if [[ ! -f $name ]]; then
            echo "Sorry , Dr.Mina <3 ; There is an error, Not Found."
                continue
            fi   
            break
            done

                echo
                echo -e "Dr.Mina <3 ; please choose: "
                echo    "1) Select all columns"
                echo    "2) Select Specific column"
                read choice
                case $choice in
                    1)
                        echo "*********** Table : $name ***********"
                        echo "----------------------------------"
                        awk 'BEGIN{FS=":";OFS="\t |";ORS="\n";}{ $1=$1; print substr($0, 1, length($0)-1) }' "./$name"
                        echo "----------------------------------"
                        ;;
                    2)
                        read -p "Enter the column numbers separated by commas (Example: 1,2,3): " columns
                        echo "*********** Table : $name ***********"

                        awk -v cols="$columns" 'BEGIN{FS=" : "; OFS="\t|"; ORS="\n";}
                        {
                            split(cols, arr, ",");
                            for(i=1; i<=length(arr); i++) {
                                printf "+----------------";
                            }
                            printf "+";
                            printf "\n";
                            for(i=1; i<=length(arr); i++) {
                                printf "|\t"$arr[i]"\t";
                            }
                            printf "|\n";
                        }' "./$name"
                        echo -n "+"
                        for ((i=1; i<=columns; i++)); do
                            echo -n "----------------+"
                        done
                        echo 
                        
                        ;;
                    *)
                        echo -e "Sorry , Dr.Mina <3 ; Invalid Choice"
                        ;;
            esac
            echo
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;




        "Delete row")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                    echo 
                    echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                    continue
                fi
            cat -n "$name" 
            read -p "Please, Enter item number, Dr.Mina <3 : " num
            sed -n "${num}p" "$name"
            chmod u+rwx "$name" 
            sed -i "${num}d"  "$name"
            echo "Item number : [ $num ] deleted successfully, Dr.Mina <3."
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
        ;;









        "Update cell")
            echo "--------------------------------------------------------"
            ls | grep -v '\.meta$' | tr '/' ' '
            echo "--------------------------------------------------------"
            read -p "Please, Enter table Name, Dr.Mina <3 : " name 
            if [[ $name == *['!'@#\$%^\&*()-+\.\/]* ]]; then
                echo 
                echo "! @ # $ % ^ () + . -  are not allowed, Dr.Mina <3 !"
                continue
            fi
            cat -n "$name"
            read -p "Please, enter row number, Dr.Mina <3 : " num
            if ! [[ $num =~ ^[0-9]+$ ]]; then
                echo "Invalid item number, please enter a valid number, Dr.Mina <3."
                continue
            fi
            if (( num < 1 )) || (( num > $(wc -l < "$name") )); then
                echo "Invalid item number, please enter a valid number, Dr.Mina <3."
                continue
            fi
            read -p "Please, enter column number, Dr.Mina <3: " col
            if ! [[ $col =~ ^[0-9]+$ ]]; then
                echo "Invalid column number, please enter a valid number, Dr.Mina <3."
                continue
            fi
            if (( col < 1 )) || (( col > $(awk -F: '{print NF; exit}' "$name") )); then
                echo "Invalid column number, please enter a valid number, Dr.Mina <3."
                continue
            fi
            read -p "Please, Enter new data for row $num and column $col, Dr.Mina <3: " new_data
            awk -v id="$num" -v col="$col" -v new_data="$new_data" '{
                if (NR == id) {
                    # Update the specified column
                    split($0, fields, ":")
                    for (i = 1; i <= length(fields); i++) {
                        if (i == col) {
                            printf "%s", new_data
                        } else {
                            printf "%s", fields[i]
                        }
                        if (i < length(fields)) {
                            printf ":"
                        }
                    }
                    printf "\n"
                } else {
                    # Print other lines as they are
                    print $0
                }
            }' "$name" > modified_file && mv modified_file "$name"
            echo "Row $num, Column $col updated successfully, Dr.Mina <3."
            echo
            echo "--------------------------------------------------------"
            echo "1) Create table       5) Show data"
            echo "2) List table         6) Delete row"
            echo "3) Drop table         7) Update cell"
            echo "4) Insert row         8) Exit"
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