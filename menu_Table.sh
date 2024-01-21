#!/usr/bin/bash

PS3="Select From Table Menu:"
current_db="$1"  # Save the current database in a variable

# Change directory to the script's directory
cd "$(dirname "${BASH_SOURCE[0]}")/.db/$current_db"

select var in "Create table" "List table" "Drop table" "Insert to table" "Select From table" "Delete From table" "Update From table" "Exit"
do 
    case $var in 
        "Create table")
            read -p "Please, Enter table Name : " name

            #check regex  
            name=$(echo "$name" | tr " " "_")
            
            if [[ ! $name =~ ^[0-9] ]]; then
    
                #make name of table :
                touch "${name}"

                #make 3 columns and take the value 
                #so 3 values : 

                #first columns
                read -p "Please, Enter first columns:" id
            
                #second columns 
                read -p "Please, Enter Second Columns:" type
                #third columns 
                read -p "Please, Enter Third columns:" string

                #make variable to save file name with .sh
                source_file="${name}"

                #we must give file mod u+x $source_file
                chmod u+x "${name}"

                #save in file that make with $name with path
                echo "id=\"$id\"" >> "$source_file"
                #now save in file that make #name with path
                echo "type=\"$type\"" >> "$source_file"
                #now save in file that make #name with path
                echo "string=\"$string\"" >> "$source_file"

                #echo file if created
                echo "Table created successfully"

            else
                echo "You entered an invalid name."

            fi
        ;;
        "List table")
            echo "----------------------------"
            ls -l | tr '/' ' '
            echo "----------------------------"
        ;;
        "Drop table")
            echo "-------------------------"
            read -p "Please, Enter table Name : " name
            if [[ -f $name ]]; then
                rm -r "$name"
                echo "Table [$name] deleted..."
            else 
                echo "Sorry, I can't find it."
            fi
            echo "-------------------------"
        ;;
        "Insert to table")
            echo "-------------------------"
            read -p "Please, Enter table Name : " name
            if [[ -f $name ]]; then

                # Here we will make a function to check unique id
                function check_unique_id {
                    local check_id="$id"
                    grep -q "id=\"$check_id\"" "${name}"
                }

                # Here I will make a while loop until entering a unique id
                while true;
                do
                    # first columns
                    read -p "Please, Enter first columns value:" id

                    if check_unique_id "$id"; then
                        echo "ID is not unique. Please enter a unique ID."
                    else
                        break
                    fi 
                done
            
                # second columns 
                read -p "Please, Enter Second Columns value:" type
                # third columns 
                read -p "Please, Enter Third columns value:" string 
            

                # make variable to save file name with .sh
                source_file="${name}"
                
                # save in file that make with $name with path
                echo "id=\"$id\"" >> "$source_file"
                # now save in file that make #name with path
                echo "type=\"$type\"" >> "$source_file"
                # now save in file that make #name with path
                echo "string=\"$string\"" >> "$source_file"

                echo "Values inserted successfully."
                
            else
                echo "Error: Enter the name of an existing table."
            fi
            echo "-------------------------"
        ;;
        "Select From table")
            # read table name you want to Select
            read -p "Please, Enter table Name : " name
            if [[ -f "$name" ]]; then
                # show with cat table selected with number of items
                cat -n "$name" 
                # Extract the line with the specified ID using sed
                read -p "Please, Enter item number : " num
                sed -n "${num}p" "$name"
                echo "You selected item number : $num from table $name"
            else
                echo "Table not found."
            fi
        ;;
        "Delete From table")
            # read name of table
            # select item from table 
            # delete item from table 

            # read table name you want to Select
            read -p "Please, Enter table Name : " name 
            # show with cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Please, Enter item number : " num
            # use sed to extract number line (contents)
            sed -n "${num}p" "$name"
            # delete from table {name} with id {selected}
            # chmod to give access to delete line from file
            chmod u+x "$name" 
            # use sed to delete number with $id and added d to remove
            sed -i "${num}d"  "$name"
            echo "Item number : [ $num ] deleted successfully."
        ;;
        "Update From table")
            # select table name 
            # select item want to update with read 
            # update and after enter make change and save with 
            # same line that records lastly

            # read table name you want to Select
            read -p "Please, Enter table Name : " name 
            # show with cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Please, Enter item number : " num
            # use sed to extract number line (contents)
            sed -n "${num}p" "$name"
            # save old id ${num} in variable
            old_id=$num
            # read new input for data user want to update
            read -p "Please, Enter new data want to update to this line: " new_data
            # use awk with (-v passes variable) to change number content with new and save at the end 
            awk -v id="$old_id" -v new_number="$new_data" '{if(NR==id) print new_number; else print $0}' "$name" > modifiy_file && mv modifiy_file "$name"

            echo "Item number : [ $num ] updated successfully."
        ;;
        "Exit")
            echo "1-Create DB" 
            echo "2-List DB"
            echo "3-Connect DB"
            echo "4-Remove DB"
            echo "5-Exit the Program"
            break # Exit loop
        ;;
        *)
            echo "Wrong Choice"
        ;;
    esac
done
