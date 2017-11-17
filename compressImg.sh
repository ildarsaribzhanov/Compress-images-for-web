#!/bin/bash

# compressImg.sh — скипт для компрессии (сжатия) картинок jpg, png
#
# Умеет:
# - Пережимает картинки, оставляя их на том же месте
#
# Зависимости:
# - jpegoptim
# - optipng
#
#
# Пример вызова:
#
#	compressImg.sh /path/images
#

# Входная функция
function main()
{
	input_dir=$1

	# Надо указывать исходную папку
	if [[ -z "$input_dir" ]]; then
		input_dir="./"
	fi

	# Существование исходной папки
	if [ ! -d "$input_dir" ]; then
		echo "<$input_dir> do not exists"
		return 1
	fi

	# Определяем как будут разделяться строки. Нам нужны только переносы, чтобы игнирировлись пробелы
	OIFS=$IFS; IFS=$'\n'

	# Перебираем в цикле файлы с расширением jpg, jpeg, png
	for file_name in $(find "$input_dir" -name "*"); do
		if [[ -f $file_name ]]; then
			f_mime=$(file -b --mime-type "$file_name")

			case $f_mime in
				'image/jpeg') 
					jpegoptim -m 80 --strip-all -o $file_name
					;;

				'image/png') 
					optipng -o 5 $file_name
					;;
			esac
		fi
	done
}


echo 'Start processing...'

main "$@"

echo 'Done!'