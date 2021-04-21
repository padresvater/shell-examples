#!/user/bin/env bash

# help帮助文档
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "========图片处理脚本的帮助文档========"
    echo "
    脚本支持：
    命令行参数方式使用不同功能
    对指定目录下所有支持格式的图片文件进行批处理指定目录进行批处理
    以下常见图片批处理功能的单独使用或组合使用
        对jpeg格式图片进行图片质量压缩
        对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
        对图片批量添加自定义文本水印
        批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
        将png/svg图片统一转换为jpg格式；
        
    -h,--help                  显示本脚本的帮助文档

    -q,--quality               对图片进行质量压缩时的质量参数，质量为1（最低图像质量和最高压缩率）
                               到100（最佳质量但有效压缩率最低）。
                               默认值是如果可以确定，则使用输入图像的估计质量，否则使用92。
                               如果质量大于90，则不会对色度通道进行下采样。

    -r,--resize                保持原始宽高比的前提下压缩分辨率的比率

    -w,--watermark             需要在图片中添加的文本水印

    -r,--rename                重命名图片,作为前缀添加到文件名中而不改变拓展名。

    -c,--convert               将png和svg图片转化为jpg格式，不改变原有文件名。"
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

function convert_to_jpg() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "svg" || ${file##*.} == "png" ]];then
            file1=${file##*/}
            convert "$file" "$out/${file1%.*}.jpg"              
        fi
    done
    echo "==========转换格式完成=========="
    return
}
 convert_to_jpg

