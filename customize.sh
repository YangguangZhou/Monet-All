SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true
ForcedAttention=true
AskAbout=true

echo -en "\nMonet-All v2.0.1\nby Jerry Zhou\n\n"
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
                    rm -rf "$MODPATH/system/priv-app/com.tencent.mm(Play).apk"
                    break
                    ;;
                KEY_VOLUMEDOWN)
                    echo "成功安装微信（Play版）莫奈取色"
                    let cnt+=1
                    monet="微信（Play版）"
                    module="微信（Play版）"
                    rm -rf "$MODPATH/system/priv-app/com.tencent.mm.apk"
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
                rm -rf $MODPATH/system/priv-app/$loop.apk
                ;;
            *) continue ;;
            esac
            break
        done
        sleep 0.3s
    else
        echo 未安装$name
        rm -rf $MODPATH/system/priv-app/$loop.apk
    fi
    i=$(expr $i + 1)
done
echo "—————————————————————————————————————
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                - 按音量键＋: 安装修改版应用、独立应用和系统模块
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                - 按音量键－: 不安装修改版应用、独立应用和系统模块
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                —————————————————————————————————————"
local choose
while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "${choose}" in
    KEY_VOLUMEUP)
        echo 请自行下载并安装安装修改版应用、独立应用和系统模块
        am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/guide/apks
        ;;
    KEY_VOLUMEDOWN)
        echo 不安装修改版应用、独立应用和系统模块
        ;;
    *) continue ;;
    esac
    break
done
sleep 0.3s
echo -en "\n已安装下列应用的莫奈取色：\n"${monet}
sed -i "6c description=莫奈取色整合模块   已开启莫奈取色的软件：${module}   GitHub项目地址：https://github.com/YangguangZhou/Monet-All" $MODPATH/module.prop
echo "—————————————————————————
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    - 按音量键＋: 支持作者
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    - 按音量键－: 不支持作者
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    —————————————————————————"
local choose
local branch
while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "${choose}" in
    KEY_VOLUMEUP)
        echo "支持作者"
        am start -a android.intent.action.VIEW -d https://pay.jerryz.com.cn/
        ;;
    KEY_VOLUMEDOWN)
        echo "不支持作者"
        ;;
    *) continue ;;
    esac
    break
done
set_perm_recursive $MODPATH 0 0 0755 0777
rm -rf $MODPATH/HttpPost.dex
echo '安装完成'
