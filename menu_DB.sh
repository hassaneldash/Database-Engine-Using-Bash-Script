#!/usr/bin/bash

PS3="Select From Menu: "
PATH=$PATH:~/bash_script
    # if [[ -d ~/.db ]];
    # then
    #     echo "Aleardy Exist"
    # else 
    #     mkdir ~/.db
    # fi

select var in "Create DB" "List DB" "Connect DB" "Remove DB"
do 
    case $var in 
        "Create DB")
            read -p "Enter DB Name : " name
            name=`echo $name | tr " " "_"`
            if [[ ! $name = [0-9]* ]];then
                if [[ -e ~/.db/$name ]];then
                    echo "Error Folder Already Exist"
                else 
                    mkdir ~/.db/$name 
                fi
            else
                echo "Error PLease Try Again"
            fi
        ;;
        "List DB")
            echo "----------------------------"
            ls -F ~/.db | grep / | tr '/' ' '
            echo "----------------------------"
        ;;
        "Connect DB")
            read -p "Enter DB Name : " name
            if [[ -d ~/.db/$name ]];then
                echo "connect to $name...."
                #cd ~/.db/$name 
                source ~/bash_script/menu_Table.sh $name
            fi
        ;;
        "Remove DB")
            echo "-------------------------"
            read -p "Enter DB Name : " name
            if [[ -d ~/.db/$name ]];then
                rm -r ~/.db/$name
                echo "DB [ $name ] deleted..."
            else 
               echo "Sorry I Can't find it"
            fi
            echo "-------------------------"
        ;;
        *)
         echo "exit"
        break # Exit loop
    esac
done
