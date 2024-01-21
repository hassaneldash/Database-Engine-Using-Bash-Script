#!/usr/bin/bash
PS3="Select From Table Menu:"
cd ./.db/$1


select var in "Create table" "List table" "Drop table" "Insert to table" "Select From table" "Delete From table" "Update From table"  "Exit"
do 

  case $var in 
        "Create table")
            read -p "Enter table Name : " name

            #check regex  
            name=`echo $name | tr " " "_"`
            
            if [[ ! $name = [0-9]* ]];then
    
                #make name of table :
                touch "${name}"

                #make 3 columns and take the value 
                #so 3 values : 

                #first columns
                read -p "Enter first columns:" id
            
            
                #second columns 
                read -p "Enter Second Columns:" type
                #third columns 
                read -p "Enter Third columns:" string

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
                echo "table create successfully"

            else
                 echo "you enter vaild name"

            fi

        ;;
        "List table")
            echo "----------------------------"
            echo ./.db/$1 | ls -l | tr '/' ' '
            echo "----------------------------"
        ;;
        "Drop table")
            echo "-------------------------"
            read -p "Enter table Name : " name
            if [[ -f $name ]];then
                rm -r $name
                echo "table [ $name ] deleted..."
            else 
               echo "Sorry I Can't find it"
            fi
            echo "-------------------------"
            
        ;;
         "Insert to table")
            echo "-------------------------"
            read -p "Enter table Name : " name
            if [[ -f $name ]];then

             #Here we will make function to check unique id
                function check_unique_id {
                     local check_id="$id"
                      grep -q "id=\"$check_id\"" "${name}"
                }

        
             
            #Here i will make while loop until enter success id
            while true;
            do
            #first columns
            read -p "Enter first columns value:" id

            if check_unique_id "$id";then
                echo "ID is not unique. Please enter a unique ID."
            else
                break
            fi 
            done
             
                #second columns 
                read -p "Enter Second Columns value:" type
                #third columns 
                read -p "Enter Third columns value:" string 
            

                #make variable to save file name with .sh
                source_file="${name}"
                

                #save in file that make with $name with path
                echo "id=\"$id\"" >> "$source_file"
                #now save in file that make #name with path
                echo "type=\"$type\"" >> "$source_file"
                #now save in file that make #name with path
                echo "string=\"$string\"" >> "$source_file"

                echo "Values inserted successfully."
                

            else
                echo "Error enter name of file with .sh" 

            fi

            echo "-------------------------"
            
        ;;

         "Select From table")
            #read table name you want to Select
            read -p "Enter table Name : " name
            if [[ -f ~/.db/$1/$name ]];then
                
                #show tih cat table selected with number of items
                cat -n "$name" 
                # Extract the line with the specified ID using sed
                read -p "Enter item number : " num
                sed -n "${num}p" $name
                echo "you select item number : $num from table $name"

            fi
        ;;
        "Delete From table")

            #read name of table
            #select item from table 
            #delete item from table 

             #read table name you want to Select
            read -p "Enter table Name : " name 
            #show tih cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Enter item number : " num
            #use sed to extract number line (contents)
            sed -n "${num}p" $name
            #delete from table {name} with id {selected}
            #chmod to give access to delete line from file
            chmod u+x ~/.db/$1/$name 
            #use sed to delete number with $id and added d to remove
            sed -i "${num}d"  "${name}"
            echo "item number : [ $num ] is delete successfully."


        ;;
        "Update From table")

            #select table name 
            #select item want to update with read 
            #update and after enter enter make change and save with 
            #same line that record lastly
            
            #read table name you want to Select
            read -p "Enter table Name : " name 
            #show tih cat table selected with number of items
            cat -n "$name" 
            # Extract the line with the specified ID using sed
            read -p "Enter item number : " num
            #use sed to extract number line (contents)
            sed -n "${num}p" $name
            #save old id ${num} in variable
            old_id=$num
            #read new input for data user want to update
            read -p "Enter new data want to update to this line: " new_data
            #use awk with (-v passes variable) to change number content with new and save at the end 
            awk -v id="$old_id" -v new_number="$new_data" '{if(NR==id) print new_number; else print $0}' "$name" > modifiy_file && mv modifiy_file "$name"

        
        echo "item number : [ $num ] is updated successfully."



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