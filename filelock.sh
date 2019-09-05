#!/bin/bash
# filelock -- 一种灵活的文件锁定机制。

retries="10"	# 默认的重试次数
action="lock"	# 默认操作。
nullcmd="'which true'"	# 用于锁文件的空命令。

while getopts "lur:" opt; do
	case $opt in
		l ) action="lock"		;;
		u ) action="unlock"		;;
		r ) retries="$OPTARG"	;;
	esac
done
shift $(($OPTIND - 1))

if [ $# -eq 0 ] ; then
	cat << EOF >&2
Usage: $0 [-l|-u] [-r retries] LOCKFILE
Where -l requests a lock (the default), -u requests an unlock, -r X
specifies a max number of retries before it fails (default = $retries).
EOF
	exit 1
fi

# 确定是否有lockfile命令。
if [ -z "$(which lockfile | grep -v '^no ')" ] ; then
	echo "$0 failed: 'lockfile' utility not found in PATH." >&2
	exit 1
fi
if [ "$action" = "lock" ] ; then
	if ! lockfile -1 -r $retries "$1" > /dev/null; then
		echo "$0: failed: Counldn't create lockfile in time." >&2
		exit 1
	fi
else	# unlock操作
	if [ ! -f "$1" ] ; then
		echo "$0: Warning: lockfile $1 doesn't exist to unlock." >&2
		exit 1
	fi
	rm -f "$1"
fi

exit 0

