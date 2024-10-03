# Code by Jerry Zhou (jerryz.com.cn)

# Function to output with delay
output_with_delay() {
  echo "$1"
  sleep 0.07
}

# Function to listen for volume key input
listen_volume_key() {
  while :; do
    local key_input=$(getevent -qlc 1 | awk '{ print $3 }')
    case "$key_input" in
    KEY_VOLUMEUP) return 0 ;;
    KEY_VOLUMEDOWN) return 1 ;;
    *) continue ;;
    esac
  done
}

# Function to check and install app
check_and_install_app() {
  local package_name=$1
  local app_name=$2
  local installed=$(pm list packages | grep "package:$package_name\$")
  local need_to_remove=0

  if [ -n "$installed" ]; then
    output_with_delay "$(get_lang_string "installed") $app_name"
    output_with_delay "—————————————————————————"
    output_with_delay "$(get_lang_string "volume_up"): $(get_lang_string "install") $app_name $(get_lang_string "monet")"
    output_with_delay "$(get_lang_string "volume_down"): $(get_lang_string "not_install") $app_name $(get_lang_string "monet")"
    output_with_delay "—————————————————————————"

    listen_volume_key
    if [ $? == 0 ]; then
      if [ "$package_name" == "com.tencent.mm" ]; then
        output_with_delay "—————————————————————————"
        output_with_delay "$(get_lang_string "volume_up"): $(get_lang_string "install") $app_name ($(get_lang_string "chinese_version")) $(get_lang_string "monet")"
        output_with_delay "$(get_lang_string "volume_down"): $(get_lang_string "install") $app_name (Play $(get_lang_string "version")) $(get_lang_string "monet")"
        output_with_delay "—————————————————————————"

        listen_volume_key
        if [ $? == 0 ]; then
          output_with_delay "$(get_lang_string "success_install") $app_name ($(get_lang_string "chinese_version")) $(get_lang_string "monet")"
          module="${module:+$module、}$app_name ($(get_lang_string "chinese_version"))"
          monet="${monet:+$monet\n}$app_name ($(get_lang_string "chinese_version"))"
          rm -rf "$MODPATH/system/priv-app/com.tencent.mm(Play).apk"
        else
          output_with_delay "$(get_lang_string "success_install") $app_name (Play $(get_lang_string "version")) $(get_lang_string "monet")"
          module="${module:+$module、}$app_name (Play $(get_lang_string "version"))"
          monet="${monet:+$monet\n}$app_name (Play $(get_lang_string "version"))"
          rm -rf "$MODPATH/system/priv-app/com.tencent.mm.apk"
        fi
      else
        output_with_delay "$(get_lang_string "success_install") $app_name $(get_lang_string "monet")"
        module="${module:+$module、}$app_name"
        monet="${monet:+$monet\n}$app_name"
      fi
    else
      output_with_delay "$(get_lang_string "not_install") $app_name $(get_lang_string "monet")"
      need_to_remove=1
    fi
  else
    output_with_delay "$(get_lang_string "not_installed") $app_name"
    need_to_remove=1
  fi
  
  if [ "$need_to_remove" == 1 ]; then
    if [ "$package_name" == "com.tencent.mm" ]; then
        rm -rf "$MODPATH/system/priv-app/com.tencent.mm.apk"
        rm -rf "$MODPATH/system/priv-app/com.tencent.mm(Play).apk"
    else
        rm -rf "$MODPATH/system/priv-app/$package_name.apk"
    fi
  fi
}

# Language selection
output_with_delay "请选择语言 / Please select language:"
output_with_delay "—————————————————————————"
output_with_delay "- 按音量键＋: 中文"
output_with_delay "- Press Volume Down: English"
output_with_delay "—————————————————————————"

listen_volume_key
if [ $? == 0 ]; then
  language="zh"
  output_with_delay "已选择中文"
else
  language="en"
  output_with_delay "English selected"
fi

# Language-specific strings
lang_installed_zh="已安装"
lang_installed_en="Installed"

lang_volume_up_zh="按音量键＋"
lang_volume_up_en="Press Volume Up"

lang_volume_down_zh="按音量键－"
lang_volume_down_en="Press Volume Down"

lang_install_zh="安装"
lang_install_en="Install"

