#!/bin/bash

encrypt() {

  file_name=$1

  file_date="$(ls -i "$file_name")"

  first_num=${file_date:0:2}
  echo $first_num
  second_num=${file_date:2:2}

  chr() {
    [ "$1" -lt 256 ] || return 1
    printf "\\$(printf '%03o' "$1")"
  }

  ord() {
    LC_CTYPE=C printf '%d' "'$1"
  }

  before_str=''
  range=128

  for ((i=1; i<=$first_num; i++));
  do
  number=$RANDOM
  let "number %= $range"
  symbol=$(chr $number)
  before_str+="${symbol}"
  echo f
  done

  for ((i=1; i<=$second_num; i++));
  do
  number=$RANDOM
  let "number %= $range"
  symbol=$(chr $number)
  after_str+="${symbol}"
  echo
  done


  text="$(cat file.txt)"
  def=${file_date:3:2}
  new_text=''
  
  for ((i=0; i<=${#text}; i++));
  do
    symbol_num=$(ord "${text:$i:1}")

    if (($symbol_num+$def>127)); then
      let "new_code = $symbol_num + $def - 127"
    else
      let "new_code = $symbol_num + $def"
    fi
    new_simb=$(chr $new_code)
    new_text+=$new_simb
  done

  final_text+=$before_str
  
  final_text+=$new_text
  final_text+=$after_str
  
  printf "$final_text" > $1
}



anencrypt(){

  file_name=$1

  file_date="$(ls -i "$file_name")"

  first_num=${file_date:0:2}
  echo $first_num
  second_num=${file_date:2:2}

  chr() {
    [ "$1" -lt 256 ] || return 1
    printf "\\$(printf '%03o' "$1")"
  }

  ord() {
    LC_CTYPE=C printf '%d' "'$1"
  }

  text="$(cat file.txt)"


  text=${text: $first_num}
  text=${text: 0:-$second_num}


  def=${file_date:3:2}
  new_text=''

  for ((i=0; i<=${#text}; i++));
  do
    symbol_num=$(ord "${text:$i:1}")

    if (($symbol_num-$def<0)); then
      let "new_code = 127 + ($symbol_num - $def)"
    else
      let "new_code = $symbol_num - $def"
    fi
    new_simb=$(chr $new_code)
    new_text+=$new_simb
  done
# echo $new_text
printf "$new_text" > $1
}


read -p "Encrypt or anencrypt? " answer

if [[ "$answer" == "encrypt" ]]; 
then
  read -p "Enter a filename: " file_name
    encrypt $file_name
elif [[ "$answer" == "anencrypt" ]];
then
  read -p "Enter a filename: " file_name
    anencrypt $file_name
else
  read -p "Try again"
fi

# read -p "Enter a filename: " file_name
# anencrypt $file_name
# encrypt $file_name

# echo $before_str


ord() {
  printf '%d' "'$1"
}

chr() {
  printf \\$(printf '%03o' $1)
}

echo $(chr 70)