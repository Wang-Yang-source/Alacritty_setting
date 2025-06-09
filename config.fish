function fish_greeting
	# 显示北京时间精确到秒的欢迎语，搭配颜色主题
	set hour (date -u "+%H" | sed 's/^0*//')
	set min (date -u "+%M" | sed 's/^0*//')
	set sec (date -u "+%S" | sed 's/^0*//')
	
	# 处理空字符串（当时间为 00 时）
	test -z "$hour"; and set hour 0
	test -z "$min"; and set min 0
	test -z "$sec"; and set sec 0
	
	set hour (math "$hour + 8")
	if test $hour -ge 24
		set hour (math "$hour - 24")
	end

	set time_str (printf "%02d:%02d:%02d" $hour $min $sec)

	if test $hour -ge 5 -a $hour -lt 12
		set greeting (set_color cyan)"󰄛 Good morning, Waya!"(set_color normal)
		set greeting "$greeting"
	else if test $hour -ge 12 -a $hour -lt 18
		set greeting (set_color yellow)"󰄛 Good afternoon, Waya!"(set_color normal)
		set greeting "$greeting"
	else if test $hour -ge 18 -a $hour -lt 22
		set greeting (set_color magenta)"󰄛 Good evening, Waya!"(set_color normal)
		set greeting "$greeting"
	else
		set greeting (set_color blue)"󰄛 Good night, Waya!"(set_color normal)
		set greeting "$greeting"
	end

	set time_color (set_color magenta)
	set reset_color (set_color normal)
	printf "%s %sIt's %s%s\n" $greeting $time_color $time_str $reset_color
end

# Set the prompt to use Starship
if status is-interactive
	# Commands to run in interactive sessions can go here
	starship init fish | source
end

# Cargo Bin Settings
set -gx PATH $HOME/.cargo/bin $PATH

# Environment Variables
set -gx ZIG_HOME https://mirrors.tuna.tsinghua.edu.cn/zig/

# Network Proxy Settings
set -gx https_proxy http://127.0.0.1:7897
set -gx http_proxy http://127.0.0.1:7897
set -gx all_proxy socks5://127.0.0.1:7897

# Java Settings
set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
set -gx JAVA_TOOL_OPTIONS "-Dsun.java2d.uiScale=2.0"

# Input Method Settings (Fcitx)
set -gx XMODIFIERS @im=fcitx
set -gx GTK_IM_MODULE fcitx
set -gx QT_IM_MODULE fcitx

# Turso
set -gx PATH $PATH /home/Waya/.turso

# pnpm
set -gx PNPM_HOME /home/Waya/.local/share/pnpm
if not contains $PNPM_HOME $PATH
    set -gx PATH $PNPM_HOME $PATH
end
