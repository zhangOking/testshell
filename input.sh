#!/bin/bash

master="master"

files=$(ls -a)

[[ $files =~ ".git" ]]

[[ $? = "1" ]] && echo "该文件不包含.git文件, 请将文件放置于正确路径" && exit

pushFunc() {
  git checkout $1
  git add .
  git commit -m $3
  git push origin $1
  git checkout $2
  git pull origin $2
  git merge origin $1
  git push origin $2
}

if [[ $1 && $2 && $3 ]]
then

  pushFunc $1 $2 $3

else
  read -p "请输入要合并的分支: " input1
  echo
  read -p "请输入要合并到的分支: " input2
  echo
  echo "commit类型"
  echo "1)新需求feat: "
  echo "2)修复fix: "
  echo "3)更新update: "
  echo
  read -p "请选择类型并输入commit信息(以空格分割): " commitType text

  case $commitType in
    1) input="feat: ${text}" ;;
    2) input="fix: ${text}" ;;
    3) input="update: ${text}" ;;
    *) echo "输入有误" && exit ;;
  esac

  if [[ $input2 && $input2 = $master ]]
  then
    echo 
    echo "合并失败, 合并master请使用mr"
    exit
  fi

  if [[ $input1 && $input2 && $input ]]
  then 

    pushFunc $input1 $input2 $input

  else
    echo "输入有误"
    exit
  fi
fi
