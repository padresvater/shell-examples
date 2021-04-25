线上环境代码运行情况

![](https://travis-ci.com/padresvater/shell-examples.svg?branch=master)

***for 2021 Linux***

### 代码运行情况
#### 任务一
- 命令行输入 ```bash image_processing.sh -h```

- 终端输出

    ========图片处理脚本的帮助文档========

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

    -com,--compress            对图片进行质量压缩时的质量参数，质量为1（最低图像质量和最高压缩率）
                               到100（最佳质量但有效压缩率最低）。
                               默认值是如果可以确定，则使用输入图像的估计质量，否则使用92。
                               如果质量大于90，则不会对色度通道进行下采样。

    -res,--resize              保持原始宽高比的前提下压缩分辨率的比率

    -w,--watermark             需要在图片中添加的文本水印

    -ren,--rename              重命名图片,作为前缀添加到文件名中而不改变拓展名。

    -con,--convert             将png和svg图片转化为jpg格式，不改变原有文件名。

- 接着输入```bash image_processing.sh -w -res```

- 终端输出

    =========分辨率压缩完成=========
    ==========添加水印完成==========

- shellcheck
```
程序开始运行
if_com=0
if_res=1
if_aw=1
if_ren=0
if_con=0
以下为shellcheck检查结果

In image_processing.sh line 52:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In image_processing.sh line 53:
    for file in "$path"/*.png;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In image_processing.sh line 54:
        ( convert "$file" -compress JPEG -quality $quality "$out"/"compressed_${file##*/}.jpg")
                                                                 ^-- SC2140: Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?


In image_processing.sh line 62:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In image_processing.sh line 63:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In image_processing.sh line 65:
            convert "$file" -resize $resize "$out"/"resolution_${file##*/}"
                                                  ^-- SC2140: Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?


In image_processing.sh line 75:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In image_processing.sh line 76:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In image_processing.sh line 88:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In image_processing.sh line 89:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In image_processing.sh line 98:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In image_processing.sh line 99:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In image_processing.sh line 130:
echo "if_com=$if_com">>$log
^-------------------------^ SC2129: Consider using { cmd1; cmd2; } >> file instead of individual redirects.

For more information:
  https://www.shellcheck.net/wiki/SC2128 -- Expanding an array without an ind...
  https://www.shellcheck.net/wiki/SC2140 -- Word is of the form "A"B"C" (B in...
  https://www.shellcheck.net/wiki/SC2206 -- Quote to prevent word splitting/g...

```

#### 任务二
- 命令行输入 ```bash data_processing1.sh -h ```

- 终端输出 
    
    ==============世界杯运动员信息处理程序的帮助文档==============

        
    -h,--help                  显示本脚本的帮助文档

    -a,--age                   统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比

    -p,--position              统计不同场上位置的球员数量、百分比

    -ns,--name_search          寻查名字最长的球员是谁？名字最短的球员是谁？

    -as,--age_search           寻查年龄最大的球员是谁？年龄最小的球员是谁？
    ============================end============================ 

    - 命令行输入 ```bash data_processing1.sh -a -p  ``` 

    - 终端输出
```
===============Age Statistics===============
Amount and Proportion of Age under 20             :    9        0.012
Amount and Proportion of Age between 20 and 30    :  600        0.815 
Amount and Proportion of Age greater than 30      :  127        0.173 
============Position Statistics============
amount of Défenseur          1          proportion: 0.001
amount of Midfielder       268          proportion: 0.364
amount of Defender         236          proportion: 0.321
amount of Forward          135          proportion: 0.183
amount of Goalie            96          proportion: 0.130
```

shellcheck并没有检测出错误

#### 任务三
命令行输入 ```bash data_processing2.sh -h```

终端输出
```
==============网络日志信息处理程序的帮助文档==============

        
    -h,--help                  显示本脚本的帮助文档

    -ho,--host                 统计访问来源主机TOP 100和分别对应出现的总次数   

    -i,--ip                    统计访问来源主机TOP 100 IP和分别对应出现的总次数

    -u,--url                   统计最频繁被访问的URL TOP 100

    -c,--condition             统计不同响应状态码的出现次数和对应百分比

    -4,--4xx                   分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
    
    -us,--url_hosts            给定URL输出TOP 100访问来源主机
============================end============================ 
```

命令行输入```bash data_processing2.sh -u -ho```

终端输出
```
=====TOP100 Url And its number of occurrences=====
Url:/images/NASA-logosmall.gif                                  Apperance:97410
Url:/images/KSC-logosmall.gif                                   Apperance:75337
Url:/images/MOSAIC-logosmall.gif                                Apperance:67448
Url:/images/USA-logosmall.gif                                   Apperance:67068
Url:/images/WORLD-logosmall.gif                                 Apperance:66444
Url:/images/ksclogo-medium.gif                                  Apperance:62778
Url:/ksc.html                                                   Apperance:43687
Url:/history/apollo/images/apollo-logo1.gif                     Apperance:37826
Url:/images/launch-logo.gif                                     Apperance:35138
Url:/                                                           Apperance:30346
Url:/images/ksclogosmall.gif                                    Apperance:27810
Url:/shuttle/missions/sts-69/mission-sts-69.html                Apperance:24606
Url:/shuttle/countdown/                                         Apperance:24461
Url:/shuttle/missions/sts-69/count69.gif                        Apperance:24383
Url:/shuttle/missions/sts-69/sts-69-patch-small.gif             Apperance:23405
Url:/shuttle/missions/missions.html                             Apperance:22453
Url:/images/launchmedium.gif                                    Apperance:19877
Url:/htbin/cdt_main.pl                                          Apperance:17247
Url:/shuttle/countdown/images/countclock.gif                    Apperance:12160
Url:/icons/menu.xbm                                             Apperance:12137
Url:/icons/blank.xbm                                            Apperance:12057
Url:/software/winvn/winvn.html                                  Apperance:10345
Url:/icons/image.xbm                                            Apperance:10308
Url:/history/history.html                                       Apperance:10134
Url:/history/apollo/images/footprint-logo.gif                   Apperance:10126
Url:/history/apollo/images/apollo-small.gif                     Apperance:9439
Url:/history/apollo/images/footprint-small.gif                  Apperance:9230
Url:/software/winvn/winvn.gif                                   Apperance:9037
Url:/history/apollo/apollo.html                                 Apperance:8985
Url:/software/winvn/wvsmall.gif                                 Apperance:8662
Url:/software/winvn/bluemarb.gif                                Apperance:8610
Url:/htbin/cdt_clock.pl                                         Apperance:8583
Url:/shuttle/countdown/liftoff.html                             Apperance:7865
Url:/shuttle/resources/orbiters/orbiters-logo.gif               Apperance:7389
Url:/images/shuttle-patch-logo.gif                              Apperance:7261
Url:/history/apollo/apollo-13/apollo-13.html                    Apperance:7177
Url:/images/                                                    Apperance:7040
Url:/shuttle/countdown/video/livevideo2.gif                     Apperance:7029
Url:/images/kscmap-tiny.gif                                     Apperance:6615
Url:/shuttle/technology/sts-newsref/stsref-toc.html             Apperance:6517
Url:/history/apollo/apollo-13/apollo-13-patch-small.gif         Apperance:6309
Url:/shuttle/missions/sts-71/sts-71-patch-small.gif             Apperance:5613
Url:/shuttle/missions/sts-69/images/images.html                 Apperance:5264
Url:/icons/text.xbm                                             Apperance:5248
Url:/images/construct.gif                                       Apperance:5093
Url:/images/shuttle-patch-small.gif                             Apperance:4869
Url:/shuttle/missions/sts-69/movies/movies.html                 Apperance:4846
Url:/shuttle/missions/sts-70/sts-70-patch-small.gif             Apperance:4791
Url:/icons/unknown.xbm                                          Apperance:4785
Url:/shuttle/missions/sts-69/liftoff.html                       Apperance:4559
Url:/facilities/lc39a.html                                      Apperance:4464
Url:/shuttle/resources/orbiters/endeavour.html                  Apperance:4434
Url:/history/apollo/images/apollo-logo.gif                      Apperance:4365
Url:/shuttle/missions/sts-70/mission-sts-70.html                Apperance:4066
Url:/images/lc39a-logo.gif                                      Apperance:4024
Url:/shuttle/resources/orbiters/endeavour-logo.gif              Apperance:3817
Url:/shuttle/technology/sts-newsref/sts_asm.html                Apperance:3706
Url:/shuttle/countdown/countdown.html                           Apperance:3518
Url:/shuttle/missions/sts-71/movies/movies.html                 Apperance:3507
Url:/shuttle/countdown/video/livevideo.jpeg                     Apperance:3377
Url:/history/apollo/apollo-11/apollo-11.html                    Apperance:3140
Url:/shuttle/missions/sts-71/mission-sts-71.html                Apperance:3130
Url:/shuttle/missions/sts-70/images/images.html                 Apperance:3087
Url:/shuttle/missions/sts-71/images/images.html                 Apperance:2945
Url:/shuttle/missions/sts-73/mission-sts-73.html                Apperance:2939
Url:/images/faq.gif                                             Apperance:2865
Url:/shuttle/technology/images/srb_mod_compare_1-small.gif      Apperance:2864
Url:/shuttle/technology/images/srb_mod_compare_3-small.gif      Apperance:2818
Url:/shuttle/technology/images/srb_mod_compare_6-small.gif      Apperance:2715
Url:/history/apollo/apollo-11/apollo-11-patch-small.gif         Apperance:2701
Url:/elv/elvpage.htm                                            Apperance:2586
Url:/shuttle/missions/sts-73/sts-73-patch-small.gif             Apperance:2544
Url:/shuttle/countdown/video/sts-69-prelaunch-pad.gif           Apperance:2385
Url:/shuttle/missions/51-l/mission-51-l.html                    Apperance:2343
Url:/images/launch-small.gif                                    Apperance:2293
Url:/facilities/tour.html                                       Apperance:2256
Url:/shuttle/missions/51-l/51-l-patch-small.gif                 Apperance:2201
Url:/images/kscmap-small.gif                                    Apperance:2172
Url:/shuttle/resources/orbiters/challenger.html                 Apperance:2171
Url:/shuttle/missions/sts-71/movies/sts-71-launch.mpg           Apperance:2159
Url:/shuttle/technology/sts-newsref/sts-lcc.html                Apperance:2146
Url:/htbin/wais.pl                                              Apperance:2133
Url:/facts/about_ksc.html                                       Apperance:2120
Url:/history/mercury/mercury.html                               Apperance:2107
Url:/images/mercury-logo.gif                                    Apperance:2040
Url:/elv/elvhead3.gif                                           Apperance:1991
Url:/images/launchpalms-small.gif                               Apperance:1979
Url:/images/whatsnew.gif                                        Apperance:1936
Url:/history/apollo/apollo-spacecraft.txt                       Apperance:1929
Url:/facilities/vab.html                                        Apperance:1915
Url:/shuttle/resources/orbiters/columbia.html                   Apperance:1912
Url:/shuttle/countdown/lps/fr.html                              Apperance:1908
Url:/shuttle/resources/orbiters/challenger-logo.gif             Apperance:1904
Url:/images/ksclogo.gif                                         Apperance:1892
Url:/whats-new.html                                             Apperance:1891
Url:/elv/endball.gif                                            Apperance:1874
Url:/history/apollo/apollo-13/apollo-13-info.html               Apperance:1869
Url:/shuttle/missions/sts-74/mission-sts-74.html                Apperance:1868
Url:/elv/PEGASUS/minpeg1.gif                                    Apperance:1845
Url:/elv/SCOUT/scout.gif                                        Apperance:1835
=====Top100 Hosts and its number of occurrences=====
Host:edams.ksc.nasa.gov                 number of occurrences:6530
Host:piweba4y.prodigy.com               number of occurrences:4846
Host:163.206.89.4                       number of occurrences:4791
Host:pc_ds                              number of occurrences:4608
Host:piweba5y.prodigy.com               number of occurrences:4607
Host:piweba3y.prodigy.com               number of occurrences:4416
Host:www-d1.proxy.aol.com               number of occurrences:3889
Host:www-b2.proxy.aol.com               number of occurrences:3534
Host:www-b3.proxy.aol.com               number of occurrences:3463
Host:www-c5.proxy.aol.com               number of occurrences:3423
Host:www-b5.proxy.aol.com               number of occurrences:3411
Host:www-c2.proxy.aol.com               number of occurrences:3407
Host:www-d2.proxy.aol.com               number of occurrences:3404
Host:www-a2.proxy.aol.com               number of occurrences:3337
Host:news.ti.com                        number of occurrences:3298
Host:www-d3.proxy.aol.com               number of occurrences:3296
Host:www-b4.proxy.aol.com               number of occurrences:3293
Host:www-c3.proxy.aol.com               number of occurrences:3272
Host:www-d4.proxy.aol.com               number of occurrences:3234
Host:www-c1.proxy.aol.com               number of occurrences:3177
Host:www-c4.proxy.aol.com               number of occurrences:3134
Host:intgate.raleigh.ibm.com            number of occurrences:3123
Host:www-c6.proxy.aol.com               number of occurrences:3088
Host:www-a1.proxy.aol.com               number of occurrences:3041
Host:mpngate1.ny.us.ibm.net             number of occurrences:3011
Host:e659229.boeing.com                 number of occurrences:2983
Host:piweba1y.prodigy.com               number of occurrences:2957
Host:webgate1.mot.com                   number of occurrences:2906
Host:www-relay.pa-x.dec.com             number of occurrences:2761
Host:beta.xerox.com                     number of occurrences:2318
Host:poppy.hensa.ac.uk                  number of occurrences:2311
Host:vagrant.vf.mmc.com                 number of occurrences:2237
Host:palona1.cns.hp.com                 number of occurrences:1910
Host:www-proxy.crl.research.digital.com number of occurrences:1793
Host:koriel.sun.com                     number of occurrences:1762
Host:derec                              number of occurrences:1681
Host:trusty.lmsc.lockheed.com           number of occurrences:1637
Host:gw2.att.com                        number of occurrences:1623
Host:cliffy.lfwc.lockheed.com           number of occurrences:1563
Host:inet2.tek.com                      number of occurrences:1503
Host:disarray.demon.co.uk               number of occurrences:1485
Host:gw1.att.com                        number of occurrences:1467
Host:128.217.62.1                       number of occurrences:1435
Host:interlock.turner.com               number of occurrences:1395
Host:163.205.1.19                       number of occurrences:1360
Host:sgigate.sgi.com                    number of occurrences:1354
Host:bocagate.bocaraton.ibm.com         number of occurrences:1336
Host:piweba2y.prodigy.com               number of occurrences:1324
Host:gw3.att.com                        number of occurrences:1311
Host:keyhole.es.dupont.com              number of occurrences:1310
Host:n1144637.ksc.nasa.gov              number of occurrences:1297
Host:163.205.3.104                      number of occurrences:1292
Host:163.205.156.16                     number of occurrences:1256
Host:163.205.19.20                      number of occurrences:1252
Host:erigate.ericsson.se                number of occurrences:1216
Host:gn2.getnet.com                     number of occurrences:1211
Host:gwa.ericsson.com                   number of occurrences:1089
Host:tiber.gsfc.nasa.gov                number of occurrences:1079
Host:128.217.62.2                       number of occurrences:1054
Host:bstfirewall.bst.bls.com            number of occurrences:1017
Host:163.206.137.21                     number of occurrences:1015
Host:spider.tbe.com                     number of occurrences:1013
Host:gatekeeper.us.oracle.com           number of occurrences:1010
Host:www-c8.proxy.aol.com               number of occurrences:995
Host:whopkins.sso.az.honeywell.com      number of occurrences:984
Host:news.dfrc.nasa.gov                 number of occurrences:966
Host:128.159.122.110                    number of occurrences:949
Host:proxy0.research.att.com            number of occurrences:940
Host:proxy.austin.ibm.com               number of occurrences:925
Host:www-c9.proxy.aol.com               number of occurrences:902
Host:bbuig150.unisys.com                number of occurrences:901
Host:corpgate.nt.com                    number of occurrences:899
Host:sahp315.sandia.gov                 number of occurrences:890
Host:amdext.amd.com                     number of occurrences:869
Host:128.159.132.56                     number of occurrences:848
Host:n1121796.ksc.nasa.gov              number of occurrences:830
Host:igate.uswest.com                   number of occurrences:825
Host:gatekeeper.cca.rockwell.com        number of occurrences:819
Host:wwwproxy.sanders.com               number of occurrences:815
Host:gw4.att.com                        number of occurrences:814
Host:goose.sms.fi                       number of occurrences:812
Host:128.159.144.83                     number of occurrences:808
Host:pc_nm                              number of occurrences:805
Host:jericho3.microsoft.com             number of occurrences:805
Host:128.159.111.141                    number of occurrences:798
Host:jericho2.microsoft.com             number of occurrences:786
Host:sdn_b6_f02_ip.dny.rockwell.com     number of occurrences:782
Host:lamar.d48.lilly.com                number of occurrences:778
Host:163.205.11.31                      number of occurrences:776
Host:heimdallp2.compaq.com              number of occurrences:772
Host:stortek1.stortek.com               number of occurrences:771
Host:163.205.16.75                      number of occurrences:762
Host:mac998.kip.apple.com               number of occurrences:759
Host:tia1.eskimo.com                    number of occurrences:742
Host:www-e1f.gnn.com                    number of occurrences:733
Host:www-b1.proxy.aol.com               number of occurrences:718
Host:reddragon.ksc.nasa.gov             number of occurrences:715
Host:128.159.122.137                    number of occurrences:711
Host:rmcg.cts.com                       number of occurrences:701
Host:bambi.te.rl.ac.uk                  number of occurrences:701
```

shellcheck并没有检测出错误