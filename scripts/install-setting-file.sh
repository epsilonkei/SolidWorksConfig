
project_dir=$(cd $(dirname ${0}); pwd;)
project_dir=$(cygpath -w ${project_dir/\/scripts/})
echo "project dir is "$project_dir
project_dir_yen=${project_dir//\\/\\\\\\\\}
echo "project dir with \ is "$project_dir_yen
project_dir_slash=${project_dir//\\/\/}
echo "project dir slash is "$project_dir_slash

# generate users
users=()
usersdir=${USERPROFILE}\\..\\
users+=`ls ${usersdir}|grep -v cyg|grep -vi public|grep -vi user|grep -vi default|grep -vi desktop`

echo "user name list:"
for user in $users
do
    echo " "$user
done

for user in $users
do
    sed $project_dir/settings/swSettings_general.sldreg -e s#@project_dir_slash@#${project_dir_slash}#gi \
    | sed -e s#@project_dir_yen@#${project_dir_yen}#gi \
    | sed -e s#@user_dir@#${drive}\:\\\\\\\\Users\\\\\\\\${user}#gi \
    > $project_dir/settings/swSettings_${user}.sldreg
done

user=${users[0]}
echo "user name is "${user}
