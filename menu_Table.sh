#!/usr/bin/bash
PS3="Select From Table:"
cd ~/.db/$1


select var in "Create table" "List table" "Connect table" "Remove table" "Insert to table" "Exit"
do 

  case $var in 
        "Create table")
            read -p "Enter table Name : " name

            #check regex  
            name=`echo $name | tr " " "_"`
            
            if [[ ! $name = [0-9]* ]];then
    
                #make name of table :
                touch "${name}.sh"


                #make 3 columns and take the value 
                #so 3 values : 

                #first columns
                read -p "Enter first columns:" col1
                #second columns 
                read -p "Enter Second Columns:" pk
                #third columns 
                read -p "Enter Third columns:" string

                #make variable to save file name with .sh
                source_file="${name}.sh"

                #we must give file mod u+x $source_file
                chmod u+x "${name}.sh"

                #save in file that make with $name with path
                echo "col1=\"$col1\"" >> "$source_file"
                #now save in file that make #name with path
                echo "pk=\"$pk\"" >> "$source_file"
                #now save in file that make #name with path
                echo "string=\"$string\"" >> "$source_file"


                #if [ -n "$col1" ] && [ -n "$pk" ] && [ -n "$string" ];
                #then
                    #echo file if created
                    echo "table create successfully"

                #fi

                else
                 echo "you enter vaild name"

            fi

        ;;
        "List table")
            echo "----------------------------"
            #ls -F ~/.db | grep / | tr '/' ' '
            echo ~/.db/$1 | ls -l | tr '/' ' '
            echo "----------------------------"
        ;;
        "Connect table")
            read -p "Enter table Name : " name
            if [[ -f ~/.db/$1/$name ]];then
                echo "connect to table $name...."
                #cd ~/.db/$name 
                #source ~/bash_script/menu_Table.sh $name
            fi
        ;;
        "Remove table")
            echo "-------------------------"
            read -p "Enter table Name : " name
            if [[ -f ~/.db/$1/$name ]];then
                rm -r ~/.db/$1/$name
                echo "table [ $name ] deleted..."
            else 
               echo "Sorry I Can't find it"
            fi
            echo "-------------------------"
            
        ;;
         "Insert to table")
            echo "-------------------------"
            read -p "Enter table Name : " name
            if [[ -f ~/.db/$1/$name ]];then
             
             #first columns
                read -p "Enter first columns value:" id
                #second columns 
                read -p "Enter Second Columns value:" pk
                #third columns 
                read -p "Enter Third columns value:" type 
            

                #make variable to save file name with .sh
                source_file="${name}"
                

                #save in file that make with $name with path
                echo "id=\"$id\"" >> "$source_file"
                #now save in file that make #name with path
                echo "pk=\"$pk\"" >> "$source_file"
                #now save in file that make #name with path
                echo "type=\"$type\"" >> "$source_file"

                echo "Values inserted successfully."

               

            else
                echo "Error enter name of file with .sh" 

            fi

            echo "-------------------------"
            
        ;;
        *)
         echo "Default"
        break # Exit loop
    esac
done