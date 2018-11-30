//jquery 动态画表格
/**表格样式
 <table>
  <thead>
    <tr>
      <th>column1</th>
      <th>column2</th>
      <th>column3</th>
      <th>column4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>test</td>
      <td>test</td>
      <td>test</td>
    </tr>
    <tr>
      <td>test</td>
      <td>test</td>
      <td>test</td>
    </tr>    
  </tbody> 
 </table> 
  **/
//调用举例
/**
var gridtb;
$(document).ready(function(){	
	 gridTB = $('#grid').gridTB({
	    globalParam:$("#actionForm").formSerialize(),
	    //first,last
    	checkbox:{name:'全选',type:'first',width:'10%'},
    	shortcut:{
    		name:'操作',
	    	url:'test.jsp',
	    	width:'25%',
	    	event:{
    			create:{name:'添加',param:'code=${pmsIndex.sys_org_create.code}'},
	    		del:{name:'删除',param:'code=${pmsIndex.sys_org_delete.code}'},
		    	modify:{name:'修改',param:'code=${pmsIndex.sys_org_modify.code}'},
		    	detail:{name:'明细',param:'code=${pmsIndex.sys_org_detail.code}'}
	        }
	    },
    	columnDesc:{
	    	//列表要显示的列（在json中对应的key）
			showColumn: ['orgName','orgCode','orgGrade'],
			//列表头显示名称
			columnName:   ['机构名称','机构代码','机构类型'],
			//列表头宽度
			columnWidth:   ['20%','20%','20%'],
			//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
			//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
			primkeyColumn:["orgID","orgParentID"],
			//要增加链接的列，可以为多个
			linkColumn:[{name:'orgName',url:'aa.html',param:''}],
			treeIndexColumn:{
			//要进行树型显示的列，支持一列
			treeColumn:'orgName',
			//树型菜单，起始根值
			indexStartValue:'0',
			//属性菜单子列
			index:'orgID',
			//属性菜单父列
			parendIndex:'orgParentID'}
    	},		
    	ajax:{
        	url:'ajaxAction.action',
        	data:'code=${code}'	
	    },
    	columnData:[]
		// {orgID:'11',orgParentID:'0',orgName:'11',address:'北京',orgType:'31'},
		 //{orgID:'12',orgParentID:'11',orgName:'测试12',address:'北京',orgType:'32'},
		 //{orgID:'13',orgParentID:'11',orgName:'测试13',address:'北京',orgType:'33'},
		 //{orgID:'14',orgParentID:'12',orgName:'测试14',address:'北京',orgType:'34'},
		 //{orgID:'15',orgParentID:'12',orgName:'测试15',address:'北京',orgType:'35'},
		 //{orgID:'16',orgParentID:'11',orgName:'测试16',address:'北京',orgType:'36'},
		 //{orgID:'17',orgParentID:'0',orgName:'测试17',address:'北京',orgType:'37'},
		 //{orgID:'18',orgParentID:'14',orgName:'测试18',address:'北京',orgType:'38'},
		 //{orgID:'19',orgParentID:'17',orgName:'测试19',address:'北京',orgType:'39'},
		 //{orgID:'20',orgParentID:'13',orgName:'测试20',address:'北京',orgType:'40'}]
    	,
    	paginationData:{
			pageSize:'10'
    	}		    		 
	 },{
		autoclose: true,
		columnAlias:function(col,val){
			if(col == 'orgName')
			{
				if (val == '11')
					val = "一";
				else if (val == '2')
					val =  "二";
				else if (val == '3')
					val =  "三";								
			}
			return val;
		}
	});
});
**/
//data：json格式字段描述，表格内容，分页描述
//opt：     相关操作对外开放配置或扩展
$.fn.gridTB = function(data,opt){
	
		//表格类对象
		var GRID = this;	
		//总记录数
		var recordCount = 0;
		//每页显示记录数
		var pageSize=8;	
		//当前页数
		var currentPage = 0;
		//总页数
		var paeCount = 0;
		//字段排序信息
		var order = "";
		//画表格所用相关数据
		GRID.data = {
				//系统全局参数，表单id
				formID:'actionForm',					
				//系统全局参数，主要是form内空间的值对参数
				globalParam:'',
				//列表模式，image和detail两种，默认是image
				mode:'image',
				//表格字段描述信息
				columnDesc:	Array(),
				//ajax参数请求配置信息
				ajax:Array(),
				//表格内容json格式数据，一旦配置此数据
				//系统不再进行ajax异步请求获取数据
				columnData:	Array(),
			    //是否有分页工具条，默认有值为true
			    isPagination:'true',				
				//分页相关配置信息
				paginationData:	Array(),
				//disabledRow
				disabledRow: '-1',
				//rowDisabled
				rowDisabled: 'false'
		};			
		//画表格相关操作定义
		GRID.option = {		
				//表格行单击事件
				trClick:    false,
				//快捷菜单单击事件
				shortcutClick:	false,
				//字段列别名处理事件，此事件在画表格时候调用
				columnAlias:false,
				//表格列单击事件
				columnClick:false,
				//画快捷菜单切入函数
				extendDrawShortcut:false,
				//处理行状态
				handerShortcutStatus:false,
				//扩展初始化函数
				extendInit:false
		};	
		
		//ajax请求，系统默认配置参数，此参数可以通过外围配置覆盖
		GRID.ajax = {
				//ajax请求url
				url:		'',
				//ajax提交方式
				type:	    'post',
				//ajax请求超时时长
				timeout:	'60000',
				//ajax请求参数
				data:	Array(),
				//请求数据类型，包括json和xml两种
				dataType:	'json',
				
				beforeSend:function(request){
					var $img = $("<img>")
						.attr("src","images/wait/loader.gif")
						.attr("width","50")
						.attr("height","50") 
						.attr("border","0");
					GRID.attr("align","center");
					GRID.html($img);
				},
				
				complete:function(request,textStatus){},
				
				success:function(jsonData,textStatus){
					//如果正常返回,设置GRID.data.columnData
					//为ajax请求放回的json格式的数据
					if (textStatus == "success"){
						if(jsonData.data)
							GRID.data.columnData = jsonData.data;
						if (jsonData.paginatedData)
							GRID.data.paginationData = jsonData.paginatedData;
						//先清空在画表格
						GRID.html("");
						//在目标元素内画表格
						GRID.html(GRID.drawGrid());
						//设置表格体tr的样式和事件
						GRID.gridEvent();		
						//表格画好之后，可以执行一些默认设置函数
						if (typeof GRID.option.extendInit == 'function'){
							GRID.option.extendInit();
						}
					}
				},
				
				error:function(request,textStatus,error){}
		};	

		//将配置的数据替换，增加到data对象中
		GRID.data = $.extend(GRID.data,data);
		//将配置的数据替换，增加到option对象中
		GRID.option = $.extend(GRID.option,opt);
		//将配置的数据替换，增加到ajax对象中
		GRID.ajax = $.extend(GRID.ajax,GRID.data.ajax);
	    
		//计算主键值串
		GRID.getPrimkey = function(row)
		{
			var rkey = '';
			if (GRID.data.columnDesc.primkeyColumn){
				$.each(GRID.data.columnDesc.primkeyColumn,function(i){
					if (GRID.data.columnData[row]){
						var key = eval("GRID.data.columnData["+row+"]." + this);
						if (i==0){
							rkey = this + "=" + key;
						}
						else{
							rkey += "##" + this + "=" + key;
						}			
					}
				});
			}
			return rkey;
		};
		
		//设置每列是否有连接
		GRID.addColumnLink = function(row,key,val)
		{
			var $rval = val;
			var collink = GRID.data.columnDesc.linkColumn;
			if (collink){
				$.each(collink,function(i){
					if (collink[i].name == key){
						$rval = $("<a>"+val+"</a>")
						.addClass(key)
						.attr("id",row)
						.attr("href","#");						
					}
				});
			}
			return $rval;
		};
		
		//画表格的body
		GRID.drawGridBody = function()
		{
			var $body = $("<tbody></tbody>").attr("id","gridTbody");
			if (GRID.data.mode == 'image'){
				var len = GRID.data.columnData.length;
				var rownum = GRID.data.columnDesc.imgWidth?4:GRID.data.columnDesc.rownum;
				var mod = len % rownum;
				$.each(GRID.data.columnData,function(i){
					if (i%rownum == 0){
						$btr = $("<tr></tr>");
					}
					
					if(typeof GRID.option.handerShortcutStatus == 'function'){
						GRID.data.disabledRow = GRID.option.handerShortcutStatus(GRID.data.columnData[i],i);
					}
					if (GRID.data.columnDesc.showColumn){
						$.each(GRID.data.columnDesc.showColumn,function(j){
							var colname = GRID.data.columnDesc.showColumn[j];
							var val = eval("GRID.data.columnData[" + i + "]." + colname);
							//调用别名转换函数
							if (typeof GRID.option.columnAlias == 'function')
							{
								val = GRID.option.columnAlias(colname,val);
							}
							var $ncol = GRID.addColumnLink(i,colname,val);
							$btr.append(
									$("<td></td>").append(
										$("<div></div>").append(
											$("<p></p>").append(
													$("<img></img>").attr("border","0")
													.attr("src",$ncol)
													.attr("width",GRID.data.columnDesc.imgWidth?148:GRID.data.columnDesc.imgWidth)
													.attr("height",GRID.data.columnDesc.imgHeight?114:GRID.data.columnDesc.imgHeight)
											).attr("class","pIma")
										).append(
												$("<p></p>").append(
													$("<b></b>").text("大熊猫")	
												).append(
													$("<span></span>").attr("class","spandown").append(
														$("<img></img>").attr("border","0")
														.attr("src","images/main/ima_27.jpg")
														.attr("width","20")
														.attr("height","11")															
													)
												)
										).attr("class","bg")
									)
									.attr("class","tds")
									.attr("align","center")
									.attr("width","25%")
								);
						});
					}
					if (i == (len -1)){
						for (var n=0; n<mod; n++){
							$btr.append(
								$("<td></td>").append("&nbsp;").attr("class","gridBodyTd")
									.attr("align","center")								
							);
						}
					}
					$body.append($btr);
				});
			}
			else{
				$.each(GRID.data.columnData,function(i){
					$btr = $("<tr></tr>");
					if(typeof GRID.option.handerShortcutStatus == 'function'){
						GRID.data.disabledRow = GRID.option.handerShortcutStatus(GRID.data.columnData[i],i);
					}
					if (GRID.data.columnDesc.showColumn){
						$.each(GRID.data.columnDesc.showColumn,function(j){
							var colname = GRID.data.columnDesc.showColumn[j];
							var val = eval("GRID.data.columnData[" + i + "]." + colname);
							//调用别名转换函数
							if (typeof GRID.option.columnAlias == 'function')
							{
								val = GRID.option.columnAlias(colname,val);
							}
							var $ncol = GRID.addColumnLink(i,colname,val);
							$btr.append(
									$("<td></td>").append(
										$("<a></a>").append(
											$("<img></img>").attr("border","0")
											.attr("src",$ncol)
											.attr("width",GRID.data.columnDesc.imgWidth?148:GRID.data.columnDesc.imgWidth)
											.attr("height",GRID.data.columnDesc.imgHeight?114:GRID.data.columnDesc.imgHeight)
										).attr("href","#")
									)
									.attr("class","gridBodyTd")
									.attr("align","center")
								);
						});
					}
					$body.append($btr);
				});				
			}
			return $body;
		};
		
		
		//设置表格体行的样式，并绑定相关事件
		GRID.gridEvent = function()
		{
			//设置列表内容自动换行
			$("#"+GRID.attr("id")+" tbody td").css({"word-wrap":"break-word","word-break":"break-all"});

			//表格列连接事件
			if (GRID.data.columnDesc.linkColumn){
				$.each(GRID.data.columnDesc.linkColumn,function(i){
					var col = GRID.data.columnDesc.linkColumn[i].name;
					var param = GRID.data.columnDesc.linkColumn[i].param;
					if(col)
					{
						$("#gridTable tbody a").filter("."+col).each(function(){
							var key = $(this).attr("id");
							//主键串
							var pk = GRID.getPrimkey(key);						
							$(this).bind("click",function(){
								//对外开放的函数，若写此函数，就调用此函数
								if (typeof GRID.option.columnClick == 'function'){
									GRID.option.columnClick($(this),param + "##" + pk);
								}
								else{
									var arrParam = pk.split("##");
									for(var a=0; a<arrParam.length;a++){
										if (arrParam[a]){
											var arrValMap = arrParam[a].split("=");
											if (arrValMap[0] && arrValMap[1]){
												$("#hide_"+arrValMap[0]).val(arrValMap[1]);
											}
										}
									}
									var fsrc = $("#" +GRID.data.formID).attr("action");
									$("#" +GRID.data.formID).attr("action",fsrc + "?" + param);
									$("#" +GRID.data.formID).submit();									
								}
							});
						});						
					}
				});
			}
			$("#"+GRID.attr("id")+" tbody a").filter(".pagea").each(function(){
				$(this).bind("click",function(){
					var aid = $(this).attr("id");
					var pgs = 10;
					if (GRID.data.paginationData.pageSize){
						pgs = GRID.data.paginationData.pageSize;
					}
					GRID.ajax.data = GRID.data.ajax.data 
					+ "&currentPage="+ aid 
					+ "&pageSize=" + pgs 
					+ "&" + GRID.data.globalParam;
					if (order != ""){
						GRID.ajax.data += "&paramMap.order="+order;
					}
					GRID.ajax.data = GRID.ajax.data;
					$.ajax(GRID.ajax);
				});
			});
			$("#pagego").bind("click",function (){
				var targetPage = $("#targetPage").attr("value");
			    if (targetPage <= 0 || targetPage > GRID.pageCount) 
			    {
			        alert("您输入的页数不能大于总页数！");
			        $("#targetPage").focus();
			        return false;
			    }
			    if (!targetPage.match(/^[0-9]*[0-9]$/)) 
			    {
			        alert("跳转页数必须为数字！");
			        $("#targetPage").focus();
			        return false;
			    }				
				var pgs = 10;
				if (GRID.data.paginationData.pageSize)
					pgs = GRID.data.paginationData.pageSize;					
				GRID.ajax.data = GRID.data.ajax.data 
				+ "&currentPage="+ targetPage 
				+ "&pageSize=" + pgs 
				+ "&" + GRID.data.globalParam;
				if (order != ""){
					GRID.ajax.data += "&paramMap.order="+order;
				}		
				GRID.ajax.data = GRID.ajax.data;
				$.ajax(GRID.ajax);				
			});
			
			$("#targetPage").bind("keydown",function (){
				if(event.keyCode == 13){
					return false;
				}
			});
			
		};
	     
		//计算分页参数
		GRID.pageParam = function(){
			
			if (GRID.data.paginationData){
				//总记录数
				this.recordCount = GRID.data.paginationData.recordCount ? GRID.data.paginationData.recordCount:0;
			}
			else{
				this.recordCount = 0;
			}
			if (!this.recordCount)
				this.recordCount = GRID.data.columnData.length ? GRID.data.columnData.length : '0';
			if (GRID.data.paginationData){
				//每页记录数
				this.pageSize = GRID.data.paginationData.pageSize ? GRID.data.paginationData.pageSize:0;
			}
			else{
				this.pageSize=8;
			}		
			
			if (GRID.data.paginationData){
				//当前页数
				this.currentPage = GRID.data.paginationData.currentPage ? GRID.data.paginationData.currentPage:0;
			}
			else{
				this.currentPage = 0;
			}


	        if (this.recordCount % this.pageSize == 0)
	        {
	        	this.pageCount = this.recordCount / this.pageSize;
	        }
	        else 
	        {
	        	this.pageCount = parseInt(this.recordCount / this.pageSize) + 1;
	        }
	        if (this.pageCount < 1) 
	        {
	        	this.currentPage = 0;
	        } 
	        else if (this.currentPage >= this.pageCount) 
	        {
	            if (this.pageCount != 0) 
	            {
	            	this.currentPage = this.pageCount;
	            }
	        }	
	        else if(this.pageCount == 1)
	        {
	        	this.currentPage = 1;
	        }
		};
		//画 表格分页
		GRID.drawPage = function()
		{
			//计算分页参数
			GRID.pageParam();
			var $page = $("<p>第 <font color='#FF0000'> " 
					+ this.currentPage + "</font>/<font color='#FF0000'>" 
		            + this.pageCount + "</font> 页 每页<font color='#FF0000'> " 
		            + this.pageSize + "</font> 条 共 <font color='#FF0000'> " 
		            + this.recordCount + "</font> 条</p>");
			if (this.currentPage <= 1){
				$page.append($("<span>&nbsp;</span>")
						.append($("<img/>")
						.attr("src","images/page/first_d.gif")
						.attr("title","首  页")
						.attr("border","0")))
					 .append($("<span>&nbsp;</span>")
						.append($("<img/>")
						.attr("src","images/page/prev_d.gif")
						.attr("title","上一页")
						.attr("border","0")));
			}
			else{
				$page.append($("<span>&nbsp;</span>")
						.append($("<a></a>")
						.attr("href","#")
						.attr("id","1")
						.addClass("pagea")
				        .append($("<img/>")
						.attr("src","images/page/first_h.gif")
						.attr("title","首  页")
						.attr("border","0"))))
					 .append($("<span>&nbsp;</span>")
						.append($("<a></a>").attr("href","#")
						.attr("id",(this.currentPage-1))
						.addClass("pagea")
					    .append($("<img/>")
						.attr("src","images/page/prev_h.gif")
						.attr("title","上一页")
						.attr("border","0"))));				
			}
			if (this.currentPage == this.pageCount || this.pageCount == 0) {
				$page.append($("<span>&nbsp;</span>")
						.append($("<img/>")
						.attr("src","images/page/next_d.gif")
						.attr("title","下一页")
						.attr("border","0")))
					 .append($("<span>&nbsp;</span>")
						.append($("<img/>")
						.attr("src","images/page/last_d.gif")
						.attr("title","尾  页")
						.attr("border","0")));				
			}
			else{
				
				$page.append($("<span>&nbsp;</span>")
						.append($("<a></a>")
						.attr("href","#")
						.attr("id",(this.currentPage+1))
						.addClass("pagea")
			            .append($("<img/>")
					    .attr("src","images/page/next_h.gif")
					    .attr("title","下一页")
					    .attr("border","0"))))
				 .append($("<span>&nbsp;</span>")
						.append($("<a></a>")
						.attr("href","#")
						.attr("id",this.pageCount)
						.addClass("pagea")
					    .append($("<img/>")
					    .attr("src","images/page/last_h.gif")
					    .attr("title","尾  页")
					    .attr("border","0"))));	
			}
			$page.append($("<span>&nbsp;</span>")
					.append($("<input/>")
					.attr("type","text")
					.attr("value",this.currentPage)
					.attr("name","targetPage")
					.attr("id","targetPage")
					.addClass("jumpcnt"))
					.append($("<input/>")
					.attr("type","button")
					.attr("name","pagego")
					.attr("id","pagego")
					.attr("value","跳转")
					.addClass("jumpBtn")));
			$page = $("<tr></tr>")
				.addClass("pageTr") 	
				.append($("<td></td>")
				.attr("align","right")
				.attr("id","pagetb")
				.attr("colspan","100")
				.addClass("pageTd") 	
				.append($page));
			return $page;
		};
		
		//画表格函数
		GRID.drawGrid = function()
		{
			//表格组装
			GRID.append(function(){
				//隐藏传值对象
				var $div = $("<div></div>").attr("display","none");
				for (var h=0; h<GRID.data.columnDesc.primkeyColumn.length;h++){
					var $input = '';
					var boo = $.browser.msie? $.browser.msie : false;
					if (boo){
						$input = $("<input type='hidden'"
	        				+ " name='paramMap." + GRID.data.columnDesc.primkeyColumn[h] + "' id='hide_" +GRID.data.columnDesc.primkeyColumn[h]+ "'>");
						$div.append($input);
					}
					else{
						$div.append($("<input/>")
						       .attr("type","hidden")
						       .attr("name","paramMap."+GRID.data.columnDesc.primkeyColumn[h])
						       .attr("id","hide_"+GRID.data.columnDesc.primkeyColumn[h]));
					}
				}
				return $div.html();
			}).append(
					//表格最外层table
					$("<table></table>")
					.attr("border","0")
					.attr("width","100%")
					.attr("cellspacing","1")
					.attr("cellpadding","0")
					.attr("id","gridTable")
					.addClass("gridTable")
					//表格头
					.append(GRID.drawGridHead())
					//表格体
					.append(GRID.drawGridBody())
					//翻页工具条
					.append(function(){
						if (GRID.data.isPagination == 'true'){
						  return GRID.drawPage();
						}
					}));
			//alert(GRID.html())
			return GRID.html();
		};
		
		//初始化函数
		GRID.init = function()
		{
			//如果GRID.data.columnData.data得长度小于0，默认调用ajax获取数据化表格实体
			//否者默认按照外围配置的数据，做为画表格实体的数据
			if (!GRID.data.columnData || GRID.data.columnData.length <= 0)
			{
				//若为ajax请求，url不能为空或空格
				if (!GRID.ajax.url)
				{
					alert("GRID.data.ajax.url is not null");
					return false;
				}
				var pgs = 10;
				if (GRID.data.paginationData.pageSize)
					pgs = GRID.data.paginationData.pageSize;
				var cpage = 0;
				if (GRID.data.paginationData.currentPage)
					cpage = GRID.data.paginationData.currentPage;				
				//目前只支持json格式，若需要xml格式可在进行开发
				GRID.ajax.data = GRID.data.ajax.data + "&currentPage=" + cpage + "&pageSize=" + pgs + "&" + GRID.data.globalParam;
				$.ajax(GRID.ajax);
			}
			else{
				//先清空在画表格
				GRID.html("");
				//在目标元素内画表格
				GRID.html(GRID.drawGrid());
				//设置表格体tr的样式和事件
				GRID.gridEvent();
				//表格画好之后，可以执行一些默认设置函数
				if (typeof GRID.option.extendInit == 'function'){
					GRID.option.extendInit();
				}
			}
		};
		//开始初始化
		GRID.init();		
};