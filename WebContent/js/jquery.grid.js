//data：json格式字段描述，表格内容，分页描述
//opt：     相关操作对外开放配置或扩展
$.fn.gridTB = function(data,opt){
		//表格类对象
		var GRID = this;	
		//总记录数
		var recordCount = 0;
		//每页显示记录数
		var pageSize=8;	
		//当前页数preview_
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
				//序列号参数配置
				serialno: Array(),				
				//列表checkbox列参数配置
				checkbox: Array(),
				//列表快捷菜单列参数配置
				shortcut:	Array(),
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
					var $table = $("<table></table>");
					var $tr = $("<tr></tr>");
					var $td1 = $("<td></td>");
					var $td2 = $("<td ></td>");
					var $img = $("<img>")
						.attr("src","images/wait/loader.gif")
						.attr("width","30")
						.attr("height","30") 
						.attr("border","0");
					GRID.attr("align","center");
					 $td1.append($img);
					 $td2.append("信息正在载入，请稍后……");
					 $tr.append($td1).append($td2);
					 $table.append($tr);
					 GRID.html($table);
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
		//默认设置一些常用小图标
		//删除和默认和关键字冲突，改成简写
		GRID.icon = {
				def:'',	
				statichtml:'images/main/picview/scanner1.png',
				preview:'images/common/255.gif',
				check:'images/common/333.gif',
				sort:'images/common/204.gif',
				recom:'images/common/395.gif',
				create:'images/common/004.gif',
				del:'images/common/109.gif',
				password:'images/common/089.gif',
				modify:'images/common/113.gif',				         
				detail:'images/common/107.gif',
				grand:'images/common/001.gif',
				group:'images/common/383.gif',
				grant:'images/common/392.gif',
				bind:'images/common/361.gif'
		};


		//将配置的数据替换，增加到data对象中
		GRID.data = $.extend(GRID.data,data);
		//将配置的数据替换，增加到option对象中
		GRID.option = $.extend(GRID.option,opt);
		//将配置的数据替换，增加到ajax对象中
		GRID.ajax = $.extend(GRID.ajax,GRID.data.ajax);

		//计算表格的每列的宽度
		//若设置宽度就按照设置的宽度显示，否者安列平均分配
		GRID.gridWidth = function(i)
		{
			var wth = GRID.data.columnDesc.columnWidth[i];
			var len = GRID.data.columnDesc.columnWidth.length;
			if (len == 0)
				len = 1;			
			//如果没有设置宽度，用100除以字段数量的平均值为column宽度
			if(!wth)
				wth = parseInt(100/len) + "%";
			return wth;
		};
		
		//画表格的头
		GRID.drawGridHead = function()
		{
			//画thead
			var $hthead = $("<thead></thead>").addClass("gridHeadThead");
			//画tr
			var $htr = $("<tr></tr>").addClass("gridHeadTr");
			//循环画head每列的内容
			if (GRID.data.columnDesc.columnName){
				$.each(GRID.data.columnDesc.columnName,function(i){
					var name = "";
					if (GRID.data.columnDesc.showColumn[i]){
						name = GRID.data.columnDesc.showColumn[i];
					}
					var dbcol = "",ord = "";
					if (GRID.data.columnDesc.orderColumn){
						for(var j=0;j<GRID.data.columnDesc.orderColumn.length;j++){
							if (GRID.data.columnDesc.orderColumn[j].name == name){
								ord = GRID.data.columnDesc.orderColumn[j].order == ""?"desc":GRID.data.columnDesc.orderColumn[j].order;
								dbcol = GRID.data.columnDesc.orderColumn[j].col;
								break;
							}
						}
					}
					if (ord == "" || dbcol == "" ){
						$htr.append($("<th>"+this+"</th>")
								.attr("width",GRID.gridWidth(i))
								.attr("align","center")
								.addClass("gridHeadTh"));						
					}
					else{
						$htr.append($("<th></th>")
								.append($("<a>"+this+"</a>").attr("href","javascript:void(0);").attr("id",dbcol).append(function(){
									if (order != "" && dbcol != "" && ord != ""){
										var ncon = order.replace(" asc", "").replace(" desc", "");
										if (ncon.toLowerCase() == dbcol.toLowerCase()){
											if (order.indexOf("asc") > -1){
												return "↓";
											}
											else{
												return "↑";
											}
										}
										else{
											return "";
										}
									}
									else{
										return "";
									}
								})).attr("width",GRID.gridWidth(i))
								.attr("align","center")
								.addClass("gridHeadTh"));						
					}
				});
			}
			//画表格序列号
			$htr = GRID.drawSeriano('',$htr,"th");		
			//画checkbox
			$htr = GRID.drawCheckbox('',$htr,"th");
			//画快捷菜单
			$htr = GRID.drawShortcut('',$htr,"th");		
			
			return $hthead.append($htr);
		};
	    
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
		
		//计算预览资源类型值
		GRID.getPreview = function(row)
		{
			var type = '';
			if (GRID.data.columnDesc.typeColumn){
				$.each(GRID.data.columnDesc.typeColumn,function(i){
					if (GRID.data.columnData[row]){
						type = eval("GRID.data.columnData["+row+"]." + this);
					}
				});
			}
			return type;
		};
		
		//计算预览资源名称值
		GRID.getPreviewName = function(row)
		{
			var name = '';
			if (GRID.data.columnDesc.nameColumn){
				$.each(GRID.data.columnDesc.nameColumn,function(i){
					if (GRID.data.columnData[row]){
						name = eval("GRID.data.columnData["+row+"]." + this);
					}
				});
			}
			return name;
		};
		
		//计算收藏夹预览参数
		GRID.getResurlColumn = function(row)
		{
			var name = '';
			if (GRID.data.columnDesc.resurlColumn){
				$.each(GRID.data.columnDesc.resurlColumn,function(i){
					if (GRID.data.columnData[row]){
						name = eval("GRID.data.columnData["+row+"]." + this);
					}
				});
			}
			return name;
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
						.attr("href","javascript:void(0);");						
					}
				});
			}
			return $rval;
		};
		
		//画表格的body
		GRID.drawGridBody = function()
		{
			var $body = $("<tbody></tbody>").attr("id","gridTbody");
			$.each(GRID.data.columnData,function(i){
				$btr = $("<tr></tr>");
				
				if(typeof GRID.option.handerShortcutStatus == 'function'){
					GRID.data.disabledRow = GRID.option.handerShortcutStatus(GRID.data.columnData[i],i);
				}
				
				if (GRID.data.columnDesc.showColumn){
					$.each(GRID.data.columnDesc.showColumn,function(j){
						var colname = GRID.data.columnDesc.showColumn[j];
						var val = eval("GRID.data.columnData[" + i + "]." + colname);
					
						if(val == null || val==''){
							val = ' 无 ';
						}
						
						//调用别名转换函数
						if (typeof GRID.option.columnAlias == 'function')
						{ 
							val = GRID.option.columnAlias(colname,val);
							
						}
						
						var $ncol = GRID.addColumnLink(i,colname,val);
						$btr.append($("<td></td>")
								.append($ncol)
								.attr("class","gridBodyTd")
								.attr("align","center"));
					});
				}
				//画checkbox
				$btr = GRID.drawSeriano(i,$btr,"td");				
				//画checkbox
				$btr = GRID.drawCheckbox(i,$btr,"td");
				//画快捷菜单
				$btr = GRID.drawShortcut(i,$btr,"td");
				$body.append($btr);
			});
			
			return $body;
		};
		
		//画表格序列号
		GRID.drawSeriano = function(row,$linetr,type)
		{
			if (GRID.data.serialno)
			{			
				var cpage = GRID.data.paginationData.currentPage;
				var pages = GRID.data.paginationData.pageSize;
				var rcnt = GRID.data.paginationData.recordCount;
				var shownum = "";
				if (GRID.data.serialno.order == 'd')
					shownum = (cpage-1)*10 + (row + 1);
				else
					shownum = rcnt - ((cpage-1)*10 + row);
				if (!GRID.data.serialno.width)
					GRID.data.serialno.width = "10%";
				var $ipt = $("<"+type+"></"+type+">")
							.addClass((type == 'th') ?"gridHeadTh":"gridHeadTd")
							.attr("align","center")
							.attr("width",GRID.data.serialno.width)
							.attr("name",type == 'th'?'serialnoTh':'serialnoTd')
							.attr("id",type == 'th'?'serialnoTh':'serialnoTd')
							.append((type == 'th')?GRID.data.serialno.name:shownum);
				if (GRID.data.serialno.type == 'first')
				{
					$linetr = $linetr.prepend($ipt);
				}
				else if (GRID.data.serialno.type == 'last')
				{				
					$linetr = $linetr.append($ipt);
				}
			}
			return $linetr;			
		};
		
		//画表格单选或复选按钮
		//linetr：插入行jquery对象，type：th或td
		GRID.drawCheckbox = function(row,$linetr,type)
		{
			//只有设置GRID.data.checkbox的时候才在表格第一列或最后一列画checkbox按钮
			//根据具体的参数值来确定画在第一列还是最后一列
			//first:首列，last：最后一列
			if (GRID.data.checkbox)
			{			
				if (!GRID.data.checkbox.width)
					GRID.data.checkbox.width = "10%";
				var $ipt = $("<"+type+"></"+type+">")
							.addClass((type == 'th') ?"gridHeadTh":"gridHeadTd")
							.attr("align","center")
							.attr("width",GRID.data.checkbox.width)
							.attr("name",type == 'th'?'checkboxAll':'checkboxVal')
							.attr("id",type == 'th'?'checkboxAll':'checkboxVal')
							.append(function(){
								var $input = '';
								var boo = $.browser.msie? $.browser.msie : false;
								if (boo){
									var dis = '';
									if(row==GRID.data.disabledRow){
										dis += 'disabled';
									}
									$input ="<input type='checkbox' class='jq_gridCheckbox' "
			            				+ " name='paramMap.gridCheckboxVal' id='gridCheckboxVal' "+dis+" value='"
										+ GRID.getPrimkey(row) + "'>";
									//alert(GRID.getPrimkey(row));
								}
								else{
									
									$input = $("<input/>").attr("type","checkbox")
									       .attr("class","jq_gridCheckbox")
									       .attr("name","paramMap.gridCheckboxVal")
									       .attr("id","gridCheckboxVal")
									       .attr("value",GRID.getPrimkey(row))
									       .css("margin","0px");
							        if(row==GRID.data.disabledRow){
							        	$input.attr("disabled","true");
									}      
							        
								}
								
								return $input;
					        }).append((type == 'th')? "<span>"+GRID.data.checkbox.name+"</span>":'');
				if (GRID.data.checkbox.type == 'first')
				{
					$linetr = $linetr.prepend($ipt);
				}
				else if (GRID.data.checkbox.type == 'last')
				{				
					$linetr = $linetr.append($ipt);
				}
			}
			return $linetr;
		};
		
		//画表格快捷方式菜单
		GRID.drawShortcut = function(row,$linetr,type)
		{
			if (!GRID.data.shortcut.width)
				GRID.data.shortcut.width = "15%";
			//权限判断，如果没有任何权限不画快捷菜单
			if(GRID.data.shortcut.event){
				var boo = false;
				for (var i=0;i<GRID.data.shortcut.event.length;i++){
					var isv = GRID.data.shortcut.event[i].isvalid;
					if (isv == 'true'){
						boo = true;
						break;
					}
				}
				if (!boo)
					return $linetr;
			}			
			//是否生成快捷菜单
			if (GRID.data.shortcut && GRID.data.shortcut.event)
			{
				if (type == 'th')
				{
					$linetr.append( $("<th>"+GRID.data.shortcut.name+"</th>")
							.attr("align","center")
							.attr("width",GRID.data.shortcut.width)
							.addClass("gridHeadTh"));
				}
				else
				{
					
					var $sctd = $("<td></td>")							
							.attr("class","gridBodyTd")
							.attr("width",GRID.data.shortcut.width)
							.attr("align","center");
					//画图标和描述连接
					$.each(GRID.data.shortcut.event,function(i){
						var imgsrc = GRID.icon.def; 
						if (GRID.data.shortcut.event[i].icon)
						{
							imgsrc = GRID.data.shortcut.event[i].icon;
						}
						else{
							if (GRID.data.shortcut.event[i].operate){
								var im = eval("GRID.icon."+GRID.data.shortcut.event[i].operate);
								if (im){
									imgsrc = im;
								}
							}
						}
						
						//配置快捷菜单式串的参数
						var param = GRID.data.shortcut.event[i].param ? GRID.data.shortcut.event[i].param + "##":"";						
						var isv = GRID.data.shortcut.event[i].isvalid;
						if (isv == 'true'){
							var dshortcut = '';
							//是否有切入处理函数
							if(typeof GRID.option.extendDrawShortcut == 'function'){
								dshortcut = GRID.option.extendDrawShortcut(GRID.data.columnData[row],GRID.data.shortcut.event[i].operate);
							}
							if(param.indexOf("preview_") > -1){
								var code_ = GRID.option.columnCode_("code_",GRID.getPreview(row));
								//alert(GRID.getPreview(row));
								param = "code="+code_;
								
								var name_ = GRID.getPreviewName(row);
								param += "&paramMap.name="+name_ + "##";
							}else if(param.indexOf("favorite_") > -1){
								var code_ = GRID.getResurlColumn(row);
								param = code_;
								
							};
							if (dshortcut){
								$sctd.append(
										$("<span>&nbsp;&nbsp;</span>").append(
											$("<span>"+this.name+"</span>").css("color","#ACA899")
											.prepend($("<img></img>").attr("src",imgsrc)
										    		 .attr("border","0").attr("align","absmiddle")
										    		 .attr("width","14").attr("height","14")
											)
										));
							}
							else{
								var disabled = GRID.data.shortcut.event[i].disabled;
								if(!disabled){
									disabled = 'false';
								}
								if(row==GRID.data.disabledRow){
									GRID.data.rowDisabled = 'true';
								}else{
									GRID.data.rowDisabled = 'false';
								}
								if(GRID.data.rowDisabled=='true'&&disabled=='true'){
									disabled = 'true';
								}else{
									disabled = 'false';
								}
								if (disabled == 'true'){
									$sctd.append(
										$("<span>&nbsp;&nbsp;</span>").append(
											$("<span>"+this.name+"</span>").css("color","#ACA899")
											.prepend($("<img></img>").attr("src",imgsrc)
										    		 .attr("border","0").attr("align","absmiddle")
										    		 .attr("width","14").attr("height","14")
											)
										));
									 
								}
								else{
									var delcolorname = "";
									if(GRID.data.shortcut.event[i].operate == 'del'){
										delcolorname = "del";
									}
									
									$sctd.append($("<span></span>").append($("<a name='"+i+"'><span>"+this.name+"</span></a>").attr("href","javascript:void(0);").attr("data-old-bg","rgb(174, 155, 132)")
													 .attr("id",GRID.data.shortcut.event[i].operate).addClass("ashortcut lt-button fade-button " + delcolorname).append($("<input/>").attr("type","hidden").attr("value",param + GRID.getPrimkey(row)))));		
								}
								
								//alert(param);
								
								
							}
						}
					});
					
					$linetr.append($sctd);
				}
			}
			return $linetr;
		};
		
		//设置表格体行的样式，并绑定相关事件
		GRID.gridEvent = function()
		{
			//设置头checkbox绑定事件和样式(全选函数)
			$("#"+GRID.attr("id")+" thead tr input[type='checkbox']").unbind("click").bind("click",function(){
				if (this.checked){
					$("#gridTable tbody input[type='checkbox']").each(function (){
						
						if(!this.disabled){
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
					$("#"+GRID.attr("id")+" tbody input[type='checkbox']").each(function (){
						if(!this.disabled){
							this.checked = false;
						}
					});		
					var cval = $(this).val();
					if(cval==null || cval==''){
						$("#hide_"+GRID.data.columnDesc.primkeyColumn).val("");
					}
				}
			});

			//单个复选按钮绑定事件
			$("#"+GRID.attr("id")+" tbody input[type='checkbox']").each(function (){
				$(this).unbind("click").bind("click",function(){
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
						$("#"+GRID.attr("id")+" tbody input[type='checkbox']").each(function(){
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
					}else{
						var cval = $(this).val();
						if(cval){
							var vc = cval.split("=")[1];
							var vk = $("#hide_"+GRID.data.columnDesc.primkeyColumn).val();
							$("#hide_"+GRID.data.columnDesc.primkeyColumn).val(vk.replace(vc+",","").replace(","+vc,""));
						}
					}
					
					var checkSize = GRID.data.paginationData.recordCount;
					if(checkSize>=GRID.data.paginationData.pageSize)
						checkSize = GRID.data.paginationData.pageSize;
					$("#"+GRID.attr("id")+" thead tr input[type='checkbox']").attr("checked",checkSize == $("#"+GRID.attr("id")+" tbody input[type='checkbox']:checked").length ? true : false);  
				});
			});		
			//设置列表内容自动换行
			$("#"+GRID.attr("id")+" tbody td").css({"word-wrap":"break-word","word-break":"break-all"});
			
			$("#"+GRID.attr("id")+" thead a").each(function(){
				$(this).unbind("click").bind("click",function(){
					var ocol = tmpcol = $(this).attr("id");
					var ahtml = $(this).html();
					if (ahtml.indexOf("↓") > -1){
						ahtml = ahtml.replace("↓","↑");
						ocol += " desc";
					}					
					else if (ahtml.indexOf("↑") > -1){
						ahtml = ahtml.replace("↑","↓");
						ocol += " asc";
					}
					else{
						ahtml = ahtml+"↓";
						ocol += " asc";
					}
					if (GRID.data.columnDesc.orderColumn){
						for(var j=0;j<GRID.data.columnDesc.orderColumn.length;j++){
							if (tmpcol == GRID.data.columnDesc.orderColumn[j].col){
								if (ahtml.indexOf("↓") > -1){
									GRID.data.columnDesc.orderColumn[j].order = "asc";
								}
								else{
									GRID.data.columnDesc.orderColumn[j].order = "desc";
								}
								break;
							}
						}
					}			
					$(this).html(ahtml);
					order = ocol;
					var pgs = 10;
					if (GRID.data.paginationData.pageSize)
						pgs = GRID.data.paginationData.pageSize;
					
					GRID.ajax.data = GRID.data.ajax.data + "&paramMap.order="+ocol+"&pageSize=" + pgs + "&" + GRID.data.globalParam;
					$.ajax(GRID.ajax);
				});
			});
			//设置奇数列样式和绑定事件
			$("#"+GRID.attr("id")+" tbody tr:odd").removeClass()
			.addClass("gridBodyTrOutOdd").bind("mouseover",function(){
					$(this).removeClass().addClass("gridBodyTrOver");
				}).bind("mouseout",function(){
					$(this).removeClass().addClass("gridBodyTrOutOdd");
				}).unbind("click").bind("click",function(){
					if(typeof GRID.option.trClick == 'function')
					{
						//TREE.option.trClick(this,);
					}
			});
			
			//设置偶数列样式和绑定事件
			$("#"+GRID.attr("id")+" tbody tr:even").removeClass()
			.addClass("gridBodyTrOutEven").bind("mouseover",function(){
					$(this).removeClass().addClass("gridBodyTrOver");
				}).bind("mouseout",function(){
					$(this).removeClass().addClass("gridBodyTrOutEven");
				}).unbind("click").bind("click",function(){
					if(typeof GRID.option.trClick == 'function')
					{
						//TREE.option.trClick(this,);
					}
			});
			//设置快捷菜单事件
			$("#"+GRID.attr("id")+" tbody a").filter(".ashortcut").each(function(){
				var name = $(this).attr("name");
				//主键串
				var pk = $("input",$(this)).attr("value");
				$(this).attr("href","javascript:void(0);");
				$(this).unbind("click").bind("click",function(){
					
					var jsonParam = GRID.data.shortcut.event[name].param;
					//alert(jsonParam.indexOf("favorite_"));
					var jsonParamHelp = jsonParam;
					//对外开放的函数，若写此函数，就调用此函数
					
					if(jsonParam.indexOf("preview_") > -1){
						var jsonParam_ = GRID.option.columnCode_("code_",pk);
						jsonParam = jsonParam_.split("##")[0];
					}else if(jsonParam.indexOf("favorite_") > -1){
						jsonParam = pk;
					};
					if (typeof GRID.option.shortcutClick == 'function'){
						GRID.option.shortcutClick($(this),jsonParam + "##" + pk);
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
						/*var faction = $("#" +GRID.data.formID).attr("action");
						$("#" +GRID.data.formID).attr("action",faction +"?"+jsonParam);
						$("#" +GRID.data.formID).submit();	*/
						var faction = $("#" +GRID.data.formID).attr("action");
						//alert(jsonParamHelp.indexOf("preview_") > -1);
						if(jsonParamHelp.indexOf("preview_") > -1){
							var codep = jsonParam.substring(jsonParam.indexOf("code")+5,jsonParam.indexOf("&"));
							var name1 = jsonParam.substring(jsonParam.indexOf("name")+5,jsonParam.lastIndexOf("&"));
							var para = jsonParam.substring(jsonParam.indexOf("&")+1);
							//alert(faction +"?"+"code="+codep+"&"+para);
							//window.parent.parent.tabClick('R_PRE',name1,codep,para);
							//alert(name1+"======"+codep+"======"+para);
							$("#" +GRID.data.formID).attr("action",faction +"?"+"code="+codep+"&"+para);
							$("#" +GRID.data.formID).submit();	
						}if(jsonParamHelp.indexOf("favorite_") > -1){
							var codep = jsonParam.substring(jsonParam.indexOf("code")+5,jsonParam.indexOf("&"));
							var name1 = jsonParam.substring(jsonParam.indexOf("name")+5,jsonParam.lastIndexOf("&"));
							var para = jsonParam.substring(jsonParam.indexOf("&")+1);
							//alert(faction +"?"+"code="+codep+"&"+para);
							//alert(name1+"======"+codep+"======"+para);
							window.parent.parent.parent.tabClick_redirect('R_PRE',name1,codep,para);
							//$("#" +GRID.data.formID).attr("action",faction +"?"+"code="+codep+"&"+para);
							//$("#" +GRID.data.formID).submit();	
						}else{
							$("#" +GRID.data.formID).attr("action",faction +"?"+jsonParam);
							$("#" +GRID.data.formID).submit();	
						}	
					}
				});
			});
			
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
							$(this).attr("href","javascript:void(0);");
							$(this).unbind("click").bind("click",function(){
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
									//alert(param);
									if(param=="ResUrl"){
										var st=pk.split("##")[pk.split("##").length-1],st_=pk.split("##");
										for(var m=0;m<pk.split("##").length;m++){
											if(st_[m].indexOf("srResUrl")>=0){
												st=st_[m];
											}
										}
										st=st.substring(st.indexOf("=")+1);
										var codep = st.substring(st.indexOf("code")+5,st.indexOf("&"));
										//var name1 = jsonParam.substring(param.indexOf("name")+5,param.lastIndexOf("&"));
										var para = st.substring(st.indexOf("&")+1);
										//alert(codep+para);
										window.parent.parent.parent.tabClick_redirect('R_PRE',"",codep,para);
									}else if(param=="ResUrl2"){
										var st=pk.split("##")[pk.split("##").length-1];
										var ptype="",pid="",st_=pk.split("##");
										for(var m=0;m<pk.split("##").length;m++){
											if(st_[m].indexOf("srPtype")>=0){
												ptype=st_[m];
											}else if(st_[m].indexOf("srPID")>=0){
												pid=st_[m];
											}else if(st_[m].indexOf("srResUrl")>=0){
												st=st_[m];
											}
										}
										ptype=ptype.substring(ptype.indexOf("srPtype")+8);
										pid=pid.substring(pid.indexOf("srPID")+6);
									    var codep = st.substring(st.indexOf("code")+5,st.indexOf("&"));
										//var name1 = jsonParam.substring(param.indexOf("name")+5,param.lastIndexOf("&"));
										var para = st.substring(st.indexOf("&")+1);
										var resURL="code="+codep+para;
										//alert(ptype);
										//alert(pid);
										//alert(resURL);
										art.dialog.data('ptype', ptype);
										art.dialog.data('reviewID', pid);
										art.dialog.data('resURL', resURL);
										art.dialog.open('module/enginev/pinglun.jsp',{width:611,height:374,title:'资源评论详情'}) ;
									}else if(param=="explore"){
										var st=pk.split("##")[pk.split("##").length-1],st_=pk.split("##");
										var htaskID = st.substring(st.indexOf("htaskID")+8,st.indexOf("##"));
										var htaskIssplit = st.substring(st.indexOf("htaskIssplit")+13,st.indexOf("##"));
										var htaskKeywords = st.substring(st.indexOf("htaskKeywords")+14);
										for(var m=0;m<pk.split("##").length;m++){
											if(st_[m].indexOf("htaskID")>=0){
												htaskID=st_[m];
											}else if(st_[m].indexOf("htaskIssplit")>=0){
												htaskIssplit=st_[m];
											}else if(st_[m].indexOf("htaskKeywords")>=0){
												htaskKeywords=st_[m];
											}
										}
										htaskID = htaskID.substring(htaskID.indexOf("htaskID")+8);
										htaskIssplit = htaskIssplit.substring(htaskIssplit.indexOf("htaskIssplit")+13);
										htaskKeywords = htaskKeywords.substring(htaskKeywords.indexOf("htaskKeywords")+14);
										//var name1 = jsonParam.substring(param.indexOf("name")+5,param.lastIndexOf("&"));
										var thecode = "-1890001";
						        		if(htaskIssplit==1){
						        			thecode = "-1890002";
						        		}
										//alert(htaskID+"=="+htaskIssplit+"=="+htaskKeywords);
										//window.parent.tabClick("munu_name","问题浏览",thecode,"paramMap.taskchoosetagindexhref=1&paramMap.createkeywords="+createkeywords+"&paramMap.htaskID="+createhtaskID+"&pageSize=8&type=1");
										window.parent.parent.parent.tabClick_redirect('explore',"问题浏览",thecode,"paramMap.taskchoosetagindexhref=1&paramMap.createkeywords="+htaskKeywords+"&paramMap.htaskID="+htaskID+"&pageSize=8&type=1");
									}else if(param=="testUrl"){
										var st=pk.split("##")[pk.split("##").length-1];
										st=st.substring(st.indexOf("=")+1);
									    var id = pk.substring(pk.indexOf("=")+1, pk.indexOf("#"));
										var codep = st.substring(st.indexOf("code")+5,st.indexOf("&"));
										//var name1 = jsonParam.substring(param.indexOf("name")+5,param.lastIndexOf("&"));
										var para = st.substring(st.indexOf("&")+1);
										codep = codep.split(",")[0];
										art.dialog.data('contextPath','/dm');
										art.dialog.open('decorateForwardAction.action?code=-170102&paramMap.testGrades ='+codep+ '&paramMap.testID ='+ id+ '&paramMap.testNum =1',
											{
												width : 950,
												height : 604,
												title : '探究热身',
												lock : 'true',
												background : '#666666',
												opacity : '0.15'
											});
									}else{
										$("#" +GRID.data.formID).attr("action",fsrc + "?" + param);
										$("#" +GRID.data.formID).submit();		
									}
																
								}
							});
						});						
					}
				});
			}
			$("#"+GRID.attr("id")+" tbody a").filter(".pagea").each(function(){
				$(this).unbind("click").bind("click",function(){
					var aid = $(this).attr("id");
					$(this).attr("href","javascript:void(0);");
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
			$("#pagego").unbind("click").bind("click",function (){
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
		
			var $page = $("<p></p>");
			if (this.currentPage <= 1){
				$page.append($("<span>&nbsp;</span>")
						.append("<span style='color: #636363;'>首页</span>"))
					 .append($("<span>&nbsp;</span>")
						.append("<span style='color: #636363;'>上一页</span>"));
			}
			else{
				$page.append($("<span>&nbsp;</span>")
						.append($("<a>首页</a>")
						.attr("href","javascript:void(0);")
						.attr("id","1")
						.addClass("pagea")))
					 .append($("<span>&nbsp;</span>")
						.append($("<a>上一页</a>").attr("href","javascript:void(0);")
						.attr("id",(this.currentPage-1))
						.addClass("pagea")));				
			}
			if (this.currentPage == this.pageCount || this.pageCount == 0) {
				$page.append($("<span>&nbsp;</span>")
						.append("<span style='color: #636363;'>下一页</span>"))
					 .append($("<span>&nbsp;</span>")
						.append("<span style='color: #636363;'>尾页</span>"));				
			}
			else{
				
				$page.append($("<span>&nbsp;</span>")
						.append($("<a>下一页</a>")
						.attr("href","javascript:void(0);")
						.attr("id",(this.currentPage+1))
						.addClass("pagea")))
				 .append($("<span>&nbsp;</span>")
						.append($("<a>尾页</a>")
						.attr("href","javascript:void(0);")
						.attr("id",this.pageCount)
						.addClass("pagea")));	
			}
			
			$page.append("&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: #636363;'>每页</span>&nbsp;<font color='#FF0000'>" + this.pageSize + "</font>&nbsp;&nbsp;<span style='color: #636363;'>总数</span>&nbsp;<font color='#FF0000'> " + this.recordCount + "</font>");
			
			$page = $("<tr></tr>")
				.addClass("pageTr") 	
				.append($("<td></td>")
				.attr("align","center")
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
						$input = $("<input type='hidden'" + " name='paramMap." + GRID.data.columnDesc.primkeyColumn[h] + "' id='hide_" +GRID.data.columnDesc.primkeyColumn[h]+ "'>");
						
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
					.attr("cellspacing","0")
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
	;
};