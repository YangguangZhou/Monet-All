#Code by Jerry Zhou, modified by 焕晨
#延迟输出
Outputs() {
  echo "$@"
  sleep 0.07
}

#监听音量键
Volume_key_monitoring() {
  local choose
  local branch
  while :; do
    choose="$(getevent -qlc 1 | awk '{ print $3 }')"
    case "$choose" in
    KEY_VOLUMEUP) branch="0" ;;
    KEY_VOLUMEDOWN) branch="1" ;;
    *) continue ;;
    esac
    echo "$branch"
    break
  done
}

#开始安装
sleep 0.07
echo -en "\nMonet-All v2.0.2\nby Jerry Zhou\n\n"
sleep 0.07
echo -en '安装模块前请先确认模块适配的应用版本并阅读注意事项\n搞机不谨慎，救砖两行泪\n'
Outputs "—————————————————————————————————————"
Outputs "- 按音量键＋: 已确认模块适配的应用版本并阅读注意事项"
Outputs "- 按音量键－: 未确认模块适配的应用版本并阅读注意事项"
Outputs "—————————————————————————————————————"

if [[ $(Volume_key_monitoring) == 0 ]]; then
  Outputs "已确认模块适配的应用版本并阅读注意事项"
else
  Outputs "请认真阅读模块适配的应用版本并阅读注意事项"
  sleep 0.5
  am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/?utm_source=module &>/dev/null
fi

#初始化变量
local monet
local module
local cnt
cnt=0
#判断软件是否安装
output="$(pm list package | grep com.tencent.mm)"
if [[ "$output" != "" ]]; then
  Outputs "已安装微信"
  Outputs "—————————————————————————"
  Outputs "- 按音量键＋: 安装微信莫奈取色"
  Outputs "- 按音量键－: 不安装微信莫奈取色"
  Outputs "—————————————————————————"
  if [[ $(Volume_key_monitoring) == 0 ]]; then
    Outputs "安装微信莫奈取色"
    Outputs "—————————————————————————"
    Outputs "- 按音量键＋: 安装微信（国内版）取色"
    Outputs "- 按音量键－: 安装微信（Play版）取色"
    Outputs "—————————————————————————"
    if [[ $(Volume_key_monitoring) == 0 ]]; then
      Outputs "成功安装微信（国内版）莫奈取色"
      let cnt+=1
      monet="微信（国内版）"
      module="微信（国内版）"
      rm -rf "$MODPATH/system/priv-app/com.tencent.mm(Play).apk"
    else
      Outputs "成功安装微信（Play版）莫奈取色"
      let cnt+=1
      monet="微信（Play版）"
      module="微信（Play版）"
      rm -rf "$MODPATH/system/priv-app/com.tencent.mm.apk"
    fi
  else
    Outputs "不安装微信莫奈取色"
    rm -rf "$MODPATH/system/priv-app/com.tencent.mm(Play).apk"
    rm -rf "$MODPATH/system/priv-app/com.tencent.mm.apk"
  fi
fi

