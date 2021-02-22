#!/bin/bash
cat << "EOF"
####################################################################################
####################################################################################
###                                                                              ###
####       Author: BOUJNAH AMINE                                                ####
#####      Email: amine.boujnah@outlook.fr                                     #####
#####      Description: This Script is for Backups Process (MYSQL, DOCKER)     #####
####       Version 0.1                                                          ####
###                                                                              ###
####################################################################################
####################################################################################
EOF

DOCKER_FN()
{
  PS3='Please enter your choice: '
  options=("1 - Backup VOLUMES" "2 - Backup IMAGES" "Quit")
  backup_path="/root/DEVOPS/backups"
  tar_opts="--exclude='/var/run/*'"
  select opt in "${options[@]}"
  do
      case $opt in
          "1 - Backup VOLUMES")
              echo "Backup Processing ..."
              for i in `docker inspect --format='{{.Name}}' $(docker ps -q) | cut -f2 -d\/`  
                do container_name=$i
                mkdir -p $backup_path/$container_name
                echo -n "$container_name - "
                docker run --rm \
                --volumes-from $container_name \
                -v $backup_path:/backup \
                -e TAR_OPTS="$tar_opts" \
                piscue/docker-backup \
                backup "$container_name/$container_name-volume.tar.xz"
                echo "INFO : Process finish !"
              done
              break
              ;;

          "2 - Backup IMAGES")
              echo "Backup Processing ..."
              for i in `docker inspect --format='{{.Name}}' $(docker ps -q) | cut -f2 -d\/`  
                do container_name=$i
                echo -n "$container_name - "
                container_image=`docker inspect --format='{{.Config.Image}}' $container_name`
                mkdir -p $backup_path/$container_name
                save_file="$backup_path/$container_name/$container_name-image.tar"
                docker save -o $save_file $container_image
                echo "INFO : Process finish !"
              done
              break
              ;;
          "Quit")
              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done
}


MYSQL_FN() 
{
  echo "FILL Required options to begin BACKUP process ! :"
  read -p '1 - Backups DIR : ' OUTPUT_DIR
  read -p '2 - DB HOSTNAME : ' HOST
  read -p '3 - DB USER : ' USER
  read -sp '4 - DB PASSWORD :  ' PASSWORD
  SQL="$(which mysql)"
  SQLDUMP="$(which mysqldump)"
  printf "[client]\nhost = $HOST\nuser = $USER\npassword =$PASSWORD " >> /etc/mysql/mycrd.cnf
 # cat >> /etc/mysql/mycrd.cnf << EOF2
 #    [client]
 #    host = $HOST
 #    user =$USER
 #    password =$PASSWORD
 # EOF2

  ERROR=false
  if [ -z "$USER" ]; then
    echo "User required" >&2
    ERROR=true
  fi

  if [ -z "$PASSWORD" ]; then
    echo "Password required" >&2
    ERROR=true
  fi

  if [ -z "$OUTPUT_DIR" ]; then
    echo "Output dir required" >&2
    ERROR=true
  fi

  if $ERROR ; then
    exit 1
  fi

  DATE=`date +%Y%m%d`
  DB_CONN="$(sudo $SQL --defaults-extra-file=/etc/mysql/mycrd.cnf -Bse 'show databases')"
  for DB in $DB_CONN
  do
    if [ $DB != "information_schema" ]; then
       FILE=$OUTPUT_DIR/$DB$DATE.sql
       $SQLDUMP --defaults-extra-file=/etc/mysql/mycrd.cnf --skip-lock-tables $db > $FILE
    fi
  done
  echo "INFO : MYSQL Backup Process Completed !! "
}


while :
do
    clear
    cat<<EOF
    ==============================
    Menusystem experiment
    ------------------------------
    Please enter your choice:

    MYSQL  (1)
    DOCKER (2)
           (Q)uit
    ------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  MYSQL_FN ;;
    "2")  DOCKER_FN ;;
    "Q")  exit                      ;;
    "q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done
