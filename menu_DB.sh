#!/usr/bin/bash

PS3="Select From Menu: "
PATH=$PATH:~/bash_script


    if [[ -d ././.db ]];
    then
        echo "Already Exist"
        pwd
    else 
        mkdir ./.db
        echo "DB Initiated"
    fi

select var in "Create DB" "List DB" "Connect DB" "Remove DB" "Exit the Program"
do 
    case $var in 
        "Create DB")
            read -p "Enter DB Name : " name
            name=`echo $name | tr " " "_"`
            if [[ ! $name = [0-9]* ]];then
                if [[ -e ./.db/$name ]];then
                    echo "Error Folder Already Exist"
                else 
                    mkdir ./.db/$name 
                fi
            else
                echo "Error PLease Try Again"
            fi
        ;;
        "List DB")
            echo "----------------------------"
            ls -F ./.db | grep / | tr '/' ' '
            echo "----------------------------"
        ;;
        "Connect DB")
                echo "************ Databases ************"
                if [[ -e ./.db ]]; then
                    ls -F ./.db | grep / | tr '/' ' '
                    read -p "Please, Enter DB Name : " name

                    if [[ -d ./.db/$name ]]; then
                        echo "Connecting to $name...."
                        chmod u+rwx ./.db/$name
                        ./menu_Table.sh $name
                        pwd
                    else
                        echo "Database $name does not exist."
                    fi
                fi
        ;;
        "Remove DB")
            ls .db
            read -p "Which Database Do you want to Delete : " dbDeletion
            read -p "if you want to delete for Yes Press Y and No press N : " answer
            if [[ -e ./.db/$dbDeletion ]];then
                if [[ "$answer" == [yY] ]];then
                    rm -r ./.db/$dbDeletion
                    echo "Database Succesfully Deleted"
                else 
                    echo Going Back to menu
                fi
            else 
                echo Database Doesnt Exist
            fi

        ;;
        "Exit the Program")
            echo "Thank For using The Script"
            break # Exit loop
        ;;
        *)
        echo "Invalid Choice"
    esac
done
