---
title: 以前瞎鼓捣画地图
author: Zhuoer Dong
date: '2017-11-25'
slug: r-plot-map
categories: 2017
tags: []
authors: []
---


以前某次英语课展示（应该是外教的）时，我想在地图上标一些经纬度。然后就想到与其手动加在图片上，肯定是用 R 代码来得更精确 ^[其实并无卵用，纯粹是装逼罢了。]。后来逐渐积累了一些画地图的方法，但至今没怎么用上，就现在放在这里。由于数据文件（`data-raw/res1_4m.shp`）较大，有些还要用到网络，我就不保证可重复了。






# china map with legend

```r
library(mapdata)  
library(maptools) 
#please clear all plots

# 中国地图  
map("china");

# 加载GIS数据  
mapdata<- readShapePoly("china map data/boundary/2/p.shp")  

# 测试数据  
plot(mapdata,col=gray(924:0/924))

# 定义地图颜色函数  
getColor <- function(mapdata,provname,provcol,othercol)   { 
  f=function(x,y) ifelse(x %in% y,which(y==x),0)  
  colIndex=sapply(iconv(mapdata@data$NAME,"GBK","UTF-8"),f,provname)  
  col=c(othercol,provcol)[colIndex+1]
  return(col)
}  

# 测试数据  
provname=c("北京市","天津市","上海市","重庆市")
provcol=c("red","green","yellow","purple") 
plot(mapdata,col=getColor(mapdata,provname,provcol,"white")) 
  
# 查看省份名  
as.character(na.omit(unique(mapdata@data$NAME)));  
  
# 画地图数据  
provname=c("北京市","天津市","河北省","山西省","内蒙古自治区", "辽宁省","吉林省","
           黑龙江省","上海市","江苏省", "浙江省","安徽省","福建省","江西省","山东省", 
           "河南省","湖北省","湖南省","广东省", "广西壮族自治区","海南省","重庆市",
           "四川省","贵州省", "云南省","西藏自治区","陕西省","甘肃省","青海省",
           "宁夏回族自治区","新疆维吾尔自治区","台湾省", "香港特别行政区") 
pop <- c(1633,1115,6943,3393,2405,4298,2730,3824,1858,7625, 5060,6118,3581,4368,9367,
         9360,5699,6355,9449, 4768,845,2816,8127,3762,4514,284,3748,2617, 552,610,2095,
         2296,693)  
  
# 构建图例的位置  
nf <- layout(matrix(c(1,1,1,1,1,2,1,1,1),3,3,byrow=TRUE), c(3,1), c(3,1), TRUE)
layout.show(nf)
  
provcol <- rgb(red=1-pop/max(pop)/1,green=1-pop/max(pop)/1,blue=1/1.5);  
plot(mapdata,col=getColor(mapdata,provname,provcol,"white"),xlab="",ylab="")  

# 整理数据  
pop <- pop - min(pop)  
pop=pop-min(pop)  
  
# 添加图例  
par(mar=c(0,0,0,0))  
par(mar=c(1,1,2,0),cex=0.5)  
barplot(as.matrix(rep(1,31)),col=sort(provcol,dec=T),horiz=T,axes=F,border = NA )  
axis(1,seq(1,32,by=3),sort(pop[seq(1,32,by=3)]))  

rm(mapdata,nf,pop,provcol,provname,getColor)
detach("package:mapdata")
detach("package:maptools")
detach("package:maps")
```

# ggmap

```r
library(ggmap)
library(mapproj)

#need access http://maps.googleapis.com
geocode("Hubei")
geocode("Nankai University", output = "more")
mapdist('Nankai University','Renmin University of China', 'walking')

map <- get_map(location = 'China', zoom = 4)
ggmap(map)

map <- get_map(location = 'Beijing', zoom = 10, maptype = 'roadmap')
ggmap(map)

map <- get_map(location = 'Renmin University of China', zoom = 14,
               maptype = 'satellite')
ggmap(map)
```


# map

```r
library(maps)
library(mapdata)

map("world", fill = TRUE, col = rainbow(200),ylim = c(-90, 90), mar = c(0, 0, 0, 0))
title("世界地图")

map("state", fill = TRUE, col = rainbow(209),mar = c(0, 0, 2, 0))
title("美国地图")

map('state', region = c('new york', 'new jersey', 'penn'),fill = TRUE, col = rainbow(3), mar = c(2, 3, 4, 3))
title("美国三州地图")

map("china", col = "red4", ylim = c(18, 54))
title(" 中国地图")

#画出美国各州的边界
plot.america<-function(){
  map('state', panel.first=grid())
  axis(1,lwd=0)
  axis(2,lwd=0)
  axis(3,lwd=0)
  axis(4,lwd=0)
  box()
}
#标出美国的城市
plot.america()
data(us.cities)
points(us.cities$long, us.cities$lat, pch=19)
#标出人口大于一百万的城市
plot.america()
cities <- us.cities[us.cities$pop > 1000000,]
points(cities$long, cities$lat, pch=19)
text(cities$long, cities$lat, cities$name, col="blue", cex=0.8, pos=1)
```


# openmap

```r
library(OpenStreetMap)
library(ggplot2)

#type available
ta<-c("osm", "maptoolkit-topo", "mapquest","mapquest-aerial", "bing", "stamen-toner",
      "stamen-watercolor", "esri", "esri-topo","nps", "apple-iphoto", "skobbler")

#the United States
autoplot(openmap(c(50,-130), c(20,-60),type="apple-iphoto",minNumTiles=3))
autoplot(openmap(c(50,-130), c(20,-60),type="apple-iphoto",minNumTiles=5))
autoplot(openmap(c(50,-130), c(20,-60),type="apple-iphoto",minNumTiles=13))

#China
autoplot(openmap(c(53.55,73.55),c(3.85,135.1),type="apple-iphoto",minNumTiles=3))
autoplot(openmap(c(53.55,73.55),c(3.85,135.1),type="apple-iphoto",minNumTiles=7))
autoplot(openmap(c(53.55,73.55),c(3.85,135.1),type="apple-iphoto",minNumTiles=13))

#be careful, this will take several minutes to run
par(mfcol=c(3,4))
for(i in 1:length(ta)){
  map <- openmap(c(53.55,73.55),c(3.85,135.1),type=ta[i],minNumTiles=7)
  plot(map)
}
```


# sp

get spatial mapdata from http://www.gadm.org/

```r
?sp::spplot
```

