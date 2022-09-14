#!/bin/bash
verde="\033[0;32m"                                                                                                                                       
vermelho="\033[0;31m"
verde="\033[0;32m"#parmera
#nextcloudURL="http://localhost:8082"
nextcloudURL="https://cloud.colmena.media"
#nextcloudURL="https://claudete.colmena.network"
pwdlocal="YWRtaW46MTIzNDU2"
pwdclaudio="YWRtaW46MzU3N3VtVFVTRDJxdmIz"
pwdclaudete="YWRtaW46dDdtazhzVTc5THlZMjlS"

nc_app=nc-frontend_app_1
file='/tmp/.profile.json'
path=/srv/nextcloud/media/html/
client_secret_m="S8Xgwx2NuONDpcqK5ciOlzKFTFoWCmFH"
client_secret_stg="2DZF1guYs6HAEB5AlNSRnqxZpyr1DyT5"
client_secret_prod="v9roi9fPFkt3xOLK9Yj1cYmO8RGQZOr6"
client_secret_dev="TkVvuVSLRRA1bo99U3LYiXnBRxFYLRdd"
client_id="admin-cli"
realm="colmena"
#keycloak="https://auth-stg.colmena.network"
#keycloak="https://auth-prod.colmena.network"
keycloak="https://auth.colmena.network"
#keycloak="https://auth.colmena.network"
#keycloak="http://localhost:8080"

# requestToken=$(curl --write-out " %{http_code}" -s -k  --location --request POST "$keycloak/auth/realms/$realm/protocol/openid-connect/token" \
# --header 'Content-Type: application/x-www-form-urlencoded' \
# --data-urlencode "client_id=$client_id" \
# --data-urlencode "client_secret=$client_secret" \
# --data-urlencode 'grant_type=client_credentials')

# access_token=$(sed -E -n 's/.*"access_token":"([^"]+)".*/\1/p' <<< $requestToken)
# echo $access_token

   access_token=$( curl -s --location --request POST "$keycloak/auth/realms/$realm/protocol/openid-connect/token" \
                  --header 'Content-Type: application/x-www-form-urlencoded' \
                  --data-urlencode 'client_id=admin-cli' \
                  --data-urlencode "client_secret=$client_secret_dev" \
                  --data-urlencode 'grant_type=client_credentials' | sed -n 's|.*"access_token":"\([^"]*\)".*|\1|p')
    
    echo "Access token : $access_token"

##################### test users in role Administrator #####################3
usersAdm=$( curl -s --location --request GET "$keycloak/auth/admin/realms/colmena/clients/b32434b1-de76-4ccf-96e2-71ec39e12db3/roles/administrator/users?first=0&max=5" \
          --header 'Content-Type: application/json' \
           --header "Authorization: Bearer $access_token")
echo $usersAdm 
exit

#########################list users###############################################
#   listUsersk=$(curl -s --location --request GET "$keycloak/auth/admin/realms/colmena/users" \
#                --header 'Content-Type: application/json' \
#                --header "Authorization: Bearer $access_token" |jq -r '.[].id')
#   #echo $listUsersk     
#   ######################set role Administrator user #####################################
     
#   clientId="c6a70eba-8747-47b4-be75-0705f06b51fb"    
#   for userId in ${listUsersk[@]}; do

#  setRole=$(curl -s --location --request POST "$keycloak/auth/admin/realms/$realm/users/$userId/role-mappings/clients/$clientId" \
#            --header 'Content-Type: application/json' \
#            --header "Authorization: Bearer $access_token" \
#            --data-raw '[
#                {
#                   "clientRole": true,
#                   "composite": false,
#                   "containerId": "c6a70eba-8747-47b4-be75-0705f06b51fb",
#                   "id": "048b2dd5-f5c2-40ae-9f51-6bff75acae17",
#                    "name": "administrator"
#                }
#            ]')


