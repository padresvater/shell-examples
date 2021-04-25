#!/user/bin/env bash


file="web_log.tsv"
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "==============网络日志信息处理程序的帮助文档=============="
    echo "
        
    -h,--help                  显示本脚本的帮助文档

    -ho,--host                 统计访问来源主机TOP 100和分别对应出现的总次数   

    -i,--ip                    统计访问来源主机TOP 100 IP和分别对应出现的总次数

    -u,--url                   统计最频繁被访问的URL TOP 100

    -c,--condition             统计不同响应状态码的出现次数和对应百分比

    -4,--4xx                   分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
    
    -us,--url_hosts            给定URL输出TOP 100访问来源主机
    ============================end============================ 
    "
    exit 0
fi

# 统计访问来源主机TOP 100和分别对应出现的总次数
function GetHost() {
    echo "=====Top100 Hosts and its number of occurrences====="
    awk -F '\t' '
    NR>1 {
        host[$1]++;
    }
    END{
        for(key in host){
            printf "%s:%d\n", key,host[key]
        }        
    }
    ' $file | sort -n -r -k 2 -t : | head -n 100| 
    awk -F ':' '{printf "%s%-30s\t%s%03d\n","Host:",$1,"number of occurrences:",$2}'
    return  
}
# GetHost

GetIp(){
    echo "=====TOP100 IP And its number of occurrences====="
    awk -F '\t' '
    NR>1{
        if($1~/([0-9]{1,3}\.){3}[0-9]{1,3}/){
            ip[$1]++; 
        }   
    }
    END{
        for(key in ip){
            printf "%s:%d\n", key,ip[key]
        }
    }
    ' $file | sort -n -r -k 2 -t : | head -n 100 |  
        awk -F ':' '{printf "%s%-30s\t%s%03d\n","IP:",$1,"Apperance:",$2}'
    return
}

# GetIp

GetUrl(){
    printf "=====TOP100 Url And its number of occurrences=====\n"
    awk -F '\t' '
    NR>1{
       Url[$5]++
    }
    END{
        for(i in Url){
            printf "%s:%d\n",i,Url[i]
        }
    } 
    ' $file | sort -n -r -k 2 -t : | head -n 100 |  
    awk -F ':' '{printf "%s%-55s\t%s%03d\n","Url:",$1,"Apperance:",$2}'
    return
}
# GetUrl

GetCondition(){
    printf "=====Condition Code and its number of occurrences and its Proportion=====\n"
    awk -F '\t' '
    BEGIN{
        total=0;
    }
    NR>1{
        sta[$6]++;total++;
    }
    END{
        for(key in sta){
            printf "Condition:%d\tTimes:%8d\tProportion:%.3lf\n",key,sta[key],sta[key]/total    
        }
    }
    ' $file
}
# GetCondition

Get4xxUrl(){
    printf "===Top10 URLs with condition code being 4xx and its number of occurrences===\n"
    printf "===Condition:%d===\n" 403
    awk -F '\t' '
    NR>1{
        if($6~/403/){
            url[$5]++;
        }
    }
    END{
        for(i in url){
            printf "%s:%d\n",i,url[i]
        }     
    }
    ' $file | sort -n -r -k 2 -t : | head -n 10 | 
     awk -F ':' '
       {printf "%s%-65s\t%s%d\n","Url:",$1,"number of occurrences:",$2}
    '  
    printf "===Condition:%d===\n" 404
    awk -F '\t' '
    NR>1{
    if($6~/404/){
            url[$5]++;
        }
    }
    END{
        for(i in url){
            printf "%s:%d\n",i,url[i]
        }     
    }
    ' $file | sort -n -r -k 2 -t : | head -n 10 | 
     awk -F ':' '
       {printf "%s%-65s\t%s%d\n","Url:",$1,"number of occurrences:",$2}
    '  
    return
}
# Get4xxUrl

ShowUrl(){
    printf "===============Show Url for %s===============\n" "$1"
    awk -F '\t' -v url="$1" '
    NR>1{
        if($5==url){
            host[$1]++
        }
    }
    END{
        for(i in host){
            printf "%s:%d\n",i,host[i]
        }     
    }
    ' $file | sort -n -r -k 2 -t : | head -n 100 | 
     awk -F ':' '
       {printf "%s%-45s\t%s%d\n","Host:",$1,"number of occurrence:",$2}
    '  
    return 
}
# ShowUrl "/history/skylab/skylab-1.html"


while true;do
    case "$1" in
        -ho|--host) 
            GetHost; shift;;             
        -i|--ip)
            GetIp; shift;; 
        -u|--url)
            GetUrl; shift;; 
        -c|--condition) 
            GetCondition; shift;;
        -4|--4xx)
            Get4xxUrl;shift;;
        -us|--url_hosts)
            ShowUrl "/history/skylab/skylab-1.html"  ;shift;;
         "") break;;
    esac
done

log=log3.txt
echo "数据处理程序2开始运行">$log
echo "以下是shellcheck检测结果">>$log
shellcheck "$0">>$log