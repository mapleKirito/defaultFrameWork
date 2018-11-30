/**
 *    var stb = $("#testdiv").selectTB({			
			primkeyColumn:'orgID',
			//要进行树型显示的列，支持一列
			selectShowColumn:'orgName',
			//树型下拉树列表，起始根值
			nodeStartValue:'0', 
			//描述树形菜单子列
			childNodeColumn:'orgID',
			//描述树形菜单父列
			parentNodeColumn:'orgParentID',	
	    	//ajax 获取所有树json格式信息
	    	ajax:{
				//ajax请求url
				url:'ajaxAction.action', 
				//ajax请求参数
				data:'code=${code}'
			}
		    //selectData:[
		    //   {roleID:'1',roleParentID:'0',roleName:'测试1',address:'北京',orgType:'31'},
		    //   {roleID:'2',roleParentID:'0',roleName:'测试2',address:'北京',orgType:'31'},
		    //   {roleID:'3',roleParentID:'0',roleName:'测试3',address:'北京',orgType:'31'},
		    //   {roleID:'4',roleParentID:'2',roleName:'测试4',address:'北京',orgType:'31'},
		    //   {roleID:'5',roleParentID:'3',roleName:'测试5',address:'北京',orgType:'31'},
		    //   {roleID:'6',roleParentID:'4',roleName:'测试6',address:'北京',orgType:'31'},
		    //   {roleID:'7',roleParentID:'5',roleName:'测试7',address:'北京',orgType:'31'},
		    //   {roleID:'8',roleParentID:'3',roleName:'测试8',address:'北京',orgType:'31'},
		    //   {roleID:'9',roleParentID:'4',roleName:'测试9',address:'北京',orgType:'31'},
		    //   {roleID:'10',roleParentID:'5',roleName:'测试10',address:'北京',orgType:'31'},
		    //   {roleID:'11',roleParentID:'6',roleName:'测试11',address:'北京',orgType:'31'},
		    //   {roleID:'12',roleParentID:'7',roleName:'测试12',address:'北京',orgType:'31'},
		    //   {roleID:'13',roleParentID:'8',roleName:'测试13',address:'北京',orgType:'31'}
		   // ]
		},{
		   animated:false
	   }); 
 */