#        echo $userId
#   done
################update Groups Keycloak #######################
# listGroupsk=$(curl -s --location --request GET "$keycloak/auth/admin/realms/$realm/groups?briefRepresentation=false" \
# --header 'Content-Type: application/json' \
# --header "Authorization: Bearer $access_token" | jq -r '.[].id')
# #echo $listGroupsk
#  for groupsk in ${listGroupsk[@]};do
#    updateG=$(curl --location --request PUT "$keycloak/admin/realms/colmena/groups/$groupsk" \
#               --header 'Content-Type: application/json' \
#               --header "Authorization: Bearer $access_token" \
#               --data-raw '{
#                     "name": "devteam",
#                     "attributes": {
#                         "language": ["en"],
#                         "logo": [""],
#                         "slogan": [""],
#                         "email": [""],
#                         "url": [""],
#                         "audio_description_url": [""],
#                         "social_media_facebook": [""],
#                         "social_media_twitter": [""],
#                         "social_media_instagram": [""],
#                         "social_media_mastodon": [""],
#                         "social_media_whatsapp": [""],
#                         "social_media_telegram": [""]
#                     }
#                 }')
#  echo $groupsk
#  done
################update Password NC #######################
    # echo running on $nextcloudURL...
    # echo  -e " \033[0;34m Listando os users \033[0m"
    # listUsers=$(curl -s --location --request GET "$nextcloudURL/ocs/v2.php/cloud/users?format=json" \
    # --header 'OCS-APIRequest: true' \
    # --header 'Authorization: Basic YWRtaW46dDdtazhzVTc5THlZMjlS' | jq .ocs.data.users[] )  
    # #echo $listUsers

    # totalUsers=$(curl -s --location --request GET $nextcloudURL'/ocs/v1.php/cloud/users?format=json' \
    # --header 'OCS-APIRequest: true' \
    # --header 'Authorization: Basic '$pwdclaudete'' | jq  -r '.ocs.data.users | length') > /dev/null
    # echo "total  users" $totalUsers
    
    # adm="admin"
    # for data in ${listUsers[@]}; 
    # do
    #     user=`echo $data | sed -e 's/\"//g'`
    #     echo $user
    #     if [ $user !=  $adm ] 
    #     then
          
    #       editPassword=$(curl  -s -k  --location -X PUT "https://admin:t7mk8sU79LyY29R@cloud.colmena.media/ocs/v1.php/cloud/users/$user" \
    #       -d key="password" \
    #       -d value="colmena@123" \
    #       -H 'OCS-APIRequest: true')
    #       echo $editPassword 
    #     fi

    # done
    # exit
# ###############group NC and keyclaok ###################
#   echo  -e " \033[0;34m Listando os Grupos \033[0m"
#   listGroups=$(curl -s --location --request GET $nextcloudURL'/ocs/v1.php/cloud/groups?format=json' \
#   --header 'OCS-APIRequest: true' \
#   --header 'Authorization: Basic '$pwdclaudete'' | jq .ocs.data.groups[] )  
#   echo $listGroups
  
#   for data in ${listGroups[@]}; do
#       group=`echo $data | sed -e 's/\"//g'`
#       echo $group

#       createGroup=$(curl --location --request POST "https://auth-prod.colmena.network/auth/admin/realms/colmena/groups" \
#       --header "Authorization: Bearer $access_token" \
#       --header 'Content-Type: application/json' \
#       --data-raw '{
#             "name": "'$group'",
#             "path": "'/$group'",
#             "subGroups": [],
#             "attributes":{
#                 "language":[""],
#                 "licence":["GPL3"]
#           }
#         }')
#       echo $createGroup   
#   done 

###############users for gropus #####################
#   echo  -e " \033[0;34m Listando os Grupos \033[0m"
#   groups=$(curl -s --location --request GET $nextcloudURL'/ocs/v1.php/cloud/groups?format=json' \
#   --header 'OCS-APIRequest: true' \
#   --header "Authorization: Basic $pwdclaudete" | jq  -r '.ocs.data.groups') > /dev/null
#   echo total  groups $groups

