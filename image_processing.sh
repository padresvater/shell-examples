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

    -r,--rename                重命名图片

    -c,--convert               Convert png/svg images to jpeg.Possibly,to avoid files 
                               with the same name.If image is png,output will be named
                               with "_p" suffix. If image is svg,output will be named 
                               with "_s" suffix."
    exit 0
fi
echo "脚本传入参数$1"
echo "================================"

# 各函数变量名的初始化
# 可修改，类似全局变量
quality=85
resize=50%
watermark="padresvater"
name="re_"
dir="./image" 
out="./OutPut"

# 图片的质量压缩函数
function jpegcompress() {
    path=($dir)
    for file in "$path"/*.png;do
        ( convert "$file" -compress JPEG -quality $quality "$out"/"compressed_${file##*/}.jpg")
    done
    echo "========图片质量压缩完成========"
}
# jpegcompress 

# 压缩分辨率函数,##.作用是删去最后一个.前的字符串，即取文件拓展名
function resolution() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "jpg" ||  ${file##*.} == "svg" || ${file##*.} == "png" ]];then
            convert "$file" -resize $resize "$out"/"resolution_${file##*/}"
        fi
    done
    echo "=========分辨率压缩完成========="
    return
}
# resolution

# 添加水印的函数
function addwatermark() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "jpg" || ${file##*.} == "png" ]];then
            convert "$file" -pointsize 40 -fill black -gravity center -draw "text 10,10 '$watermark'" "$out/wm_${file##*/}"              
        fi
    done
    echo "==========添加水印完成=========="
    return
}
# addwatermark

# 批量重命名
function rename() {
    path=($dir)
    for file in "$path"/*.*;do
             cp "$file"  "$out/$name${file##*/}"  
    done
    echo "=========批量重命名完成=========="
    return
}
# rename

