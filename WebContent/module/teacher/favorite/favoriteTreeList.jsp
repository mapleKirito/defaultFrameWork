<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title></title>
<head>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.dynamic.grid.tree.css">
<script src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>

<script type="text/javascript">
var gridtb;
$(document).ready(function(){	
	var ujdata = {
			//表单ID
			formID:'actionForm',			
			globalParam:$("#actionForm").formSerialize(),
		    //first,last
	    	checkbox:{name:'',type:'first',width:'5%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'25%',
		    	event:[
		    			//{operate:'preview',name:'${pmsIndex.my_favorite_preview.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_preview}',param:'favorite_'},
						{operate:'del',name:'${pmsIndex.my_favorite_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.my_favorite_delete}',param:'code=${pmsIndex.my_favorite_delete.code}'}
				]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['rfSort','rfName','rfResType','rfCreateTime'],
				//列表头显示名称
				columnName:   ['科室名称','资源名称','资源类型','创建时间'],
				//列表头宽度
				columnWidth:   ['15%','20%','15%','20%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["rfId","rfSortName","rfResourceURL"],
				//为ujoption中rfResourceURL替换值做准备
				resurlColumn:["rfResourceURL"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'rfName',url:'decorateForwardAction.action',param:'ResUrl'}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${pmsIndex.my_favorite_mgr.code}'
		    },
		    //是否有分页工具条
		    isPagination:'true',	    
	    	paginationData:{
				pageSize:'6'
	    	}
		};
		var ujoption = {
			autoclose: true,
			columnAlias:function(col,val){
				
				return val;
			},
			columnCode_:function(col,val){
				if(col == 'code_') {
					if (val == '1011') { 
						val = "003011009"; 
					}
				}
				return val;
			},
			extendDrawShortcut:function(key){
				return '';
			}
		};
	    $('#grid').gridTB(ujdata,ujoption);
	    $("#search_favorite").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.my_favorite_search.code}&type=1'
                 }
            })
            $('#grid').gridTB(ujdata,ujoption);
         });
	    $('#delete_dictionary').screenTB({
	    	windowDocument:window.parent.parent.document,
			width:'250',
			height:'150',
			content:'测试内容',
			contentAlign:'center',
			contentValign:'middle',
			title:'系统提示信息',
			buttonValueYes:'确定',	
			buttonValueNo:'取消',	
			dialogType:'alert',
			iframeSrc:''			
			},{
			clickEvent:function(data){
				if ($("#grid tbody input[type='checkbox']:checked").size() == 0){
					$.extend(data,{returnValue:'true'})
	   				alert("请选择您要删除的参数记录！");
					//data = $.extend(data,{content:'请选择您要删除的记录！'})
				}
				else{
					$.extend(data,{returnValue:'true'})
					var faction = $("#actionForm").attr("action");
					$("#actionForm").attr("action",faction +"?code=${pmsIndex.my_favorite_delete.code}");
					$("#actionForm").submit();   
				}
			}
		});
	    
	    $("#rfResTypeName").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.my_favorite_search.code}&type=1'
                 }
            })
            $('#grid').gridTB(ujdata,ujoption);
        });
	    
	    $("#rfSortName").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.my_favorite_search.code}&type=1'
                 }
            })
            $('#grid').gridTB(ujdata,ujoption);
        });
});
</script>
<style type="text/css">
html,body{overflow: hidden;}
</style>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
   <tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr >
				<td align="left">
					<div class="lt-command">
	 					<s:if test="pmsIndex.my_favorite_delete">
	 						<a id="delete_dictionary" href="javascript:void(0)">
					 			<span>${pmsIndex.my_favorite_delete.name}×</span>
					 		</a>
					 	</s:if>
					 	<div style="float: right;margin-right: 15px;">
						 	<span>资源名称</span>：
							<input type="text" name="searchMap.rfName" value="${paramMap.rfName}" id="rfName" style="width: 200px;" />
							<s:if test="pmsIndex.my_favorite_search">
								<a href="javascript:void(0)" id="search_favorite"><span>${pmsIndex.my_favorite_search.name}</span></a>
							</s:if>	
						</div>
					 	<div style="float: right;margin-right: 15px;">
						 	<span>科室名称</span>：
				 			<select name="searchMap.rfSortName" id="rfSortName">
								<option value="">----请选择科室名称----</option>
								<option value="exhibition" ${paramMap.rfSort eq 'exhibition' ? 'selected':'' }>文物博览室</option>
								<option value="observation" ${paramMap.rfSort eq 'observation' ? 'selected':'' }>专题研读室</option>
								<option value="laboratory" ${paramMap.rfSort eq 'laboratory' ? 'selected':'' }>教学研究室</option>
								<option value="projection" ${paramMap.rfSort eq 'projection' ? 'selected':'' }>影像资料室</option>
								
							</select>	
						</div>
						<div style="float: right;margin-right: 15px;">
						 	<span>资源类型</span>：
				 			<select name="paramMap.rfResTypeName" id="rfResTypeName">
								<option value="">----请选择资源类型----</option>
								<option value="1011">高清图片</option>
								<option value="1073">音频</option>
								<option value="1084">高清视频</option>
								<option value="4033">RAR/ZIP</option>
								<option value="2033">WORD课件</option>
								<option value="2041">PPT课件</option>
								<option value="2055">PDF课件</option>
							</select>
						</div>
					</div>
				</td>
				</tr>
		  	</table> 
		  </div>     
       </td>
   </tr>
   <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine" style="background-color: #E7E7E7">
                <tr>
                    <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid"></div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>