#  echo  -e " \033[0;34m Total de Grupos \033[0m"
#   totalGroups=$(curl -s --location --request GET $nextcloudURL'/ocs/v1.php/cloud/groups?format=json' \
#   --header 'OCS-APIRequest: true' \
#   --header "Authorization: Basic $pwdclaudete" | jq  -r '.ocs.data.groups | length') > /dev/null
#   echo total  groups $totalGroups

  #  echo  -e " \033[0;34m list Grupos \033[0m"
  #  listGroups=$(curl -s --location --request GET "$nextcloudURL/ocs/v1.php/cloud/groups?format=json" \
  #  --header 'OCS-APIRequest: true' \
  #  --header "Authorization: Basic $pwdclaudete" | jq .ocs.data.groups[] )
  #  echo $listGroups   
  
  #  for data in ${listGroups[@]}; do
  #    GG=`echo $data | sed -e 's/\"//g'`
  #    #echo $GG
    echo  -e " \033[0;34m user for Grupos \033[0m"  
    userGroups=$(curl -s --location --request GET "$nextcloudURL/ocs/v1.php/cloud/groups/devteam?format=json" \
     --header 'OCS-APIRequest: true' \
     --header "Authorization: Basic $pwdclaudete" | jq .ocs.data.users[] )
     echo $userGroups   
    # done 
        for data in ${userGroups[@]}; do
        user=`echo $data | sed -e 's/\"//g'` 
        user_id=`cat usersColmenaMedia.json | jq --compact-output '."'$user'".user_id' | sed -e 's/\"//g'`
        email=`cat usersColmenaMedia.json | jq --compact-output '."'$user'".email' | sed -e 's/\"//g'`
        display_name=`cat usersColmenaMedia.json | jq --compact-output '."'$user'".display_name' | sed -e 's/\"//g'`
        groups=`cat usersColmenaMedia.json | jq --compact-output '."'$user'".groups' | sed -e 's/\"//g' | sed -e 's/\[//g' | sed -e 's/\]//g'`
        firstName=`echo $display_name | cut -d' ' -f1`
        lastName=`echo $display_name | cut -d' ' -f2`
       createuser=$(curl -s --location --request POST "https://auth-prod.colmena.network/auth/admin/realms/colmena/users" \
             --header "Authorization: Bearer $access_token" \
             --header 'Content-Type: application/json' \
            --data-raw '{
                 "enabled":true,
                 "username":"'$user_id'",
                 "email":"'$email'",
                 "firstName":"'$firstName'",
                 "lastName":"'$lastName'",
                 "credentials":[
                     {
                         "type": "password",
                         "value": "colmena@123",
                         "temporary":false
                     }
                 ],
                 "requiredActions":[
                     "CONFIGURE_TOP",
                     "VERIVY_EMAIL"
                 ],
                 "groups": ["'$groups'"],
                 "attributes":{
                     "region": [" "],
                     "country": [""],
                     "organization": [""],
                     "language": [""],
                    "phone": [""],
                     "position": [""],
                     "photo": ""

                 }
             }')
       echo $createuser   

       done
  #    done
    exit
  # for data in ${userGroups[@]}; do  
       


# done

    # echo "************************************"
    # echo " Map 'user' role to user alice in Keycloak"
    # echo "************************************"

    # # Set the needed parameter authorization
    # ADMINUSER=admin
    # PASSWORD=admin
    # GRANT_TYPE=client_credentials
    # CLIENT_ID=admin-cli
    # USER=nil
    

    # # Set the needed parameter for configuration
    # TENANT_B=colmena
    # USERROLE=colmena-role.json

 
   
    # # Get existing users
    # # users=$(curl -s --location --request GET 'http://localhost:8080/auth/admin/realms/colmena/users/' \
    # # --header 'Content-Type: application/json' \
    # # --header "Authorization: Bearer $access_token" | sed -n 's|.*"id":"\([^"]*\)".*|\1|p')
    # # echo $users
    # # exit
    # # USERID=$(curl -s --location --request GET "http://localhost:8080/auth/realms/colmena/users/" \
    # #          --header "Content-Type: application/json" \
    # #          --header "Authorization: Bearer $access_token" | sed -r -n ' 1,30 s|.*"id":"\([^"]*\)".*|\1|p')
    # # echo "------------------------------------------------------------------------"
    # # echo "User ID for 'nil': $USERID"
    # # echo "------------------------------------------------------------------------"
    
    # # Configure role
    # result=$(curl -s -d @./$USERROLE -H "Content-Type: application/json" \
    #         -H "Authorization: bearer $access_token" \
    #          "$keycloak/auth/admin/realms/colmena/users/d116e4de-f4a3-41d7-bd2c-8f502cc60beb/role-mappings/realm")

    # if [ "$result" = "" ]; then
    # echo "------------------------------------------------------------------------"
    # echo "The user: $USER roles are updated."
    # echo "Open following link in your browser:"
    # echo "$keycloak/auth/admin/master/console/#/realms/colmena"
    # echo "------------------------------------------------------------------------"
    # else
    # echo "------------------------------------------------------------------------"
    # echo "It seems there is a problem with the user role mapping: $result"
    # echo "------------------------------------------------------------------------"
    # fi

