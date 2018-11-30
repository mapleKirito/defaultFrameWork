
//---------------------------------------------------    
// 日期格式化    
// 格式 YYYY/yyyy/YY/yy 表示年份    
// MM/M 月份    
// W/w 星期    
// dd/DD/d/D 日期    
// hh/HH/h/H 时间    
// mm/m 分钟    
// ss/SS/s/S 秒    
//---------------------------------------------------    
Date.Format = function(data, formatStr)     
{     
    var str = formatStr;     
    var Week = ['日','一','二','三','四','五','六'];    
    
    str=str.replace(/yyyy|YYYY/,data.getFullYear());     
    str=str.replace(/yy|YY/,(data.getYear() % 100)>9?(data.getYear() % 100).toString():'0' + (data.getYear() % 100));     
    
    var month = data.getMonth()+1 ;
    str=str.replace(/MM/,month>9?month.toString():'0' + month);     
    str=str.replace(/M/g,month);     
    
    str=str.replace(/w|W/g,Week[data.getDay()]);     
    
    str=str.replace(/dd|DD/,data.getDate()>9?data.getDate().toString():'0' + data.getDate());     
    str=str.replace(/d|D/g,data.getDate());     
    
    str=str.replace(/hh|HH/,data.getHours()>9?data.getHours().toString():'0' + data.getHours());     
    str=str.replace(/h|H/g,data.getHours());     
    str=str.replace(/mm/,data.getMinutes()>9?data.getMinutes().toString():'0' + data.getMinutes());     
    str=str.replace(/m/g,data.getMinutes());     
    
    str=str.replace(/ss|SS/,data.getSeconds()>9?data.getSeconds().toString():'0' + data.getSeconds());     
    str=str.replace(/s|S/g,data.getSeconds());     
    
    return str;     
}