for loop in com.coolapk.market com.tencent.wetype com.tencent.weread com.apple.android.music tv.danmaku.bili com.bilibili.app.in com.android.systemui mark.via com.douban.frodo com.huanchengfly.tieba.post com.github.kr328.clash.foss com.github.kr328.clash com.netease.cloudmusic com.omarea.vtools com.sup.android.superb com.miui.player com.jiongji.andriod.card com.newskyer.draw com.taptap org.mozilla.firefox org.mozilla.fenix io.github.forkmaintainers.iceraven cn.icyflame.unknown com.aefyr.sai com.caiyuninterpreter.activity com.jarstones.jizhang com.Jesse205.hellotool com.liuzho.file.explorer com.modosa.apkinstaller com.modosa.rootinstaller com.nowcasting.activity com.realvnc.viewer.android com.tencent.androidqqmail com.wangc.bill eu.thedarken.sdm idm.internet.download.manager idm.internet.download.manager.plus me.gfuil.bmap nutstore.android web1n.stopapp x7890.shortcutcreator cn.wps.moffice_eng cn.wps.note com.mojitec.mojidict com.mutangtech.qianji com.salt.music com.vmos.pro; do
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
  com.bilibili.app.in)
    name=Bilibili国际版
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
  cn.icyflame.unknown)
    name=随机Unknown
    ;;
  com.aefyr.sai)
    name=SAI
    ;;
  com.caiyuninterpreter.activity)
    name=彩云小译
    ;;
  com.jarstones.jizhang)
    name=一飞记账
    ;;
  com.Jesse205.hellotool)
    name=哈兔Box
    ;;
  com.liuzho.file.explorer)
    name=流舟文件
    ;;
  com.modosa.apkinstaller)
    name=安装狮
    ;;
  com.modosa.rootinstaller)
    name=安装狮-root
    ;;
  com.nowcasting.activity)
    name=彩云天气
    ;;
  com.realvnc.viewer.android)
    name="VNC Viewer"
    ;;
  com.tencent.androidqqmail)
    name=QQ邮箱
    ;;
  com.wangc.bill)
    name=一木记账
    ;;
  eu.thedarken.sdm)
    name="SD Maid"
    ;;
  idm.internet.download.manager)
    name=IDM
    ;;
  idm.internet.download.manager.plus)
    name=IDM+
    ;;
  me.gfuil.bmap)
    name=白马地图
    ;;
  nutstore.android)
    name=坚果云
    ;;
  web1n.stopapp)
    name=小黑屋
    ;;
  x7890.shortcutcreator)
    name=创建快捷方式
    ;;
  cn.wps.moffice_eng)
    name="WPS Office"
    ;;
  cn.wps.note)
    name=WPS便签
    ;;
  com.mojitec.mojidict)
    name=MOJI辞書
    ;;
  com.mutangtech.qianji)
    name=钱迹
    ;;
  com.salt.music)
    name=椒盐音乐
    ;;
  com.vmos.pro)
    name="VMOS Pro"
    ;;
  *) continue ;;
  esac
  output="$(pm list package | grep $loop)"
  if [[ "$output" != "" ]]; then
    Outputs "已安装$name"
    Outputs "—————————————————————————"
    Outputs "- 按音量键＋: 安装$name莫奈取色"
    Outputs "- 按音量键－: 不安装$name莫奈取色"
    Outputs "—————————————————————————"
    if [[ $(Volume_key_monitoring) == 0 ]]; then
      Outputs "成功安装$name莫奈取色"
      let cnt+=1
      if [[ "$cnt" -ge 8 ]]; then
        monet=${monet}"、\n"${name}
        let cnt-=6
      else
        if [[ "$cnt" -le 1 ]]; then
          monet=${name}
          let cnt=2
        else
          monet=${monet}"、"${name}
        fi
      fi
    else
      Outputs "不安装$name莫奈取色"
      rm -rf "$MODPATH"/system/priv-app/$loop.apk
    fi
  else
    Outputs "未安装$name"
    rm -rf "$MODPATH"/system/priv-app/$loop.apk
  fi
done

sleep 0.07
echo -en "\n"
Outputs "—————————————————————————————————————"
Outputs "- 按音量键＋: 安装修改版应用、独立应用和系统模块"
Outputs "- 按音量键－: 不安装修改版应用、独立应用和系统模块"
Outputs "—————————————————————————————————————"

if [[ $(Volume_key_monitoring) == 0 ]]; then
  Outputs "请自行下载并安装安装修改版应用、独立应用和系统模块"
  am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/guide/apks &>/dev/null
else
  Outputs "不安装修改版应用、独立应用和系统模块"
fi

sleep 0.07
echo -en "\n已安装下列应用的莫奈取色：\n""${monet}"
sed -i "6c description=莫奈取色整合模块   已开启莫奈取色的软件：${module}" "$MODPATH"/module.prop
sleep 0.07
echo -en "\n"
Outputs "—————————————————————————"
Outputs "- 按音量键＋: 支持作者"
Outputs "- 按音量键－: 不支持作者"
Outputs "—————————————————————————"

if [[ $(Volume_key_monitoring) == 0 ]]; then
  Outputs "支持作者"
  Outputs "感谢您的支持"
  sleep 0.5
  am start -a android.intent.action.VIEW -d https://pay.jerryz.com.cn/?utm_source=module &>/dev/null
else
  Outputs "不支持作者"
fi
echo -en "\n"
Outputs "说明文档：monet.jerryz.com.cn"
Outputs "GitHub项目地址：github.com/YangguangZhou/Monet-All"
Outputs "交流群：t.me/Monet_All"
echo -en "\n"
set_perm_recursive "$MODPATH" 0 0 0755 0777
Outputs "安装完成"
