#!/bin/bash
# ANSI color -- 使用这些变量输出不同的颜色和格式
# 以f结尾表示前景色，以b结尾表示背景色。

initializeANSI()
{
	esc="" # 俏，是按i进入插入模式，然后按ctrl+v，再按esc退出插入模式

	# 前景色
	blackf="${esc}[30m";	redf="${esc}[31m";	greenf="${esc}[32m"
	yellowf="${esc}[33m";	bluef="${esc}[34m";	purplef="${esc}[35m"
	cyanf="${esc}[36m";		whitef="${esc}[37m"

	# 背景色
	blackb="${esc}[40m"; 	redb="${esc}[41m";	greenb="${esc}[42m"
	yellowb="${esc}[43m";	blueb="${esc}44m";	purpleb="${esc}[45m"
	cyanb="${esc}[46m";		whiteb="${esc}47m"

	# 粗体，斜体，下划线以及样式切换
	boldon="${esc}[1m";		boldoff="${esc}[22m"
	italicson="${esc}[3m";	italicsoff="${esc}[23m"
	ulon="${esc}[4m";		uloff="${esc}[24m";
	invon="${esc}[7m";		invoff="${esc}[27m"

	reset="${esc}[0m"
}

initializeANSI
cat << EOF
${yellowf}This is a pharse in yellow${redb} and red${reset}
${boldon}This is bold${ulon} this is italics${reset} bye-bye
${italicson}This is italics${italicsoff} and this is not
${ulon}This is ul${uloff} and this is not
${invon}This is inv${invoff} and this is not
${yellowf}${redb}Warning I ${yellowb}${redf}Warning II${reset}
EOF
