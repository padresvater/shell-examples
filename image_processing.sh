#!/user/bin/env bash

# help帮助文档
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "========图片处理脚本的帮助文档========"
    echo "
    -h,--help                  显示本脚本的帮助文档

    -q,--quality               JPEG quality compression,value range from1 to 100
                               (Defualt 80 if not be provided).Output files will 
                               be named with "JpgC_" preffix.

    -r,--resize                Resize jpeg/png/svg images with original ratio(Defualt 
                               80 not be provided).Outpu will be named with 
                               "R_" preffix.

    -w string                  Add text watermark to the images.Output files will be
                               named with "WM_" prefix.

    -p,--prefix                Add prefix to files.

    -s,--suffix                Add suffix to files (Wouldn't impact files type name).

    -c,--convert               Convert png/svg images to jpeg.Possibly,to avoid files 
                               with the same name.If image is png,output will be named
                               with "_p" suffix. If image is svg,output will be named 
                               with "_s" suffix."
    exit 0
fi
echo "脚本传入参数$1"
echo "====================="

# 各函数变量名的初始化
resize=0
watermark_string=""
prefix=""
suffix=""
if_convert=0
dir="./image"
out="./OutPut"

# 图片的质量压缩函数，请输入图片路径，
function jpegcompress() {
    path=($dir)
    i=1
    for file in "$path"/*.png;do
        ( convert "$file" -compress JPEG -quality 85 "$out"/"$i.jpg")
        i=$((i+1))
    done
    echo "========图片质量压缩完成========"
}
jpegcompress 