lang_not_install_zh="不安装"
lang_not_install_en="Do not install"

lang_success_install_zh="成功安装"
lang_success_install_en="Successfully installed"

lang_not_installed_zh="未安装"
lang_not_installed_en="Not installed"

lang_chinese_version_zh="国内版"
lang_chinese_version_en="Chinese Version"

lang_version_zh="版"
lang_version_en="version"

lang_monet_zh="莫奈取色"
lang_monet_en="Monet theme"

# Function to get language-specific string
get_lang_string() {
  key="$1"
  if [ "$language" = "zh" ]; then
    eval "echo \$lang_${key}_zh"
  else
    eval "echo \$lang_${key}_en"
  fi
}

# Main script starts here
echo -en "Monet-All v2.1\nby Jerry Zhou\n"
if [ $language == "zh" ]; then
  echo -en "安装模块前请先确认模块适配的应用版本并阅读注意事项\n搞机不谨慎，救砖两行泪"
else
  echo -en "Before installing the module, please confirm the compatible app versions and read the precautions\nCareless modding leads to tears of regret"
fi

echo -en "\n"
output_with_delay "—————————————————————————————————————"
if [ $language == "zh" ]; then
  output_with_delay "- 按音量键＋: 未确认模块适配的应用版本并阅读注意事项"
  output_with_delay "- 按音量键－: 已确认模块适配的应用版本并阅读注意事项"
else
  output_with_delay "- Press Volume Up: Have not confirmed compatible app versions and read precautions"
  output_with_delay "- Press Volume Down: Have confirmed compatible app versions and read precautions"
fi
output_with_delay "—————————————————————————————————————"

listen_volume_key
if [ $? -eq 1 ]; then
  output_with_delay "$(get_lang_string "installed")"
else
  if [ "$language" = "zh" ]; then
    output_with_delay "请认真阅读模块适配的应用版本并阅读注意事项"
  else
    output_with_delay "Please carefully read the compatible app versions and precautions"
  fi
  sleep 0.5
  if [ "$language" = "en" ]; then
    am start -a android.intent.action.VIEW -d "https://monet.jerryz.com.cn/en/?utm_source=module" >/dev/null 2>&1
  else
    am start -a android.intent.action.VIEW -d "https://monet.jerryz.com.cn/?utm_source=module" >/dev/null 2>&1
  fi
fi

module=""
monet=""

echo -en "\n"
if [ "$language" = "zh" ]; then
  output_with_delay "开始安装"
else
  output_with_delay "Starting installation"
fi

