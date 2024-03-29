#!/bin/bash
# validfloat -- 测试数字是否为有效的浮点数。
# 注意，该脚本不接收科学记数法（1.304e5)。

# 要测试输入的值是否为有效的浮点数，需要将值分为两部分：整数部分
# 和小数部分。先测试第一部分是有效整数，然后测试第二部分是否
# 为大于或等于0的有效整数。因此-30.5是有效的，-30.-8则无效。

# 使用"."记法可以将另一个脚本包含到此脚本中。非常简单。

. validint.sh

validfloat()
{
	fvalue="$1"

	# 检查输出的数字是否有小数点。
	if [ ! -z $(echo $fvalue | sed 's/[^.]//g') ] ; then
				
		# 提取小数点之前的部分。
		decimalPart="$(echo $fvalue | cut -d. -f1)"
		
		# 提取小数点后面的部分。
		fractionalPart="${fvalue#*\.}"

		# 先测试小数点左侧的整数部分。

		if [ ! -z $decimalPart ] ; then
			# 由于"!"会颠倒测试逻辑，因此下面表示"如果不是有效的整数"。
			if ! validint "$decimalPart" "" "" ; then
				return 1
			fi
		fi

		# 现在测试小数部分

		# 小数点后不能有负号（例如33.-11就不正确），因此先来测试负号。
		if [ "${fractionalPart%${fractionalPart#?}}" = "-" ] ; then
			echo "Invalid floating-point number: '-' not allowed after decimal point." >&2
			return 1
		fi
		if [ "$fractionalPart" != "" ]; then
			# 如果小数部分d不是有效的整数...
			if ! validint "$fractionalPart" "0" "" ; then
				return 1
			fi
		fi
	else
		# 如果整个值只是一个"-",那也不行。
		if [ "$fvalue" = "-" ]; then
			echo "Invalid floating-point format." >&2
			return 1
		fi

		# 最后，检查剩下的部分是否为有效的整数。
		if ! validint "$fvalue" "" "" ; then
			return 1
		fi
	fi

	return 0
}

if validfloat $1 ; then
	echo "$1 is a valid floating-point value."
fi

exit 0

