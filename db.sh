#!/usr/bin/bash

PS3=$'---------------------------- \nSelect From Main Menu: '
#PATH=$PATH:~/bash_script


    if [[ -d ././.db ]];
    then
        echo "--------------------------------------------------------"
        echo "Sorry , Dr.Mina <3 ; There is an error, Datbase already exists"
        echo "--------------------------------------------------------"
        echo "Current Directory is: "
        echo "-----------------------"
        pwd
        echo "--------------------------------------------------------"
    else
        echo "--------------------------------------------------------"
        mkdir ./.db
        echo "DB Initiated successfully, Dr.Mina <3"
        echo "--------------------------------------------------------"
    fi

select var in "Create DB" "List DB" "Connect DB" "Remove DB" "Exit"
do 
    case $var in 
        "Create DB")
            echo "--------------------------------------------------------"
            read -p "Please, enter DB name, Dr.Mina <3 : " name
            name=`echo $name | tr " " "_"`
            if [[ ! $name = [0-9]* ]];then
                if [[ -e ./.db/$name ]];then
                    echo "Sorry , Dr.Mina <3 ; There is an error, Folder Already Exist"
                else 
                    mkdir ./.db/$name 
                    chmod u+rwx ./.db/$name
                    echo "DB created successfully, Dr.Mina <3"
                fi
            else
                echo "Sorry , Dr.Mina <3 ; There is an error, Please Try Again"
            fi
        ;;
        "List DB")
            echo "--------------------------------------------------------"
            ls -F ./.db | grep / | tr '/' ' '
        ;;
        "Connect DB")
                echo "************ Existing Databases ************"
                if [[ -e ./.db ]]; then
                    echo "--------------------------------------------------------"
                    ls -F ./.db | grep / | tr '/' ' '
                    echo "--------------------------------------------------------"
                    read -p "Please, enter DB name, Dr.Mina <3 : " name

                    if [[ -d ./.db/$name ]]; then
                        echo "Connecting to $name...."
                        chmod u+rwx ./.db/$name
                        ./table.sh $name
                        pwd
                        echo "--------------------------------------------------------"
                    else
                        echo "Sorry , Dr.Mina <3 ; Database $name doesn't exist."
                        echo "--------------------------------------------------------"
                    fi
                fi
        ;;
        "Remove DB")
            ls .db
            read -p "Which Database Do you want to Delete, Dr.Mina <3 : " dbDeletion
            read -p "Dr.Mina <3 for Yes Press Y and No press N : " answer
            if [[ -e ./.db/$dbDeletion ]];then
                if [[ "$answer" == [yY] ]];then
                    rm -r ./.db/$dbDeletion
                    echo "Database Succesfully Deleted, Dr.Mina <3"
                    echo "--------------------------------------------------------"
                else 
                    echo "Back to main menu, Dr.Mina <3"
                    echo "--------------------------------------------------------"
                fi
            else 
                echo "Database Doesn't exist, Dr.Mina <3"
                echo "--------------------------------------------------------"
            fi

        ;;
        "Exit")
            echo "Thank You, Dr.Mina <3 The best instructor, Engineer and Linux user Ever <3"
            echo "<3 <3 <3"
            break # Exit loop
        ;;
        *)
        echo "Sorry , Dr.Mina <3 ; Invalid Choice"
        echo "--------------------------------------------------------"
    esac
done