# Function to get app name based on language
get_app_name() {
  local package_name=$1
  local zh_name
  local en_name

  case $package_name in
  com.tencent.mm)
    zh_name="微信"
    en_name="WeChat"
    ;;
  com.coolapk.market)
    zh_name="酷安"
    en_name="Coolapk"
    ;;
  com.tencent.wetype)
    zh_name="微信输入法"
    en_name="WeType"
    ;;
  com.tencent.weread)
    zh_name="微信读书"
    en_name="WeRead"
    ;;
  com.apple.android.music)
    zh_name="Apple Music"
    en_name="Apple Music"
    ;;
  tv.danmaku.bili)
    zh_name="哔哩哔哩"
    en_name="BiliBili"
    ;;
  com.bilibili.app.in)
    zh_name="哔哩哔哩国际版"
    en_name="Bilibili International"
    ;;
  com.android.systemui)
    zh_name="小横条"
    en_name="System UI"
    ;;
  mark.via)
    zh_name="Via"
    en_name="Via"
    ;;
  com.douban.frodo)
    zh_name="豆瓣"
    en_name="Douban"
    ;;
  com.huanchengfly.tieba.post)
    zh_name="贴吧Lite"
    en_name="Tieba Lite"
    ;;
  com.github.kr328.clash.foss)
    zh_name="Clash（Foss版）"
    en_name="Clash (Foss)"
    ;;
  com.github.kr328.clash)
    zh_name="Clash（Premium版）"
    en_name="Clash (Premium)"
    ;;
  com.github.metacubex.clash.meta)
    zh_name="Clash Meta"
    en_name="Clash Meta"
    ;;
  com.omarea.vtools)
    zh_name="Scene"
    en_name="Scene"
    ;;
  com.sup.android.superb)
    zh_name="皮皮虾"
    en_name="Pipixia"
    ;;
  com.miui.player)
    zh_name="MIUI音乐"
    en_name="MIUI Music"
    ;;
  com.jiongji.andriod.card)
    zh_name="百词斩"
    en_name="Baicizhan"
    ;;
  com.newskyer.draw)
    zh_name="享做笔记"
    en_name="Xiang Note"
    ;;
  com.taptap)
    zh_name="TapTap"
    en_name="TapTap"
    ;;
  org.mozilla.firefox)
    zh_name="Firefox"
    en_name="Firefox"
    ;;
  org.mozilla.fenix)
    zh_name="Firefox Nightly"
    en_name="Firefox Nightly"
    ;;
  io.github.forkmaintainers.iceraven)
    zh_name="Iceraven"
    en_name="Iceraven"
    ;;
  cn.icyflame.unknown)
    zh_name="随机Unknown"
    en_name="Random Unknown"
    ;;
  com.aefyr.sai)
    zh_name="SAI"
    en_name="SAI"
    ;;
  com.caiyuninterpreter.activity)
    zh_name="彩云小译"
    en_name="Caiyun Translator"
    ;;
  com.jarstones.jizhang)
    zh_name="一飞记账"
    en_name="Yifei Accounting"
    ;;
  com.Jesse205.hellotool)
    zh_name="哈兔Box"
    en_name="Hatu Box"
    ;;
  com.liuzho.file.explorer)
    zh_name="流舟文件"
    en_name="Liuzhou File"
    ;;
  com.modosa.apkinstaller)
    zh_name="安装狮"
    en_name="Install Lion"
    ;;
  com.modosa.rootinstaller)
    zh_name="安装狮-root"
    en_name="Install Lion-root"
    ;;
  com.nowcasting.activity)
    zh_name="彩云天气"
    en_name="Caiyun Weather"
    ;;
  com.realvnc.viewer.android)
    zh_name="VNC Viewer"
    en_name="VNC Viewer"
    ;;
  com.tencent.androidqqmail)
    zh_name="QQ邮箱"
    en_name="QQ Mail"
    ;;
  com.wangc.bill)
    zh_name="一木记账"
    en_name="Yimu Accounting"
    ;;
  eu.thedarken.sdm)
    zh_name="SD Maid"
    en_name="SD Maid"
    ;;
  idm.internet.download.manager)
    zh_name="IDM"
    en_name="IDM"
    ;;
  idm.internet.download.manager.plus)
    zh_name="IDM+"
    en_name="IDM+"
    ;;
  me.gfuil.bmap)
    zh_name="白马地图"
    en_name="Baima Map"
    ;;
  nutstore.android)
    zh_name="坚果云"
    en_name="Nutstore"
    ;;
  web1n.stopapp)
    zh_name="小黑屋"
    en_name="Small Black House"
    ;;
  x7890.shortcutcreator)
    zh_name="创建快捷方式"
    en_name="Create Shortcut"
    ;;
  cn.wps.moffice_eng)
    zh_name="WPS Office"
    en_name="WPS Office"
    ;;
  cn.wps.note)
    zh_name="WPS便签"
    en_name="WPS Note"
    ;;
  com.mojitec.mojidict)
    zh_name="MOJI辞書"
    en_name="MOJI Dictionary"
    ;;
  com.mutangtech.qianji)
    zh_name="钱迹"
    en_name="Money Track"
    ;;
  com.salt.music)
    zh_name="椒盐音乐"
    en_name="Salt Music"
    ;;
  com.vmos.pro)
    zh_name="VMOS Pro"
    en_name="VMOS Pro"
    ;;
  *)
    zh_name="未知应用"
    en_name="Unknown App"
    ;;
  esac

  if [ $language == "zh" ]; then
    echo "$zh_name"
  else
    echo "$en_name"
  fi
}

