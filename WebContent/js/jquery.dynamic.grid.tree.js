//调用举例
/**
	gridTreeTB = $('#gridTree').gridTreeTB({
	    globalParam:$("#actionForm").formSerialize(),
		//树是否全部展开true：展开,false:合并
		isOpen:'true',
	    //first,last
    	checkbox:{name:'全选',type:'first',width:'10%'},
    	shortcut:{
    		name:'操作',
	    	url:'decorateForwardAction.action',
	    	width:'30%',
	    	event:{
    			modify:{name:'修改',param:'code=${pmsIndex.sys_org_modify.code}'},
	    		del:{name:'删除',param:'code=${pmsIndex.sys_org_delete.code}'},
		    	detail:{name:'明细',param:'code=${pmsIndex.sys_org_detail.code}'}
	        }
	    },
    	//列表要显示的列（在json中对应的key）
		tableShowColumn: ['orgName','orgCode'],
		//列表头显示名称
		tableColumnName:   ['机构名称','机构代码'],
		//列表头宽度
		tableColumnWidth:   ['25%','15%'],
		//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
		//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["orgID"],
		//要增加链接的列，可以为多个
		tableLinkColumn:[{name:'orgName',url:'aa.html',param:''}],
		//要进行树型显示的列，支持一列
		treeShowColumn:'orgName',
		//树型菜单，起始根值
		treeNodeStartValue:'0',
		//属性菜单子列
		treeChildColumn:'orgID',
		//属性菜单父列
		treeParendColumn:'orgParentID',
    	ajax:{
			//ajax请求url
			url:'ajaxAction.action', 
			//ajax请求参数
			data:'code=${code}'
		}
    	//tableTreeData:eval(info)
	},	 
	{
		autoclose: true,
		columnAlias:function(col,val){
			if(col == 'orgCode')
			{
				if (val == '1')
					return "一";
				else if (val == '2')
					return "二";
				else if (val == '3')
					return "三";								
			}
		}
	});	
*/
//jquery 动态画表格
//data：json格式字段描述，表格内容，分页描述
//opt：     相关操作对外开放配置或扩展
//初始化数据
$.fn.gridDynamicTreeTB = function(data,opt,initData){
	
		//表格类对象
		var GRIDTREE = this;	
		//总记录数
		var recordCount = 0;
		//每页显示记录数
		var pageSize=8;	
		//当前页数
		var currentPage = 0;
		//总页数
		var paeCount = 0;		
		//记录数的节点个数
		var index = 0;		
		
		GRIDTREE.initData ={};
		//画表格所用相关数据
		GRIDTREE.data = {
				//系统全局参数，表单id
				formID:'actionForm',				
				//系统全局参数，主要是form内空间的值对参数
				globalParam:'',
				//树是否全部展开true：展开,false:合并
				isOpen:'true',
				//表格border属性
				border:'1',
				//表格border属性
				inputType:'text',
				//列表输结构显示字段是否有复选框 
				treeCheckbox: 'false',		
				//序列号参数配置
				//serialno: Array(),						
				//列表checkbox列参数配置
				checkbox: Array(),
				//列表快捷菜单列参数配置
				shortcut:	Array(),
				//父亲节点是否可操作（true：可操作 false：不可操作）
				isParentNodeOpt:'false',
		    	//列表要显示的列（在json中对应的key）
				tableShowColumn:Array(),
				//列表头显示名称
				tableColumnName:Array(),
				//列表头宽度
				tableColumnWidth:Array(),
				//可以作为主键的类，在页面传送的过程中为paramMap.key{1}(主键个数值)=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.key1=value&paramMap.key2=value
				primkeyColumn:Array(),
				//要增加链接的列，可以为多个
				tableLinkColumn:Array(),
				//要进行树型显示的列，支持一列
				treeShowColumn:'',
				//树型菜单，起始根值
				treeNodeStartValue:'0',
				//属性菜单子列
				treeChildColumn:'',
				//属性菜单父列
				treeParendColumn:'',
				//属性菜单级别
				treeLevel:'',
				//ajax参数请求配置信息
				ajax:Array(),
				//表格内容json格式数据，一旦配置此数据
				//系统不再进行ajax异步请求获取数据				
				tableTreeData:Array()
		};		
		
		//画表格相关操作定义
		GRIDTREE.option = {		
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
				//checkbox事件
				checkboxClick:false,
				//扩展初始化函数
				extendInit:false
		};	
		
		//ajax请求，系统默认配置参数，此参数可以通过外围配置覆盖
		GRIDTREE.ajax = {
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
					 GRIDTREE.attr("align","center");
					 GRIDTREE.html($img);
				},
				
				complete:function(request,textStatus){},
				
				success:function(jsonData,textStatus){
					//如果正常返回,设置GRIDTREE.data.tableTreeData
					//为ajax请求放回的json格式的数据
					if (textStatus == "success"){
						//程序设置树的根节点值
						if (jsonData.treeNodeStartValue > -1)
							GRIDTREE.data.treeNodeStartValue = jsonData.treeNodeStartValue;
						//ajax请求返回json格式数据
						GRIDTREE.data.tableTreeData = jsonData.data;
						//先清空在画表格
						GRIDTREE.html("");
						//在目标元素内画表格
						GRIDTREE.html(GRIDTREE.drawGridTree());
						//设置表格体tr的样式和事件
						GRIDTREE.gridEvent();	
					    //表格画好之后，可以执行一些默认设置函数
						if (typeof GRIDTREE.option.extendInit == 'function'){
							GRIDTREE.option.extendInit();
						}
					}
				},
				
				error:function(request,textStatus,error){}
		};	
		//树所用所有图标
		GRIDTREE.icon = {
		    L0:'images/tree/L0.gif',   //┏
		    L1:'images/tree/L1.gif',   //┣
		    L2:'images/tree/L2.gif',   //┗
		    L3:'images/tree/L3.gif',   //━
		    L4:'images/tree/L4.gif',   //┃
		    P0:'images/tree/P0.gif',  //＋┏
		    P1:'images/tree/P1.gif',  //＋┣
		    P2:'images/tree/P2.gif',  //＋┗
		    P3:'images/tree/P3.gif',  //＋━	
		    M0:'images/tree/M0.gif',  //－┏
		    M1:'images/tree/M1.gif',  //－┣
		    M2:'images/tree/M2.gif',  //－┗
		    M3:'images/tree/M3.gif',  //－━		    
		    empty:'images/tree/L5.gif',//空白图
		    file:'images/tree/file.gif',
		    folder:'images/tree/folder.gif',
		    folderopen:'images/tree/folderopen.gif',
		    root:'images/tree/root.gif'//缺省的根节点图标		    
		};		
		//默认设置一些常用小图标,主要是快捷方式
		//删除和默认和关键字冲突，改成简写
		GRIDTREE.scicon = {
			def:'',	
			create:'',
			del:'',
			modify:'',				         
			detail:'',
			grant:'images/common/001.gif',
			group:'images/common/383.gif',
			bind:'images/common/361.gif'
		};
		
		//将配置的数据替换，增加到data对象中
		GRIDTREE.data = $.extend(GRIDTREE.data,data);
		//将配置的数据替换，增加到option对象中
		GRIDTREE.option = $.extend(GRIDTREE.option,opt);
		//将配置的数据替换，增加到ajax对象中
		GRIDTREE.ajax = $.extend(GRIDTREE.ajax,GRIDTREE.data.ajax);
		//计算表格的每列的宽度
		//若设置宽度就按照设置的宽度显示，否者安列平均分配
		GRIDTREE.gridWidth = function(i)
		{
			var wth = GRIDTREE.data.tableColumnWidth[i];
			var len = GRIDTREE.data.tableColumnWidth.length;
			if (len == 0)
				len = 1;
			//如果没有设置宽度，用100除以字段数量的平均值为column宽度
			if(!wth)
				wth = parseInt(100/len) + "%";
			return wth;
		};
		
		//画表格序列号
		GRIDTREE.drawSeriano = function(row,rcnt,$linetr,type)
		{
			if (GRIDTREE.data.serialno)
			{			
				var shownum = "";
				if (GRIDTREE.data.serialno.order == 'd')
					shownum = (row + 1);
				else
					shownum = rcnt - row;
				if (!GRIDTREE.data.serialno.width)
					GRIDTREE.data.serialno.width = "10%";
				var $ipt = $("<"+type+"></"+type+">")
							.addClass((type == 'th') ?"gridHeadTh":"gridHeadTd")
							.attr("align","center")
							.attr("width",GRIDTREE.data.serialno.width)
							.attr("name",type == 'th'?'serialnoTh':'serialnoTd')
							.attr("id",type == 'th'?'serialnoTh':'serialnoTd')
							.append((type == 'th')?GRIDTREE.data.serialno.name:shownum);
				if (GRIDTREE.data.serialno.type == 'first')
				{
					$linetr = $linetr.prepend($ipt);
				}
				else if (GRIDTREE.data.serialno.type == 'last')
				{				
					$linetr = $linetr.append($ipt);
				}
			}
			return $linetr;			
		};		
		
		//画表格的头
		GRIDTREE.drawGridTreeHead = function()
		{
			var len = GRIDTREE.data.tableColumnName.length;
			if (len > 0){
				//画thead
				var $hthead = $("<thead></thead>").addClass("gridTreeHeadThead");
				//画tr
				var $htr = $("<tr></tr>").addClass("gridTreeHeadTr");
				//循环画head每列的内容
				$.each(GRIDTREE.data.tableColumnName,function(i){
					//判断每列是否显示
					$htr.append($("<th>"+this+"</th>")
							.attr("width",GRIDTREE.gridWidth(i))
							.attr("align","center")
							.addClass("gridTreeHeadTh"));
				});
				//画checkbox
				//$htr = GRIDTREE.drawSeriano(0,0,$htr,"th");			
				//画checkbox
				$htr = GRIDTREE.drawCheckbox(0,$htr,"th");
				//画快捷菜单
				$htr = GRIDTREE.drawShortcut(0,$htr,"th");	
				return $hthead.append($htr);
			}
			else{
				return "";
			}
		};
		
		//计算主键值串
		//此主键参数会自动映射（struts2特性）存放在后台名叫paramMap的java hashmap中
		GRIDTREE.getPrimkey = function(row)
		{
			var rkey = '';
			$.each(GRIDTREE.data.primkeyColumn,function(i){
				if (GRIDTREE.data.tableTreeData[row]){
					var key = eval("GRIDTREE.data.tableTreeData["+row+"]." + this);
					if (i==0){
						rkey = this + "=" + key;
					}
					else{
						rkey += "##" + this + "=" + key;
					}
				}
			});
		//	alert(rkey)
			return rkey;
		};
		
		//json格式数据递归处理
		//处理成树状结构的数据,并画树表格
		GRIDTREE.recursiveDrawTreeTable = function($body,pid)
		{
			var len = GRIDTREE.data.tableTreeData.length;
			$.each(GRIDTREE.data.tableTreeData,function(i){
				var idxv = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeChildColumn);
				var tempidvx = idxv;
				var pidxv = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeParendColumn);
				if (pid){
					idxv = pid + "_" + idxv; 
				}
				//当前级别
				var currLevel = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeLevel);
				//是否有子节点
				var isChild = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeIsChild);
				var $btr = $("<tr></tr>").attr("id","TR_"+idxv).addClass("jq_gridTreeBodyTr");
				var tempImg = '';
				if (pid){
					for (var j=1; j<currLevel; j++){
						tempImg += "<img align='absmiddle' src='"+GRIDTREE.icon.L4+"' border='0'/>";
					}
				}
				$.each(GRIDTREE.data.tableShowColumn,function(j){
					var cval = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.tableShowColumn[j]);
					if (GRIDTREE.data.treeShowColumn == GRIDTREE.data.tableShowColumn[j]){
						var $btd = $("<td></td>").attr("class","gridTreeBodyTd").attr("align","left");
						$btd.append(tempImg);		
						
						
						var tmpimg1 = '', tmpimg2 = '';
						if (i == 0 && !pid){
							if (isChild == 1){
								tmpimg1 = GRIDTREE.icon.P1;
								tmpimg2 = GRIDTREE.icon.folder;
							}
							else{
								if (len > 1){
									tmpimg1 = GRIDTREE.icon.L0;
								}
								else{
									tmpimg1 = GRIDTREE.icon.L3;
								}
								
								tmpimg2 = GRIDTREE.icon.file;
							}
						}
						else{
							if (parseInt(i+1) == GRIDTREE.data.tableTreeData.length){
								if (isChild == 1){
									tmpimg1 = GRIDTREE.icon.P2;
									tmpimg2 = GRIDTREE.icon.folder;
								}
								else{
									tmpimg1 = GRIDTREE.icon.L2;
									tmpimg2 = GRIDTREE.icon.file;
								}
							}
							else{
								if (isChild == 1){
									tmpimg1 = GRIDTREE.icon.P1;
									tmpimg2 = GRIDTREE.icon.folder;
								}
								else{
									tmpimg1 = GRIDTREE.icon.L1;
									tmpimg2 = GRIDTREE.icon.file;
								}
							}
						}
						//更具是否有子节点设置不通的样式属性
						var tnei = 'jq_treeCNodeEventImg';
						if (isChild == 1){
							tnei = 'jq_treePNodeEventImg';
						}
						else{
							tnei = 'jq_treeCNodeEventImg';
						}
						var $img1 = $("<img/>").addClass(tnei).attr("align","absmiddle")
			         		.attr("id","IMG_" +idxv)
			         		.attr("border","0").attr("src",tmpimg1);
						var $img2 = $("<img/>").attr("align","absmiddle").attr("id","PIMG_"+idxv)
                        	.attr("border","0").addClass("treeNodeImg").attr("src",tmpimg2);
						var $span = $("<span>&nbsp;&nbsp;</span>");
						$btr.append(
							$btd.append($img1).append($img2).append($span)
				             .append(function(){
				            	if (GRIDTREE.data.treeCheckbox && GRIDTREE.data.treeCheckbox == 'true'){
									var $input = '';
									var boo = $.browser.msie? $.browser.msie : false;
									if (boo){
										
										$input = $("<input type='"+GRIDTREE.data.inputType+"' class='jq_treeCheckbox' " + " name='paramMap.treeCheckboxVal' id='CHECKBOX_" +idxv+"' value='" + GRIDTREE.getPrimkey(i) + "'>");
									}
									else{
										$input = $("<input/>")
										       .attr("type",GRIDTREE.data.inputType)
										       .attr("class","jq_treeCheckbox")
										       .attr("name","paramMap.treeCheckboxVal")
										       .attr("id","CHECKBOX_" +idxv)
										       .attr("value",GRIDTREE.getPrimkey(i))
										       .css("margin","0px");
									}						            		
				            		return $input;
				            	}
				             }).append(function(){
				            	 var alias = '';
								 if (typeof GRIDTREE.option.columnAlias == 'function'){
									 alias = GRIDTREE.option.columnAlias(GRIDTREE.data.tableShowColumn[j],cval,tempidvx,currLevel);
								 }
								 else{
									 alias = cval;
								 }			
								 if (!alias){
									 alias = cval;
								 }
								 if (GRIDTREE.data.tableLinkColumn){
									 for (var t=0; t<GRIDTREE.data.tableLinkColumn.length; t++){
						            	 if  (GRIDTREE.data.tableShowColumn[j] == GRIDTREE.data.tableLinkColumn[t].name){
						            		 return $("<a></a>").attr("href","javascript:void(0);")
						                 			 .addClass("jq_columnA")
						                 			 .attr("id","A_"+idxv)
						                 			 .append("<span>"+alias+"</span>").append(
						                 				$("<input/>").attr("type","hidden").attr("value",GRIDTREE.getPrimkey(i))
						                 			 );
						            	 }
									 }
								 }
				            	 return "<span>"+alias+"</span>";
				             })
				        );
					}
					else
					{
						$btr.append(
								$("<td></td>").append(function(){
									var alias = '';
									if (typeof GRIDTREE.option.columnAlias == 'function'){
										alias = GRIDTREE.option.columnAlias(GRIDTREE.data.tableShowColumn[j],cval,tempidvx,currLevel);
									}
									else{
										alias = cval;
									}
									if (!alias){
										alias = cval;
									}	
									 if (GRIDTREE.data.tableLinkColumn){
										 for (var t=0; t<GRIDTREE.data.tableLinkColumn.length; t++){
							            	 if  (GRIDTREE.data.tableShowColumn[j] == GRIDTREE.data.tableLinkColumn[t].name){
							            		 return $("<a></a>").attr("href","javascript:void(0);")
							                 			 .addClass("jq_columnA")
							                 			 .attr("id","A_"+idxv)
							                 			 .append("<span>"+alias+"</span>").append(
							                 				$("<input/>").attr("type","hidden").attr("value",GRIDTREE.getPrimkey(i))
							                 			 );
							            	 }
										 }
									 }										
									return "<span>"+alias+"</span>";
								}).attr("class","gridTreeBodyTd").attr("align","center")
						);							
					}
				});				
				//alert($body.html());
				//画checkbox
				$btr = GRIDTREE.drawCheckbox(i,$btr,"td",isChild == 1? "true":"false");
				//画快捷菜单
				$btr = GRIDTREE.drawShortcut(i,$btr,"td",isChild == 1? "true":"false");	
				$body.append($btr);
			});
		};
		
		//判断当前节点是否有同级别其他接点
		GRIDTREE.treeLevel = function(cid,pid,index){
			var boo = false;
			for(var i=0; i<GRIDTREE.data.tableTreeData.length; i++){
				var idxv = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeChildColumn);
				var pidxv = eval("GRIDTREE.data.tableTreeData["+i+"]."+GRIDTREE.data.treeParendColumn);
				if (pid == pidxv && cid != idxv){
					boo = true;
					break;
				}
			}
			return boo;
		};
		
		//设置节点状态
		GRIDTREE.treeNodeStatus = function(){
			
			//树状结构关系描述,只有配置此结构才画树表格列表，否者画正常列表
			//树状结构展示字段
			var treeShowColumn = GRIDTREE.data.treeShowColumn;
			if (!treeShowColumn){
				alert("TREE.data.treeShowColumn is not null!");
			}				
			//树状结构展示子索引字段名
			var treeChildColumn = GRIDTREE.data.treeChildColumn;
			if (!treeChildColumn){
				alert("GRIDTREE.data.treeChildColumn is not null!");
			}				
			//树状结构展示父索引字段名
			var treeParendColumn = GRIDTREE.data.treeParendColumn;
			if (!treeParendColumn){
				alert("GRIDTREE.data.treeParendColumn is not null!");
			}				
			//树状结构根节点起始值
			var treeNodeStartValue = GRIDTREE.data.treeNodeStartValue;
//			if (!treeNodeStartValue){
//				alert("GRIDTREE.data.treeIndexStartValue is not null!");
//			}					
			var rootLast = -1;
			for(var i=0;i<GRIDTREE.data.tableTreeData.length;i++){
				var cindexVal = eval("GRIDTREE.data.tableTreeData["+i+"]."+treeChildColumn);
				var pindexVal = eval("GRIDTREE.data.tableTreeData["+i+"]."+treeParendColumn);
				//如果根据字段获取的值不正确，直接返回
				if (!cindexVal && !pindexVal){
					return false;
				}
				if (treeNodeStartValue == pindexVal){
					rootLast = i;
				}
				var temp = -1;
				for(var j=0;j<GRIDTREE.data.tableTreeData.length;j++){
					var cval = eval("GRIDTREE.data.tableTreeData["+j+"]."+treeChildColumn);
					var pval = eval("GRIDTREE.data.tableTreeData["+j+"]."+treeParendColumn);	
					if (cindexVal == pval){
						temp = j;
					}
				}
				if (temp > -1){
					GRIDTREE.data.tableTreeData[i] = $.extend(GRIDTREE.data.tableTreeData[i],{isChildNode:'true'});
					GRIDTREE.data.tableTreeData[temp] = $.extend(GRIDTREE.data.tableTreeData[temp],{isLast:'true'});
				}
			}
			if (rootLast > -1){
				GRIDTREE.data.tableTreeData[rootLast] = $.extend(GRIDTREE.data.tableTreeData[rootLast],{isLast:'true'});
			}
			return true;
		};	
		
		
		//画表格的body
		GRIDTREE.drawGridTreeBody = function()
		{
			var $body = $("<tbody></tbody>").attr("id","gridTreeTbody");
			$body.html("");
			var $div = $("<div></div>");
			GRIDTREE.recursiveDrawTreeTable($div);
			$body.append($div.html());
			$div.remove();
			return $body;
		};
		//画表格单选或复选按钮
		//linetr：插入行jquery对象，type：th或td
		//rowCnt ：行数
		//isChildNode:此列对应的树的节点类型：true：父节点，false：子节点
		GRIDTREE.drawCheckbox = function(rowCnt,$linetr,type,isChildNode)
		{
			//只有设置GRIDTREE.data.checkbox的时候才在表格第一列或最后一列画checkbox按钮
			//根据具体的参数值来确定画在第一列还是最后一列
			//first:首列，last：最后一列
			if (GRIDTREE.data.checkbox)
			{			
				if (!GRIDTREE.data.checkbox.width)
					GRIDTREE.data.checkbox.width = "10%";
				var $ipt = '';
				if (type == 'th'){
					   $ipt = $("<th></th>")
						.addClass("gridTreeHeadTh")
						.attr("align","center")
						.attr("width",GRIDTREE.data.checkbox.width)
						.append($("<input/>").attr("type","checkbox")
								.attr("name","checkboxAll")
								.attr("id","checkboxAll")
								.css("margin","0px"))
						.append(GRIDTREE.data.checkbox.name);					
				}
				else{
				   $ipt = $("<td></td>")
							.addClass("gridTreeBodyTd")
							.attr("align","center")
							.attr("width",GRIDTREE.data.checkbox.width)
							.append(function(){
								var dis ='';
								//false：父节点不可操作
								if (GRIDTREE.data.isParentNodeOpt == 'false'){
									if (isChildNode == 'true'){
										dis = 'disabled';
									}
									var $input = '';
									var boo = $.browser.msie? $.browser.msie : false;
									if (boo){
										$input = $("<input type='"+GRIDTREE.data.inputType+"' name='paramMap.checkboxVal'" + dis +" id='checkboxVal' value='" + GRIDTREE.getPrimkey(rowCnt) + "'>");
									}
									else{
										$input = $("<input />")
											   .attr("type",GRIDTREE.data.inputType)
										       .attr("name","paramMap.checkboxVal")
										       .attr("id","checkboxVal")
										       .attr("disabled",dis)
										       .attr("value",GRIDTREE.getPrimkey(rowCnt))
										       .css("margin","0px");
									}
									return $input;								
								}
								else{
									var disabled =  GRIDTREE.data.checkbox.disabled;
									if (!disabled){
										disabled = 'true';
									}
									if (isChildNode == 'true'){
										if (disabled == 'true'){
											dis = 'disabled';
										}
									}
									var $input = '';
									var boo = $.browser.msie? $.browser.msie : false;
									if (boo){
										
										$input = $("<input type='"+GRIDTREE.data.inputType+"' name='paramMap.checkboxVal'" + dis +" id='checkboxVal' value='" + GRIDTREE.getPrimkey(rowCnt) + "'>");
										
										
									}
									else{
										$input = $("<input/>")
										       .attr("type","checkbox")
										       .attr("name",GRIDTREE.data.inputType)
										       .attr("disabled",dis)
										       .attr("id","checkboxVal")
										       .attr("value",GRIDTREE.getPrimkey(rowCnt))
										       .css("margin","0px");
									}									
									return $input;										
								}
							});
				}
				if (GRIDTREE.data.checkbox.position == 'first')
				{
					$linetr = $linetr.prepend($ipt);
				}
				else if (GRIDTREE.data.checkbox.position == 'last')
				{				
					$linetr = $linetr.append($ipt);
				}
			}
			return $linetr;
		};
		
		//画表格快捷方式菜单
		//rowCnt ：行数
		//type:表格头的th还是表格体的td
		//isChildNode:此列对应的树的节点类型：true：父节点，false：子节点
		GRIDTREE.drawShortcut = function(rowCnt,$linetr,type,isChildNode)
		{
			if (!GRIDTREE.data.shortcut.width)
				GRIDTREE.data.shortcut.width = "15%";
			var ivindex = 0;
			//权限判断，如果没有任何权限不画快捷菜单
			if(GRIDTREE.data.shortcut.event){
				var boo = false;
				for (var i=0;i<GRIDTREE.data.shortcut.event.length;i++){
					var isv = GRIDTREE.data.shortcut.event[i].isvalid;
					if (isv == 'true'){
						boo = true;
					}
				}
				if (!boo)
					return $linetr;
			}
			//是否生成快捷菜单
			if (GRIDTREE.data.shortcut && GRIDTREE.data.shortcut.event)
			{
				if (type == 'th')
				{
					$linetr.append( $("<th>"+GRIDTREE.data.shortcut.name+"</th>")
							.attr("align","center")
							.attr("width",GRIDTREE.data.shortcut.width)
							.addClass("gridTreeHeadTh"));
				}
				else
				{
					var $sctd = $("<td></td>")							
							.attr("class","gridTreeBodyTd")
							.attr("width",GRIDTREE.data.shortcut.width)
							.attr("align","center");
					//画图标和描述连接
					$.each(GRIDTREE.data.shortcut.event,function(i){
						var imgsrc = GRIDTREE.scicon.def; 
						if (GRIDTREE.data.shortcut.event[i].icon)
						{
							imgsrc = GRIDTREE.data.shortcut.event[i].icon;
						}
						else{
							if (GRIDTREE.data.shortcut.event[i].operate){
								var im = eval("GRIDTREE.scicon."+GRIDTREE.data.shortcut.event[i].operate);
								if (im){
									imgsrc = im;
								}
							}
						}				
						//配置快捷菜单式串的参数
						var param = GRIDTREE.data.shortcut.event[i].param ? GRIDTREE.data.shortcut.event[i].param + "##":"";
						var isv = GRIDTREE.data.shortcut.event[i].isvalid;
						if (isv == 'true'){
							var dshortcut = 'false';
							//是否有切入处理函数
							if(typeof GRIDTREE.option.extendDrawShortcut == 'function'){
								dshortcut = GRIDTREE.option.extendDrawShortcut(GRID.data.columnData[rowCnt],GRIDTREE.data.shortcut.event[i].operate);
							}
							//若切入函数返回值为空
							//否则按照默认的方式正常画快捷菜单
							if (dshortcut == 'true'){
								$sctd.append(
									$("<span>&nbsp;&nbsp;</span>").append(
										$("<span>"+this.name+"</span>")
										.prepend($("<img></img>").attr("src",imgsrc)
									    		 .attr("border","0").attr("align","absmiddle")
									    		 .attr("width","14").attr("height","14")
										)
								));
							}
							else{
								var $contend = $("<span>&nbsp;</span>");
								var dis = '';
								//false：父节点不可操作
								if (GRIDTREE.data.isParentNodeOpt == 'false'){
									if (isChildNode == 'true'){
										$contend = $("<span>"+this.name+"</span>");
									}
									else{
										$contend = $("<a><span>"+this.name+"</span></a>").append(
							    				 $("<input/>").attr("type","hidden").attr("value",param + GRIDTREE.getPrimkey(rowCnt))
							    		    ).attr("href","javascript:void(0);")
							    		 	 .attr("id",GRIDTREE.data.shortcut.event[i].operate)
								 			 .addClass("ashortcut");										
									}
								}
								else{
									if (isChildNode == 'true'){
										var disabled = GRIDTREE.data.shortcut.event[i].disabled;
										if(!disabled){
											disabled = 'false';
										}
										if (disabled == 'true'){
											$contend = $("<span class='delete_dictionary_none'>"+this.name+"</span>");
										}
										else{
											$contend = $("<a><span>"+this.name+"</span></a>").append(
								    				 $("<input/>").attr("type","hidden").attr("value",param + GRIDTREE.getPrimkey(rowCnt))
								    		    ).attr("href","javascript:void(0);")
								    		 	 .attr("id",GRIDTREE.data.shortcut.event[i].operate)
									 			 .addClass("ashortcut");										
										}										
									}
									else
									{
										if(GRIDTREE.data.shortcut.event[i].operate == 'del'){
											$contend = $("<a class='delete_dictionary'><span>"+this.name+"</span></a>").append(
								    				 $("<input/>").attr("type","hidden").attr("value",param + GRIDTREE.getPrimkey(rowCnt))
								    		    ).attr("href","javascript:void(0);")
								    		 	 .attr("id",GRIDTREE.data.shortcut.event[i].operate)
									 			 .addClass("ashortcut");			
										}else{
											
											$contend = $("<a><span>"+this.name+"</span></a>").append(
								    				 $("<input/>").attr("type","hidden").attr("value",param + GRIDTREE.getPrimkey(rowCnt))
								    		    ).attr("href","javascript:void(0);")
								    		 	 .attr("id",GRIDTREE.data.shortcut.event[i].operate)
									 			 .addClass("ashortcut");			
										}
										
																
									}								
								}
								$sctd.append($("<span>&nbsp;&nbsp;</span>")).append($contend);
							}
						}
					});
				}
				$linetr.append($sctd);
			}
			return $linetr;
		};
		
		//查找关闭且有子节点的节点
		GRIDTREE.closePNode = function(iid)
		{
			return $.makeArray($(".gridTreeBodyTd .jq_treePNodeEventImg").filter(function(){
				var imgid = $(this).attr("id");
				var imgsrc = $(this).attr("src");
				if (imgid != iid && imgid.indexOf(iid) > -1){
					if (imgsrc.indexOf(GRIDTREE.icon.P1) > -1 || imgsrc.indexOf(GRIDTREE.icon.P2) > -1){
						return true;
					}
				}
				else{
					return false;
				}
			}));			
		};
		
		//切换树几点图片，并返回是展开还是合上树
		//imgid:点击或目标变换图片的id
		//array:有子节点，且关闭的节点
		GRIDTREE.treeNodeEvent = function($img,array)
		{
			var display = '';
			var newimgid = $img.attr("id").replace("IMG","PIMG");
			if ($img.attr("src").indexOf(GRIDTREE.icon.M1) > -1){
				$("#"+newimgid).attr("src",GRIDTREE.icon.folder);
				$img.attr("src",GRIDTREE.icon.P1);
				display = 'none';
			}
			else if ($img.attr("src").indexOf(GRIDTREE.icon.P1) > -1){
				$img.attr("src",GRIDTREE.icon.M1);
				$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
				display = 'block';
			}
			else if ($img.attr("src").indexOf(GRIDTREE.icon.M2) > -1){
				$img.attr("src",GRIDTREE.icon.P2);
				$("#"+newimgid).attr("src",GRIDTREE.icon.folder);
				display = 'none';
			}
			else if ($img.attr("src").indexOf(GRIDTREE.icon.P2) > -1){
				$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
				$img.attr("src",GRIDTREE.icon.M2);
				display = 'block';
			}	
			else if ($img.attr("src").indexOf(GRIDTREE.icon.M0) > -1){
				$("#"+newimgid).attr("src",GRIDTREE.icon.folder);
				$img.attr("src",GRIDTREE.icon.P0);
				display = 'none';
			}	
			else if ($img.attr("src").indexOf(GRIDTREE.icon.P0) > -1){
				$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
				$img.attr("src",GRIDTREE.icon.M0);
				display = 'block';
			}			
			$("#gridTreeTable tbody tr").filter(function(){
				var divid = $(this).attr("id");
				var tempid = $img.attr("id").replace('IMG_','TR_');
				if (tempid != divid && divid.indexOf(tempid) > -1){
					return true;
				}
				else{
					return false;
				}
			}).each(function(){
				var divcid = $(this).attr("id");
				if (display == 'block'){
					var isexit = false;
					for (var i=0; i<array.length; i++){
						var ctempid = array[i].id.replace('IMG_','TR_');
						if (divcid != ctempid && divcid.indexOf(ctempid) > -1){
							isexit = true;
							break;
						}
					}
					if (!isexit){
						$(this).find("td").show();
						$(this).show();
					}
				}
				else{
					$(this).hide();
				}
			});					
		};
		//设置表格体行的样式，并绑定相关事件
		GRIDTREE.gridEvent = function()
		{
			//设置头checkbox绑定事件和样式(全选函数)
			$("#" + GRIDTREE.attr("id") + " thead tr input[type='checkbox']").bind("click",function(){
				if (this.checked){
					$("#" + GRIDTREE.attr("id") + " tbody input[type='checkbox']").each(function (){
						if (!this.disabled){
							var cval = $(this).val();
							var arrParam = cval.split("##");
							for(var a=0; a<arrParam.length;a++){
								if (arrParam[a]){
									var arrValMap = arrParam[a].split("=");
									if (arrValMap[0] && arrValMap[1]){
										var cv = $("#hide_"+arrValMap[0]).val();
										if (cv){
											$("#hide_"+arrValMap[0]).val(cv+","+arrValMap[1]);
										}
										else{
											$("#hide_"+arrValMap[0]).val(arrValMap[1]);
										}
									}
								}
							}							
							this.checked = true;
						}
					});
				}
				else{
					$("#" + GRIDTREE.attr("id") + " tbody input[type='checkbox']").each(function (){
						if (!this.disabled){
							this.checked = false;
						}
					});					
				}
			});
			
			//单个复选按钮绑定事件
			$("#" + GRIDTREE.attr("id") + " tbody input[type='checkbox']").each(function (){
				$(this).bind("click",function(){
					if (this.checked){
						//清空所有隐藏元素值
						var cval = $(this).val();
						var arrParam = cval.split("##");
						for(var a=0; a<arrParam.length;a++){
							if (arrParam[a]){
								var arrValMap = arrParam[a].split("=");
								if (arrValMap[0] && arrValMap[1]){
									$("#hide_"+arrValMap[0]).val("");
								}
							}
						}		
						//获取所有选中元素的值，并重新付给页面隐藏元素
						$("#" + GRIDTREE.attr("id") + " tbody input[type='checkbox']").each(function(){
							if (this.checked){
								var cval = $(this).val();
								var arrParam = cval.split("##");
								for(var a=0; a<arrParam.length;a++){
									if (arrParam[a]){
										var arrValMap = arrParam[a].split("=");
										if (arrValMap[0] && arrValMap[1]){
											var cv = $("#hide_"+arrValMap[0]).val();
											if (cv){
												$("#hide_"+arrValMap[0]).val(cv+","+arrValMap[1]);
											}
											else{
												$("#hide_"+arrValMap[0]).val(arrValMap[1]);
											}
										}
									}
								}									
							}
						});
					}					
				});
			});			
			
		//	$("#checkboxVal").bind("click",function(){
		//		var temp = $("#checkboxVal");
		//		var ids= $(temp).attr("name");
		//		alert(ids);
				
		//	})
		//	$("#checkboxVal")click(function(){
		//		var temp = $("#checkboxVal").parents().filter("tr");
		//		var ids= $(temp).attr("id");
		//		alert(ids);
		//	})
			//设置列表内容自动换行
			$("#"+GRIDTREE.attr("id")+" tbody td").css({"word-wrap":"break-word","word-break":"break-all"});
			
			//设置奇数列样式和绑定事件
			$("#" + GRIDTREE.attr("id") + " tbody tr:odd").removeClass()
			.addClass("gridTreeBodyTrOutOdd").bind("mouseover",function(){
					$(this).removeClass().addClass("gridTreeBodyTrOver");
				}).bind("mouseout",function(){
					$(this).removeClass().addClass("gridTreeBodyTrOutOdd");
				}).bind("click",function(){
					if(typeof GRIDTREE.option.trClick == 'function')
					{
						//GRIDTREE.option.trClick(this,);
					}
			});
			
			//设置偶数列样式和绑定事件
			$("#" + GRIDTREE.attr("id") + " tbody tr:even").removeClass()
			.addClass("gridTreeBodyTrOutEven").bind("mouseover",function(){
					$(this).removeClass().addClass("gridTreeBodyTrOver");
				}).bind("mouseout",function(){
					$(this).removeClass().addClass("gridTreeBodyTrOutEven");
				}).bind("click",function(){
					if(typeof GRIDTREE.option.trClick == 'function')
					{
						//TREE.option.trClick(this,);
					}
			});
			
			//设置快捷菜单事件
			$("#" + GRIDTREE.attr("id") + " tbody a").filter(".ashortcut").each(function(){
				$(this).bind("click",function(){
					var param = $("input",$(this)).attr("value");
					//对外开放的函数，若写此函数，就调用此函数
					if (typeof GRIDTREE.option.shortcutClick == 'function'){
						GRIDTREE.option.shortcutClick($(this),param);
					}
					else{
						//json格式配置参数
						var jsonParam = '';
						var arrParam = param.split("##");
						for(var a=0; a<arrParam.length;a++){
							//获取json格式配置参数
							if (a == 0){
								jsonParam = arrParam[a];
							}
							else{
								if (arrParam[a]){
									var arrValMap = arrParam[a].split("=");
									if (arrValMap[0] && arrValMap[1]){
										$("#hide_"+arrValMap[0]).val(arrValMap[1]);
									}
								}
							}
						}
						var faction = $("#" +GRIDTREE.data.formID).attr("action");
						$("#" +GRIDTREE.data.formID).attr("action",faction +"?"+jsonParam);
						$("#" +GRIDTREE.data.formID).submit();
					}
				});
			});
			
			//表格列连接单击事件
			$.each(GRIDTREE.data.tableLinkColumn,function(i){
				var col = this.name;
				var param = this.param ;
			
				if(col){
					$("#" + GRIDTREE.attr("id") + " tbody a").filter(".jq_columnA").each(function(){
						$(this).bind("click",function(){
							if (!param)
								param = '';	
							param = $("input",$(this)).attr("value");
							//对外开放的函数，若写此函数，就调用此函数
							if (typeof GRIDTREE.option.columnClick == 'function'){
								GRIDTREE.option.columnClick($(this),param);
							}
							else{
								var arrParam = param.split("##");
								for(var a=0; a<arrParam.length;a++){
									if (arrParam[a]){
										var arrValMap = arrParam[a].split("=");
										if (arrValMap[0] && arrValMap[1]){
											$("#hide_"+arrValMap[0]).val(arrValMap[1]);
										}
									}
								}
								var fsrc = $("#" +GRIDTREE.data.formID).attr("action");
								$("#" +GRIDTREE.data.formID).attr("action",fsrc + "?" + param);
								$("#" +GRIDTREE.data.formID).submit();
							}
						});
					});						
				}
			});
			//设置树展开收起事件事件
			$("#" + GRIDTREE.attr("id") + " tbody tr .jq_treePNodeEventImg").each(function(i){
				var id = $(this).attr("id");	
				var $img = $(this);
				var newimgid = id.replace("IMG","PIMG");
				$(this).unbind("click").bind("click",function(){
					var imgName = $(this).attr("src");
					var isajax = false;
					if (imgName.indexOf(GRIDTREE.icon.P3) >= 0){
						$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
						$(this).attr("src",GRIDTREE.icon.M0);
						$(this).attr("name","P3");
						isajax = true;
					}
					else if (imgName.indexOf(GRIDTREE.icon.P1) >= 0){
						$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
						$(this).attr("src",GRIDTREE.icon.M1);
						$(this).attr("name","P1");
						isajax = true;
					}
					else if (imgName.indexOf(GRIDTREE.icon.P2) >= 0){
						$("#"+newimgid).attr("src",GRIDTREE.icon.folderopen);
						$(this).attr("src",GRIDTREE.icon.M1);
						$(this).attr("name","P2");
						isajax = true;
					}
					else if (imgName.indexOf(GRIDTREE.icon.M0) >= 0){
						$("#"+newimgid).attr("src",GRIDTREE.icon.folder);
						$(this).attr("src",GRIDTREE.icon.P3);
						isajax = false;
					}
					else if (imgName.indexOf(GRIDTREE.icon.M1) >= 0){
						$("#"+newimgid).attr("src",GRIDTREE.icon.folder);
						var name = $(this).attr("name");
						if (name == 'P2'){
							$(this).attr("src",GRIDTREE.icon.P2);
						}
						else{
							$(this).attr("src",GRIDTREE.icon.P1);
						}
						isajax = false;
					}
					if (isajax){
						var arrayid = id.split("_");
						var pidTemp = "";
						for (var s=0; s<arrayid.length; s++){
							if (s != 0){
								if (s <= arrayid.length -1){
									if (s == arrayid.length -1)
										pidTemp += arrayid[s];
									else{
										pidTemp += arrayid[s] + "_";
									}
								}								
							}
						}
						var opid = arrayid[arrayid.length-1];
						var data = GRIDTREE.data.ajax.data + "&paramMap.parentID=" + opid;
						var pjson = {
							data: data,	
							beforeSend:function(request){},
							success:function(jsonData,textStatus){
								//程序设置树的根节点值
								if (jsonData.treeNodeStartValue > -1)
									GRIDTREE.data.treeNodeStartValue = jsonData.treeNodeStartValue;
								//ajax请求返回json格式数据
								GRIDTREE.data.tableTreeData = jsonData.data;
								var $div = $("<div></div>");
								GRIDTREE.recursiveDrawTreeTable($div,pidTemp);
								var tid = id.replace("IMG","TR");
								$("#"+tid).after($div.html());
								$div.remove();
								//绑定事件
								GRIDTREE.gridEvent();	
							}
						};
						$.extend(GRIDTREE.ajax,pjson);
						$.ajax(GRIDTREE.ajax);
					}
					else{
						var display = '';
						var tempid = $img.attr("id").replace('IMG_','TR_');
						$("#gridTreeTable tbody tr").filter(function(){
							var divid = $(this).attr("id");
							if (tempid != divid && divid.indexOf(tempid) > -1){
								return true;
							}
							else{
								return false;
							}
						}).each(function(){
							var divcid = $(this).attr("id");
							if (display == 'block'){
								var isexit = false;
								for (var i=0; i<array.length; i++){
									var ctempid = array[i].id.replace('IMG_','TR_');
									if (divcid != ctempid && divcid.indexOf(ctempid) > -1){
										isexit = true;
										break;
									}
								}
								if (!isexit){
									$(this).find("td").show();
									$(this).show();
								}
							}
							else{
								$(this).hide();
							}
						});							
					}
				});
			});		
			//设置树展开收起事件事件
			$("#" + GRIDTREE.attr("id") + " tbody tr .jq_treeCheckbox").each(function(i){
//				var id = $(this).attr("id");
//				var val = $(this).attr("value");
				$(this).bind("click",function(){
					if (typeof GRIDTREE.option.checkboxClick == 'function'){
						GRIDTREE.option.checkboxClick($(this));
					}
				});
			});				
			
		};
		
		//画表格函数
		GRIDTREE.drawGridTree = function()
		{
			//表格组装
			GRIDTREE.append(function(){
				//隐藏传值对象
				var $div = $("<div></div>").attr("display","none");
				for (var h=0; h<GRIDTREE.data.primkeyColumn.length;h++){
					var $input = '';
					var boo = $.browser.msie? $.browser.msie : false;
					if (boo){
						
						$input = $("<input type='hidden'" + " name='paramMap." + GRIDTREE.data.primkeyColumn[h] + "' id='hide_" +GRIDTREE.data.primkeyColumn[h]+ "'>");
						
						$div.append($input);
					}
					else{
						$div.append($("<input/>")
						       .attr("type","hidden")
						       .attr("name","paramMap."+GRIDTREE.data.primkeyColumn[h])
						       .attr("id","hide_"+GRIDTREE.data.primkeyColumn[h]));
					}
				}
				return $div.html();
			}).append(
					//表格最外层table
					$("<table></table>")
					.attr("border","0")
					.attr("width","100%")
					.attr("cellspacing",GRIDTREE.data.border)
					.attr("cellpadding","0")
					.attr("id","gridTreeTable")
					.addClass("gridTreeTable")
					//表格头
					.append(GRIDTREE.drawGridTreeHead())
					//表格体
					.append(GRIDTREE.drawGridTreeBody()));
			//alert(GRIDTREE.html())
			return GRIDTREE.html();
		};

		//初始化函数
		GRIDTREE.init = function()
		{
			//如果GRIDTREE.data.tableTreeData.data得长度小于0，默认调用ajax获取数据化表格实体
			//否者默认按照外围配置的数据，做为画表格实体的数据
			if (GRIDTREE.data.tableTreeData && GRIDTREE.data.tableTreeData.length <= 0)
			{
				//若为ajax请求，url不能为空或空格
				if (!GRIDTREE.ajax.url)
				{
					alert("GRIDTREE.data.ajax.url is not null");
					return false;
				}
				GRIDTREE.ajax.data = GRIDTREE.data.ajax.data + "&paramMap.parentID=" + GRIDTREE.data.treeNodeStartValue;				
				//目前只支持json格式，若需要xml格式可在进行开发
				$.ajax(GRIDTREE.ajax);
			}
			else{
				//先清空在画表格
				GRIDTREE.html("");	
				//在目标元素内画表格
				GRIDTREE.html(GRIDTREE.drawGridTree());
				//设置表格体tr的样式和事件
				GRIDTREE.gridEvent();
			    //表格画好之后，可以执行一些默认设置函数
				if (typeof GRIDTREE.option.extendInit == 'function'){
					GRIDTREE.option.extendInit();
				}
			}
		};
		//开始初始化
		GRIDTREE.init();		
};