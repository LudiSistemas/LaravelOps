cat << "EOF"
    __              ___    _____ _      __                           
   / /   __  ______/ (_)  / ___/(_)____/ /____  ____ ___  ____ ______
  / /   / / / / __  / /   \__ \/ / ___/ __/ _ \/ __ `__ \/ __ `/ ___/
 / /___/ /_/ / /_/ / /   ___/ / (__  ) /_/  __/ / / / / / /_/ (__  ) 
/_____/\__,_/\__,_/_/   /____/_/____/\__/\___/_/ /_/ /_/\__,_/____/ 
EOF
echo "Please enter URL for your local aplication. "
echo "Example: myapp.local"
read user_domain
echo "127.0.0.1		$user_domain" >> /etc/hosts
echo "Domain added to /etc/hosts file"
sleep 0.5
mkdir server/$user_domain
echo "Created directory for your project @ server/$user_domain "
sleep 0.5
echo "Do you want to clone your git repo?"
echo "1. Yes"
echo "2. No"
echo "Please enter number with no other siymbols"
read gitverf
echo "........................................"
   if [ $gitverf -eq 1 ];
   then
   echo "Paste your git https url."
   echo "Example: https://git.quantox.tech/nenad.davidovic/laravel-ops.git"
   read giturl
   echo "........................................"
   echo "Cloning $giturl"
   git clone $giturl server/$user_domain
   sleep 1
   else
   echo "continuing without git project."
   sleep 1
   echo " Directory server/$user_domain created."
   fi
sleep 0.5
echo "Creating nginx conf"
cp mounts/nginx/conf.d/template mounts/nginx/conf.d/$user_domain.conf
sed -i "s/user_domain/$user_domain/g" mounts/nginx/conf.d/$user_domain.conf
echo "Nginx conf created"

sleep 1
echo "-------------------------------"
echo "Database configuration"
sleep 1
echo "Please enter your prefered databse NAME"
read name_database
sleep 1
echo "Please enter your prefered databse username"
read user_database 
sleep 1
echo "-------------------------------"
echo "Please enter your perfered datbase password"
read pass_database
sleep 2
cp docker_files/laravel/env server/$user_domain/.env
sed -i "s/user_domain/$user_domain/g" server/$user_domain/.env
sed -i "s/user_database/$user_database/g" server/$user_domain/.env
sed -i "s/pass_database/$pass_database/g" server/$user_domain/.env
sed -i "s/name_database/$name_database/g" server/$user_domain/.env
echo ".env file created"
sleep 1
cp docker_files/template.yml ./docker-compose.yml
sed -i "s/user_domain/$user_domain/g" ./docker-compose.yml
sed -i "s/user_database/$user_database/g" ./docker-compose.yml
sed -i "s/pass_database/$pass_database/g" ./docker-compose.yml
sed -i "s/name_database/$name_database/g" ./docker-compose.yml
echo "docker-compose.yml created"
sleep 1
echo "Launchin in"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 5
echo "If all above copleted succesfuly, you should be having fully configured laravel container"
echo "Domain: http://$user_domain"
echo "Location: server/$user_domain/ "
echo "Database name: $name_database "
echo "Database user: $user_database"
echo "Databse pass: $pass_database"
echo "This is just for troubleshooting only, we crated everything you need"