# Main loop to check and install each app
for loop in com.tencent.mm com.coolapk.market com.tencent.wetype com.tencent.weread com.apple.android.music tv.danmaku.bili com.bilibili.app.in com.android.systemui mark.via com.douban.frodo com.huanchengfly.tieba.post com.github.kr328.clash com.github.kr328.clash.foss com.github.metacubex.clash.meta com.omarea.vtools com.sup.android.superb com.miui.player com.jiongji.andriod.card com.newskyer.draw com.taptap org.mozilla.firefox org.mozilla.fenix io.github.forkmaintainers.iceraven cn.icyflame.unknown com.aefyr.sai com.caiyuninterpreter.activity com.jarstones.jizhang com.Jesse205.hellotool com.liuzho.file.explorer com.modosa.apkinstaller com.modosa.rootinstaller com.nowcasting.activity com.realvnc.viewer.android com.tencent.androidqqmail com.wangc.bill eu.thedarken.sdm idm.internet.download.manager idm.internet.download.manager.plus me.gfuil.bmap nutstore.android web1n.stopapp x7890.shortcutcreator cn.wps.moffice_eng cn.wps.note com.mojitec.mojidict com.mutangtech.qianji com.salt.music com.vmos.pro; do
  app_name=$(get_app_name "$loop")
  check_and_install_app "$loop" "$app_name"
done

echo -en "\n"
output_with_delay "—————————————————————————————————————"
if [ $language == "zh" ]; then
  output_with_delay "- 按音量键＋: 安装修改版应用、独立应用和系统模块"
  output_with_delay "- 按音量键－: 不安装修改版应用、独立应用和系统模块"
else
  output_with_delay "- Press Volume Up: Install modified apps, standalone apps, and system modules"
  output_with_delay "- Press Volume Down: Do not install modified apps, standalone apps, and system modules"
fi
output_with_delay "—————————————————————————————————————"

listen_volume_key
if [ $? == 0 ]; then
  if [ $language == "zh" ]; then
    output_with_delay "请自行下载并安装安装修改版应用、独立应用和系统模块"
  else
    output_with_delay "Please download and install modified apps, standalone apps, and system modules on your own"
  fi
  if [ $language == "en" ]; then
    am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/en/guide/apks &>/dev/null
  else
    am start -a android.intent.action.VIEW -d https://monet.jerryz.com.cn/guide/apks &>/dev/null
  fi
else
  if [ $language == "zh" ]; then
    output_with_delay "不安装修改版应用、独立应用和系统模块"
  else
    output_with_delay "Not installing modified apps, standalone apps, and system modules"
  fi
fi

echo -en "\n"
output_with_delay "—————————————————————————"
if [ $language == "zh" ]; then
  output_with_delay "- 按音量键＋: 支持作者"
  output_with_delay "- 按音量键－: 不支持作者"
else
  output_with_delay "- Press Volume Up: Support the author"
  output_with_delay "- Press Volume Down: Do not support the author"
fi
output_with_delay "—————————————————————————"

listen_volume_key
if [ $? == 0 ]; then
  if [ $language == "zh" ]; then
    output_with_delay "支持作者"
    output_with_delay "感谢您的支持"
  else
    output_with_delay "Supporting the author"
    output_with_delay "Thank you for your support"
  fi
  sleep 0.5
  am start -a android.intent.action.VIEW -d https://pay.jerryz.com.cn/?utm_source=module &>/dev/null
else
  if [ $language == "zh" ]; then
    output_with_delay "不支持作者"
  else
    output_with_delay "Not supporting the author"
  fi
fi

echo -en "\n"
if [ "$language" = "zh" ]; then
  echo -en "\n已安装下列应用的莫奈取色："
  description="莫奈取色整合模块   已开启莫奈取色的软件：${module}"
else
  echo -en "\nMonet theme has been installed for the following apps:"
  description = "Monet color picking integration module   Software with Monet color picking enabled: ${module}"
fi

echo -en "\n$monet\n"

sed -i "6c description=${description}" "$MODPATH/module.prop"

echo -en "\n"
if [ $language == "zh" ]; then
  output_with_delay "安装完成"
  output_with_delay "说明文档：monet.jerryz.com.cn"
  output_with_delay "GitHub项目地址：github.com/YangguangZhou/Monet-All"
  output_with_delay "交流群：t.me/Monet_All"
else
  output_with_delay "Installation complete"
  output_with_delay "Documentation: monet.jerryz.com.cn/en"
  output_with_delay "GitHub project: github.com/YangguangZhou/Monet-All"
  output_with_delay "Discussion group: t.me/Monet_All"
fi
