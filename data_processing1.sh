#!/user/bin/env bash

# wget -O worldcupplayerinfo.tsv https://raw.githubusercontent.com/c4pr1c3/LinuxSysAdmin/master/exp/chap0x04/worldcupplayerinfo.tsv;

file="worldcupplayerinfo.tsv"
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "==============世界杯运动员信息处理程序的帮助文档=============="
    echo "
        
    -h,--help                  显示本脚本的帮助文档

    -a,--age                   统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比

    -p,--position              统计不同场上位置的球员数量、百分比

    -ns,--name_search          寻查名字最长的球员是谁？名字最短的球员是谁？

    -as,--age_search           寻查年龄最大的球员是谁？年龄最小的球员是谁？
    ============================end============================ 
    "
    exit 0
fi

function age_sta() {
    awk -F '\t' 'BEGIN { yt20=0;bt20_30=0;ot30=0;}
    NR>1 {
        if($6<20)
            yt20++
        else if($6<=30)
            bt20_30++
        else ot30++} 
    END {
        total=yt20+bt20_30+ot30;
        printf "===============Age Statistics===============\n";
        printf "%-50s:%5d\t%.3f\n","Amount and Proportion of Age under 20",yt20,yt20/total;
        printf "%-50s:%5d\t%.3f \n","Amount and Proportion of Age between 20 and 30",bt20_30,bt20_30/total;
        printf "%-50s:%5d\t%.3f \n","Amount and Proportion of Age greater than 30",ot30,ot30/total;
    }'   "$file"  
    return
}

# age_sta

function position_sta(){
    awk -F '\t' '
    BEGIN {
        total=0
    }
    NR>1{
        pos[$5]++;total++
    }
    END{
        printf("============Position Statistics============\n");
        for(key in pos){
            printf "amount of %-15s%5d\t\tproportion: %.3f\n",key,pos[key],pos[key]/total;
        }
    }
    ' $file
    return
}

function name_search() {
    awk -F '\t' '
    BEGIN{
        lName="";
        SName="========================================";
    }
    NR>1{
        if(length($9)<length(SName)){
            SName=$9;    
        }
        if(length($9)>length(lName)){
            lName=$9;
        }    
    }
    END{
        printf "================Name Search================\n"
        printf "Longest Name:\t%s\nShortest Name:\t%s\n",lName,SName}
    ' $file    
    return 
}

function age_search() {
    awk -F '\t' '
    BEGIN{
        oldest=0;
        youngest=100; 
    }
    NR>1{
        if($6>oldest){
            op=$9;
            oldest=$6;
        }
        if($6<youngest){
            yp=$9;
            youngest=$6;
        }
    }
    END{
        printf "============Oldest and Youngest============\n"
        printf "%-10s\t%s\n%-10s\t%s\n","Oldest:",op,"Youngest:",yp     
    }   
    ' $file
   return
}

while true;do
    case "$1" in
        -a|--age) 
            age_sta; shift;;             
        -p|--position)
            position_sta; shift;; 
        -na|--name_search)
            name_search; shift;; 
        -as|--age_search) 
            age_search; shift;; 
         "") break;;
    esac
done

log=log2.txt
echo "数据处理程序1开始运行">$log
echo "以下是shellcheck检测结果">>$log
shellcheck "$0">>$log