//调用举例
/**
 * 
var treeTB;
$(document).ready(function(){	
	treeTB = $('#tree').treeTB({
		//树是否全部展开true：展开,false:合并
		//若为动态局部加载，isOpen永远为false
		isOpen:'true',				
   	    //是否有checkbox 
   		isInput:'false',
		//可以作为主键的类，在页面传送的过程中为paramMap.key{index}(index是主键个数值)=value的形式
		//多个主键的时候为["roleID","orgCode"]:paramMap.key1=value&paramMap.key2=value
		primkeyColumn:["roleID"],
		//要进行树型显示的列，支持一列
		treeShowColumn:'roleName',
		//树根目录描述名称
		rootName:'根目录',
		//树型菜单，起始根值
		indexStartValue:'0', 
		//描述树形菜单子列
		childColumn:'roleID',
		//描述树形菜单父列
		parentColumn:'roleParentID',	
    	//ajax 获取所有树json格式信息
    	ajax:{
			//ajax请求url
			url:'ajaxAction.action', 
			//ajax请求参数
			data:'code=${code}'
		}
		//json格式树信息
		//若此值存在就不调用ajax获取数据
		//否者调用ajax获取数据
    	//treeData:[
		// {roleID:'11',roleParentID:'0',roleName:'测试11',address:'北京',orgType:'31'}]
	},	 	
	{
		//单击是否展开	
		clickOpen:'false',
		//双击是否展开
		dbclickOpen:'false',
		//鼠标单击事件出发函数
		click:function(param){
		     alert(param)
		}
	});
});
*/
//jquery 动态画树
//data：json格式字段描述，表格内容，分页描述
//opt：     相关操作对外开放配置或扩展
$.fn.treeTB = function(data,opt){
		
		//树类对象
		var TREE = this;
		//记录数的节点个数
		var index = 0;
		//画树所用相关描述数据
		TREE.data = {
				//树是否全部展开true：展开,false:合并
				isOpen:'false',		
				//树是否全部展开true：展开,false:合并
				inputType:'checkbox',					
				//树中是否有checkbox
				isInput:'true',
				//树中是复选框name
				inputName:'paramMap.inputVal',
				//树中是复选框ID
				inputID:'inputVal',				
				//json格式数据里可能的主键列
				primkeyColumn:'',
				//json格式里要在树展示的列，只能为一列
				treeShowColumn:'',
				//根目录名称
				rootName:'',
				//树形菜单启始，根值
				indexStartValue:'0',
				//json格式中描述树节点的子列
				childColumn:'',
				//json格式中描述树节点的父列
				parentColumn:'',
				//是否有子节点，全局加载方式可以指定也可以不指定，
				//若不指定程序会自己根据上下级关系计算
				//动态异步方式由于是分层加载，所以必须指定，否者画出来的树会存在问题
				isChildNodeColumn:'',					
				//ajax请求参数配置
				ajax:Array(),
				//json格式数据
				treeData:Array()
		};		
		//画树相关操作定义
		//主要是外部定义函数的切入
		TREE.option = {		
			//单击是否展开	
			clickOpen:'false',
			//双击是否展开
			dbclickOpen:'false',
			//鼠标单击事件出发函数
			click:true,
			//复选框鼠标单击事件出发函数
			checkboxClick:true,
			//扩展初始化函数
			extendInit:false
		};	
		
		//ajax请求，系统默认配置参数，此参数可以通过外围配置覆盖
		TREE.ajax = {
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
						TREE.data.treeData = jsonData.data;
						//在目标元素内画树
						//alert(TREE.drawTree())
						TREE.html(TREE.drawTree());
						//设置树的样式和事件
						TREE.treeBindEvent();		
					}
				},
				
				error:function(request,textStatus,error){}
		};	
		//树所用所有图标
		TREE.icon = {
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
		//将配置的数据替换，增加到data对象中
		TREE.data = $.extend(TREE.data,data);
		//将配置的数据替换，增加到option对象中
		TREE.option = $.extend(TREE.option,opt);
		//将配置的数据替换，增加到ajax对象中
		TREE.ajax = $.extend(TREE.ajax,TREE.data.ajax);		
		
		//递归画每个节点
		//$treeDiv：存放树结构的div
		//indexDesc:上下级关系描述
		//spaceImg:树内空白或填充图片
		TREE.recursiveDrawTree = function($treeDiv,spaceImg,indexDesc,indexsv){
			
			$.each(TREE.data.treeData,function(i){
				var tscolVal = eval("TREE.data.treeData["+i+"]."+TREE.data.treeShowColumn);
				var cindexVal = eval("TREE.data.treeData["+i+"]."+TREE.data.childColumn);
				var pindexVal = eval("TREE.data.treeData["+i+"]."+TREE.data.parentColumn);
				if (!tscolVal){
					tscolVal = TREE.data.treeShowColumn;
				}				
				//如果json数据的父索引和树开始索引相同
				//开始画树的第一个节点，并按照此方式
				//找到此节点下的所有子节点，直到没有
				//在画第二个节点
				if (indexsv == pindexVal){
					index++;
					//创建节点div
					var $ctreeDiv = $("<div></div>").addClass("_treeNodeDiv").attr("id","DIV_"+indexDesc + "-" + cindexVal);
					$ctreeDiv.append(spaceImg);
					var simg = TREE.icon.L4;
					if (index == TREE.data.treeData.length){
						simg = TREE.icon.empty;
					}	
					//若此节点既有子节点，又是最后一个节点，则前面填充空白图片
					if (TREE.data.treeData[i].isLast == 'true' && TREE.data.treeData[i].isChildNode == 'true'){
						simg = TREE.icon.empty;
					}	
					var tempImg = spaceImg + "<img align='absmiddle' src='"+simg+"' border='0'/>";
					if (spaceImg){
						//树以及节点之后是展开还是合上
						if (TREE.data.isOpen == 'false'){
							$ctreeDiv.css("display","none");
						}
					}	
					var tmpimg1 = '', tmpimg2 = '';		
					//判断树是展开还是合上
					if (TREE.data.isOpen == 'true'){
						//节点类型不通使用不通的图片
						if (TREE.data.treeData[i].isLast == 'true'){
							tmpimg1 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.M2:TREE.icon.L2;
							tmpimg2 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.folderopen:TREE.icon.file;
						}
						else{
							tmpimg1 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.M1:TREE.icon.L1;
							tmpimg2 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.folderopen:TREE.icon.file;							
						}
					}
					else{
						//节点类型不通使用不通的图片
						if (TREE.data.treeData[i].isLast == 'true'){
							tmpimg1 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.P2:TREE.icon.L2;
							tmpimg2 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.folder:TREE.icon.file;
						}
						else{
							tmpimg1 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.P1:TREE.icon.L1;
							tmpimg2 =  TREE.data.treeData[i].isChildNode == 'true' ? TREE.icon.folder:TREE.icon.file;
						}
					}
					//如果isInput为真则增加复选按钮
					var $input = ''; 
					if (TREE.data.isInput == 'true'){
						var boo = $.browser.msie? $.browser.msie : false;
						if (boo){
							var ipthtml = "<input type='"+TREE.data.inputType+"' class='jq_gridCheckbox' ";
							ipthtml += " name='";
							ipthtml += TREE.data.inputName ?TREE.data.inputName:'paramMap.checkboxVal';
							ipthtml += "' id='"; 
							ipthtml += TREE.data.inputID ?TREE.data.inputID:'checkboxVal'; 
							ipthtml += "' value='" + TREE.getPrimkey(i,1) + "'/>";
							$input = $(ipthtml);
						}
						else{
							$input = $("<input/>").attr("type",TREE.data.inputType)
							       .attr("class","jq_gridCheckbox")
							       .attr("name",TREE.data.inputName ?TREE.data.inputName:'paramMap.inputVal')
							       .attr("id",TREE.data.inputID ?TREE.data.inputID:'inputVal')
							       .attr("value",TREE.getPrimkey(i,1))
							       .css("margin","0px");
						}						
					}
					//更具是否有子节点设置不通的样式属性
					var tnei = TREE.data.treeData[i].isChildNode == 'true' ? '_treePNodeEventImg':'_treeCNodeEventImg';
					//将画好的div追加到最外层div中
					$treeDiv.append($ctreeDiv.append($("<img/>")
							 .addClass(tnei)
						     .attr("align","absmiddle")
						     .attr("id","IMG_" +indexDesc + "-" + cindexVal)
                             .attr("border","0")
                             .attr("src",tmpimg1))
                             .append($("<img/>")
                             .attr("align","absmiddle")
                             .attr("id","PIMG_"+indexDesc + "-" + cindexVal)
			                 .attr("border","0")
			                 .addClass("treeNodeImg")
			                 .attr("src",tmpimg2))
			                 .append($input)
			                 .append($("<a></a>")
			                 .attr("href","#")
			                 .addClass("_treeNodeA")
			                 .attr("id","A_"+indexDesc + "-" + cindexVal)
			                 .append(tscolVal)));
					//递归画tree
					TREE.recursiveDrawTree($treeDiv,tempImg,indexDesc + "-" + cindexVal,cindexVal);
				}
			});
		};
		
		
		//计算主键值串
		//type:0： url参数字符串（url get方式传值的字符串），1：参数字符串
		TREE.getPrimkey = function(row,type)
		{
			var rkey = '';
			$.each(TREE.data.primkeyColumn,function(i){
				if (TREE.data.treeData[row]){
					if (eval("TREE.data.treeData["+row+"]")){
						var key = eval("TREE.data.treeData["+row+"]." + this);
						if (i==0){
							if (type == 0){ 
								rkey = "paramMap."+ this + "="+key;
							}
							else{
								rkey = key;
							}
						}
						else{
							if (type == 0){ 
								rkey += "&paramMap."+ this + "="+key;
							}
							else{
								rkey += "#"+key;
							}						
						}				
					}
				}
			});
			return rkey;
		};		
		
		//设置节点状态
		TREE.nodeStatus = function (){			
			//描述树形菜单子列
			var childColumn = TREE.data.childColumn;
			if (!childColumn){
				alert("GRIDTREE.data.childColumn is not null!");
				return false;
			}	
			//描述树形菜单父列
			var parentColumn = TREE.data.parentColumn;
			if (!parentColumn){
				alert("GRIDTREE.data.parentColumn is not null!");
				return false;
			}		
			//树状结构根节点起始值
			var indexStartValue = TREE.data.indexStartValue;
			if (!indexStartValue){
				alert("TREE.data.indexStartValue is not null!");
				return false;
			}			
			var rootLast = -1;
			for(var i=0;i<TREE.data.treeData.length;i++){
				var cindexVal = eval("TREE.data.treeData["+i+"]."+childColumn);
				var pindexVal = eval("TREE.data.treeData["+i+"]."+parentColumn);				
				
				//如果根据字段获取的值不正确，直接返回
				if (!cindexVal && !pindexVal){
					return false;
				}
				if (indexStartValue == pindexVal){
					rootLast = i;
				}
				var temp = -1;
				for(var j=0;j<TREE.data.treeData.length;j++){
					var cval = eval("TREE.data.treeData["+j+"]."+childColumn);
					var pval = eval("TREE.data.treeData["+j+"]."+parentColumn);	
					if (cindexVal == pval){
						temp = j;
					}
				}
				if (temp > -1){
					TREE.data.treeData[i] = $.extend(TREE.data.treeData[i],{isChildNode:'true'});
					TREE.data.treeData[temp] = $.extend(TREE.data.treeData[temp],{isLast:'true'});
				}
			}
			if (rootLast > -1){
				TREE.data.treeData[rootLast] = $.extend(TREE.data.treeData[rootLast],{isLast:'true'});
			}
			return true;
		};		
		
		//画树函数
		TREE.drawTree = function()
		{
			//树最外层div以及树的根节点
			var $treeDiv = $("<div></div>").attr("width","100%").attr("id","_treeDiv").addClass("_treeDiv")
			        .append($("<div></div>").addClass("_treeRootDiv").attr("id","_treeRootDiv")
					.append($("<img />").attr("src",TREE.icon.root).attr("align","absmiddle").attr("border","0").attr("id","_treeRootImg"))
					.append($("<a></a>").attr("href","#").attr("id","_treeRootA").append(TREE.data.rootName)));
			//设置各个节点的状态，是否有子节点，并且判断是否是同一级的最后一个节点
			if (TREE.nodeStatus()){
				TREE.recursiveDrawTree($treeDiv,'',TREE.data.indexStartValue,TREE.data.indexStartValue);
			}
			else{
				alert("config tree data nodeStatus error!");
			}
//			alert($treeDiv.html())
			return $treeDiv.html();
		};
         
		//查找关闭且有子节点的节点
		TREE.closePNode = function(iid)
		{
			return $.makeArray($("._treeNodeDiv ._treePNodeEventImg").filter(function(){
				var imgid = $(this).attr("id");
				var imgsrc = $(this).attr("src");
				if (imgid != iid && imgid.indexOf(iid) > -1){
					if (imgsrc.indexOf(TREE.icon.P1) > -1 || imgsrc.indexOf(TREE.icon.P2) > -1){
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
		TREE.treeNodeEvent = function($img,array)
		{
			var display = '';
			var newimgid = $img.attr("id").replace("IMG","PIMG");
			if ($img.attr("src").indexOf(TREE.icon.M1) > -1){
				$("#"+newimgid).attr("src",TREE.icon.folder);
				$img.attr("src",TREE.icon.P1);
				display = 'none';
			}
			else if ($img.attr("src").indexOf(TREE.icon.P1) > -1){
				$img.attr("src",TREE.icon.M1);
				$("#"+newimgid).attr("src",TREE.icon.folderopen);
				display = 'block';
			}
			else if ($img.attr("src").indexOf(TREE.icon.M2) > -1){
				$img.attr("src",TREE.icon.P2);
				$("#"+newimgid).attr("src",TREE.icon.folder);
				display = 'none';
			}
			else if ($img.attr("src").indexOf(TREE.icon.P2) > -1){
				$("#"+newimgid).attr("src",TREE.icon.folderopen);
				$img.attr("src",TREE.icon.M2);
				display = 'block';
			}	
			
			$("._treeNodeDiv").filter(function(){
				var divid = $(this).attr("id");
				var tempid = $img.attr("id").replace('IMG_','DIV_');
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
						var ctempid = array[i].id.replace('IMG_','DIV_');
						if (divcid != ctempid && divcid.indexOf(ctempid) > -1){
							isexit = true;
							break;
						}
					}
					if (!isexit){
						$(this).css("display",display);
					}
				}
				else{
					$(this).css("display",display);
				}
			});					
		}
		
		
		//设置表格体行的样式，并绑定相关事件
		TREE.treeBindEvent = function()
		{
			//设置树展开收起事件事件
			$("._treeNodeDiv ._treePNodeEventImg").each(function(){
				$(this).bind("click",function(){
					var id = this.id;		
					var $img = $(this);							
					//查找关闭且有子节点的节点
					var array = TREE.closePNode(id);
					//树节点事件
					TREE.treeNodeEvent($img,array);

				});
			});		
			$("._treeNodeDiv").each(function(){
				$(this).find("input").bind("click",function(){
					if (typeof TREE.option.checkboxClick == 'function'){
						TREE.option.checkboxClick($(this));
					}
				});
			});
			//设置树连接单击和双击展开事件
			$("._treeNodeDiv ._treeNodeA").each(function(){
				//单击事件
				$(this).bind("click",function(){
					var aid = this.id;
					//获取对应图标id
					var imgid = aid.replace("A_","IMG_");
					//获取对应图标对象
					var $img = $("#" + imgid);						
					//如果为true，单击展开节点
					if (TREE.option.clickOpen == 'true'){
						//查找关闭且有子节点的节点
						var array = TREE.closePNode(imgid);
						//树节点事件
						TREE.treeNodeEvent($img,array);						
					}
					if (typeof TREE.option.click == 'function'){
						var arr = aid.split("-");
						var param = arr.length > 0 ? arr[arr.length-1]:'';
						TREE.option.click(param);
					}
				});
				//双击事件
				$(this).bind("dblclick",function(){					
					//如果为true，双击展开节点
					if (TREE.option.dbclickOpen == 'true'){
						//查找关闭且有子节点的节点
						var array = TREE.closePNode(imgid);
						//树节点事件
						TREE.treeNodeEvent($img,array);							
					}					
				});				
			});
		};		
		//初始化函数
		TREE.init = function()
		{
			//如果TREE.data.columnData.data得长度小于0，默认调用ajax获取数据画树
			//否者默认按照外围配置的数据，做为画树的数据
			if (TREE.data.treeData && TREE.data.treeData.length <= 0)
			{
				//若为ajax请求，url不能为空或空格
				if (!TREE.ajax.url)
				{
					alert("TREE.data.ajax.url is not null");
					return false;
				}
				TREE.ajax.data = TREE.data.ajax.data;				
				//目前只支持json格式，若需要xml格式可在进行开发
				$.ajax(TREE.ajax);
			}
			else{		
				//在目标元素内画树
				TREE.html(TREE.drawTree());
				//设置树的样式和事件
				TREE.treeBindEvent();
			}
			if (typeof TREE.option.extendInit == 'function'){
				TREE.option.extendInit();
			}			
		};
		//开始初始化
		TREE.init();		
	;
}