jQuery.fn.selectTB = function(data,opt){
	
	var SELECT = this;
	var nodeCnt = 0;
	var _parent = SELECT.parent();
	
	SELECT.data = {
		//传值元素ID
		valElementID:'',	
		//显示元素ID
		textElementID:'',			
		//下拉宽度
		selectWidth:'150',
		//下拉高度	
		selectHeight:'16',	
		//主键存放对象
		primkeyColumn:Array(),
		//要进行树型显示的列，支持一列
		selectShowColumn:'',
		//树根描述
		rootName:'', 
		//树根值
		rootValue:'0', 		
		//树型下拉树列表，起始根值
		nodeStartValue:'0', 
		//描述树形菜单子列
		childNodeColumn:'',
		//描述树形菜单父列
		parentNodeColumn:'',	
    	//ajax 获取所有树json格式信息
    	ajax:Array(),
    	//json格式数据
	    selectData:Array()
	};
	
	//ajax请求，系统默认配置参数，此参数可以通过外围配置覆盖
	SELECT.ajax = {
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
				
			},
			
			complete:function(request,textStatus){},
			
			success:function(jsonData,textStatus){
				//如果正常返回,设置TREE.data.columnData
				//为ajax请求放回的json格式的数据
				if (textStatus == "success"){
					//ajax请求返回json格式数据
					SELECT.data.selectData = jsonData.data;
					//画下拉列表
					var $select = SELECT.drawSelect();
					//SELECT.html($select);
					//设置样式
					SELECT.selectCss($("#jq_selectMenu"));
					//设置事件
					SELECT.bindEvent($select);	
				}
			},
			
			error:function(request,textStatus,error){}
	};		
	
	SELECT.options= {
		animated:true
	};	
    
	
	//将配置的数据替换，增加到data对象中
	SELECT.data = $.extend(SELECT.data,data);
	//将配置的数据替换，增加到option对象中
	SELECT.options = $.extend(SELECT.options,opt);	
	//将配置的数据替换，增加到ajax对象中
	SELECT.ajax = $.extend(SELECT.ajax,SELECT.data.ajax);		
	
	//画下拉列表
	SELECT.drawSelect = function()
	{
		var indexsv = SELECT.data.nodeStartValue;
		//获取页面元素默认值
		var defVal = $("#"+SELECT.data.valElementID).val();
		//记录默认节点
		var selectedData = null;
		if(defVal == ""){
			$("#"+SELECT.data.textElementID).val(SELECT.data.rootName);
			$("#"+SELECT.data.valElementID).val(SELECT.data.rootValue);
			defVal = 0;
		}
		var $cul = $("<div></div>");
		$.each(SELECT.data.selectData,function(i){
			//取文本值
			var tscolVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.selectShowColumn);
			//取文本值对应的数值
			var cindexVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.childNodeColumn);
			//取文本值对应的数值
			var pindexVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.parentNodeColumn);
			//如果文本值为空，取页面默认填写的文本值，为文本显示内容
			if (!tscolVal){
				tscolVal = SELECT.data.selectShowColumn;
			}
			//如果默认值和取到的下拉值相等，文本内容显示为对应的文本内容
			if (defVal == cindexVal){
				$("#"+SELECT.data.textElementID).val(tscolVal);
				selectedData = "SELECT.data.selectData["+i+"]";
			}
			//先画根节点，起始值为SELECT.data.nodeStartValue的节点，一般默认为0
			if (indexsv == pindexVal){
				nodeCnt++;
				$cul.append(
					$("<li></li>").append(
						$("<div></div>").append(
							$("<a></a>").attr("href","#").append(tscolVal).attr("id","hidden_"+nodeCnt)
							.addClass(nodeCnt==0?"selected":"")
							.append(function(){
								var $input = '';
								var allVal = cindexVal + "##" + tscolVal;
					        	if (SELECT.data.primkeyColumn){
					        		for(var p=0; p<SELECT.data.primkeyColumn.length;p++){
					        			if (SELECT.data.primkeyColumn[p] 
					        			   && SELECT.data.childNodeColumn != SELECT.data.primkeyColumn[p]){
					        				var otherVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.primkeyColumn[p]);
					        				if (otherVal){			
					        					allVal+="##"+otherVal;
					        				}
					        			}
					        		}
					        	}			        					
								var boo = $.browser.msie? $.browser.msie : false;
								if (boo){
									$input = $("<input type='hidden'"
				            				+ " name='allVal' id='allVal' value='"
											+ allVal + "'>");
								}	
								else{
									$input = $("<input/>").attr("type","hidden")
									.attr("name","allVal")
									.attr("id","allVal")
									.attr("value",allVal);
								}
								return $input;
							})
						)
					).append(function(){
						//调用递归函数，画每个根节点下的子节点
						return SELECT.recursive(cindexVal);
					}).addClass("jq_selectBoxItem")
				);
			}
		});
		var $rootul = "";
		//是否有根节点
		if(SELECT.data.rootName){
			$rootul = $("<ul></ul>").addClass("jq_selectMenu")
	        .attr("id","jq_selectMenu").css("width",SELECT.data.selectWidth).append(
	      	   $("<li></li>").addClass("jq_selectBoxItem").append(
	      		    $("<div></div>").append(
	      			     $("<a></a>").attr("href","#")
	      			     .append(SELECT.data.rootName)
	      			     .attr("id","hidden_0").append(function(){
	      			    	var allVal = SELECT.data.rootValue + "##" + SELECT.data.rootName;
							var boo = $.browser.msie? $.browser.msie : false;
							if (boo){
								$input = $("<input type='hidden'"
			            				+ " name='allVal' id='allVal' value='"
										+ allVal + "'>");
							}	
							else{
								$input = $("<input/>").attr("type","hidden")
								.attr("name","allVal")
								.attr("id","allVal")
								.attr("value",allVal);
							}
							return $input;
	      			     })	
	      			)	   
	      	   ).append($cul)	  
	        );	
		}
		else{
			$rootul = $("<ul></ul>").addClass("jq_selectMenu").attr("id","jq_selectMenu").css("width",SELECT.data.selectWidth).append($cul).addClass("jq_selectBoxItem");
		}
		var $wrapHtml = $("<div></div>").addClass("jq_selectBox")
		                    .css("width",SELECT.data.selectWidth)
		                    .css("height",SELECT.data.selectHeight).appendTo(_parent)
			        .append(function(){
			        	if (SELECT.data.primkeyColumn){
			        		var $div = $("<div></div>").attr("display","none");
			        		for(var p=0; p<SELECT.data.primkeyColumn.length;p++){
			        			if (SELECT.data.primkeyColumn[p] 
			        			   && SELECT.data.childNodeColumn != SELECT.data.primkeyColumn[p]){
			        				var $ipt = '';
									var boo = $.browser.msie? $.browser.msie : false;
									if (boo){
										$ipt =document.createElement("<input type='hidden'"
												+" name='paramMap."+ SELECT.data.primkeyColumn[p]
												+ "' id='"+ SELECT.data.primkeyColumn[p]+ "'/>");
									}	
									else{
										$ipt = $("<input/>").attr("type","hidden")
										.attr("name","paramMap."+SELECT.data.primkeyColumn[p])
										.attr("id",SELECT.data.primkeyColumn[p]);
									}	
									$(this).append($ipt);
			        			}
			        		}
			        	}
					}).append(
			        	$("<a></a>").attr("id","jq_selectValue").addClass("jq_selectValue").attr("href","#")
			        ).append($rootul);	
		$(".jq_selectValue",$wrapHtml).text($("#"+SELECT.data.textElementID).val());
		//document.write($wrapHtml.html())
		//alert($wrapHtml.html())
		/*添加效果*/
		$( $wrapHtml, _parent).hover(function(){
			$(this).addClass("jq_selectBoxHover");
		},function(){
			$(this).removeClass("jq_selectBoxHover");
		});	
		//传递默认值给primkeyColumn
		if(selectedData != null){
			for(var p=0; p<SELECT.data.primkeyColumn.length;p++){
				$wrapHtml.find("#"+SELECT.data.primkeyColumn[p]).val(eval(selectedData+"."+SELECT.data.primkeyColumn[p]));
			}
		}
        return $wrapHtml;
	};
	
	//递归取数据并画ul li
	SELECT.recursive = function(pval)
	{
		var $ul = '';
		$.each(SELECT.data.selectData,function(i){
			var tscolVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.selectShowColumn);
			var cindexVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.childNodeColumn);
			var pindexVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.parentNodeColumn);
			if (!tscolVal){
				tscolVal = SELECT.data.selectShowColumn;
			}
			if (pval == pindexVal){
				nodeCnt++;
				if ($ul == ''){
					$ul = $("<ul></ul>");
				}
				$ul.append(
					$("<li></li>").append(
						$("<div></div>").append(
							$("<a></a>").attr("href","#").append(tscolVal).attr("id","hidden_"+nodeCnt)
							.append(function(){
								var $input = '';
								var allVal = cindexVal + "##" + tscolVal;
					        	if (SELECT.data.primkeyColumn){
					        		for(var p=0; p<SELECT.data.primkeyColumn.length;p++){
					        			if (SELECT.data.primkeyColumn[p] 
					        			   && SELECT.data.childNodeColumn != SELECT.data.primkeyColumn[p]){
					        				var otherVal = eval("SELECT.data.selectData["+i+"]."+SELECT.data.primkeyColumn[p]);
					        				if (otherVal){
					        					allVal+="##"+otherVal;
					        				}
					        			}
					        		}
					        	}			        					
								var boo = $.browser.msie? $.browser.msie : false;
								if (boo){
									$input = $("<input type='hidden'"
				            				+ " name='allVal' id='allVal' value='"
											+ allVal + "'>");
								}	
								else{
									$input = $("<input/>").attr("type","hidden")
									.attr("name","allVal")
									.attr("id","allVal")
									.attr("value",allVal);
								}	
								return $input;
							})							
						)
					).append(function(){
						return SELECT.recursive(cindexVal);
					}).addClass("jq_selectBoxItem")
				);
			}
		});		
		return $ul;
	};
	
	//设置样式
	SELECT.selectCss = function($ul)
	{
		var settings={
			collapse: true,
			line: true,
			nodeEvent: true,
			unique: false,
			style: 'gray',
			animate: 100,
			fileico: true,
			folderico: true
		};
		$ul.addClass('jq_selectMenu');
		//是否启用连节线
		if(!settings.line) $ul.addClass('jq_selectMenu-noline');
		//是否设置了风格
		if(settings.style) $ul.addClass('jq_selectMenu-'+settings.style);
		//取节点
		var node=$('li:has(ul,ol)',$ul);
		//设置结尾的分枝
		$('li:last-child',$ul).addClass('branch-last');
		if(settings.collapse) {	//允许伸缩
			//设置带图标的li的连节线
			node.addClass('node-normal').filter(':last-child').attr('class','node-last');
			//默认文件图标支持
			if(settings.fileico) 
				$('li:not(:has(ul,ol))>:first-child',$ul).addClass('jq_selectMenu-file');
			//默认文件夹图标支持
			if(settings.folderico) 
				$('>:first-child',node).addClass('jq_selectMenu-folder');
			//在节点中加入默认加减
			node.css('cursor','pointer')
				.prepend('<span class="flex-ico"></span>')
				.find('>ul,>ol').filter(':hidden')
				.parent().find('>.flex-ico').addClass('flex-open');
			$('>.flex-ico',node.filter(':last-child'))
				.addClass('flex-none');
			$('>ul,>ol',node.filter(':last-child'))
			    .filter(':hidden').parent()
			    .addClass('node-last-open');
			node.find('>ul,>ol')
			    .filter(':hidden').parent()
			    .find('>.jq_selectMenu-folder')
			    .addClass('jq_selectMenu-folder');
		}
	};
	
	//绑定鼠标事件
	SELECT.bindEvent = function($select)
	{
		$(".jq_selectValue",$select).click(function(){
			//$(this).blur();	
			if( $(".jq_selectMenu",$select).is(":hidden") ){
				if(SELECT.options.animated){
					$(".jq_selectMenu").slideUp("fast");
					$(".jq_selectMenu",$select).slideDown("fast");
				}else{
					$(".jq_selectMenu").hide();
					$(".jq_selectMenu",$select).show();
				}
			}
			return false;
		});
		
		$("li a",$select).click(function(){
			$("#"+SELECT.data.valElementID).focus();
			$(this).blur();
			var tmphid = $(this).attr("id");
			$("input",$(this)).each(function(){
				var tmpVal = $(this).val();
				var tmpArr = tmpVal.split("##");
				$("#"+SELECT.data.valElementID).val(tmpArr[0]);
				$("#"+SELECT.data.textElementID).val(tmpArr[1]);
				//下拉菜单显示值
				$("#jq_selectValue").text(tmpArr[1]);
				$("#"+SELECT.data.childNodeColumn).val(tmpArr[0]);
			//	alert(tmpArr[0]+ "-----" + tmpArr[1])
				//索引为2 是除了主键值和文本值的其他数值
				var idx = 2;
	        	if (SELECT.data.primkeyColumn && tmpArr.length > 2){
	        		for(var p=0; p<SELECT.data.primkeyColumn.length;p++){
	        			if (SELECT.data.primkeyColumn[p] 
	        			   && SELECT.data.childNodeColumn != SELECT.data.primkeyColumn[p]){
	        				//alert(tmpArr[idx++] + "---"+ SELECT.data.primkeyColumn[p])
	        				$("#"+SELECT.data.primkeyColumn[p]).val(tmpArr[idx++]);
	        			}
	        		}
	        	}				
			});
			
			$("#"+SELECT.data.valElementID).blur();
			$("li a",$select).css("background","#FFFFFF");
			$(this).css("background","#bbb");
			if(SELECT.options.animated){
				$(".jq_selectMenu",$select).slideUp("fast");
			}else{
				$(".jq_selectMenu",$select).hide();
			}
			return false;
		});
		
		$("#jq_selectValue").focus(function(){
			$("#"+SELECT.data.valElementID).focus();
		});

		
		$(document).click(function(event){
			if( $(event.target).attr("class") != "jq_selectBox" ){
				$("#"+SELECT.data.valElementID).blur();
				if(SELECT.options.animated){
					$(".jq_selectMenu",$select).slideUp("fast");
				}else{
					$(".jq_selectMenu",$select).hide();
				}
			}
		});	
		SELECT.attr("display","none");
	};
	
	SELECT.init = function()
	{
		if (SELECT.data.selectData && SELECT.data.selectData.length >0){
			//画下拉列表
			var $select = SELECT.drawSelect();
			//SELECT.html($select);
			//设置样式
			SELECT.selectCss($("#jq_selectMenu"));
			//设置事件
			SELECT.bindEvent($select);			
		}
		else{
			//若为ajax请求，url不能为空或空格
			if (!SELECT.ajax.url)
			{
				alert("SELECT.data.ajax.url is not null");
				return false;
			}
			SELECT.ajax.data = SELECT.data.ajax.data;				
			//目前只支持json格式，若需要xml格式可在进行开发
			$.ajax(SELECT.ajax);			
		}
	};
	
	SELECT.init();
}