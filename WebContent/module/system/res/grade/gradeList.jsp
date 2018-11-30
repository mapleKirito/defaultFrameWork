<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
    <%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
    %>
    <title></title>
    <head>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	

	var ujdata = {
			//表单ID
			formID:'actionForm',			
			globalParam:$("#actionForm").formSerialize(),
		    //first,last
	    	checkbox:{name:'',type:'first',width:'8%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'20%',
		    	event:[
	    			{operate:'modify',name:'${pmsIndex.res_grade_relationship_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.res_grade_relationship_modify}',param:'code=${pmsIndex.res_grade_relationship_modify.code}'}
	    			//{operate:'detail',name:'${pmsIndex.res_grade_relationship_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.res_grade_relationship_detail}',param:'code=${pmsIndex.res_grade_relationship_detail.code}'}
       				//{operate:'del',name:'${pmsIndex.res_grade_relationship_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.res_grade_relationship_delete}',param:'code=${pmsIndex.res_grade_relationship_delete.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['grName','grResourceType','grGrade','grOperateTime'],
				//列表头显示名称
				columnName:   ['资源名称','资源类别','所属适用学段、年级','修改日期'],
				//列表头宽度
				columnWidth:   ['17%','17%','17%','17%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["grID"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'',url:'',param:''}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${pmsIndex.res_grade_relationship_search.code}'
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
				if(col == 'grResourceType') {
					if (val == 'exhibition') { 
						val = "文物博览室"; 
					}else if (val == 'observation') {
						val = "专题研读室";
					}else if (val == 'laboratory') {
						val = "教学研究室";
					}else if (val == 'projection') {
						val = "影像资料室";
					}else if (val == 'expand') {
						val = "自主探究室";
					}
				}
				if(col == 'grGrade') {
					if (val == '11') { 
						val = "小学一年级"; 
					}else if (val == '12') {
						val = "小学二年级";
					}else if (val == '13') {
						val = "小学三年级";
					}else if (val == '14') {
						val = "小学四年级";
					}else if (val == '15') {
						val = "小学五年级";
					}else if (val == '16') {
						val = "小学六年级";
					}else if (val == '21') {
						val = "七年级";
					}else if (val == '22') {
						val = "八年级";
					}else if (val == '31') {
						val = "必修一";
					}else if (val == '32') {
						val = "必修二";
					}else if (val == '33') {
						val = "必修三";
					}
				}				
				return val;
			},
			extendDrawShortcut:function(key){
				return '';
			}
		};
	    $('#grid').gridTB(ujdata,ujoption);
        $("#search_res").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.res_grade_relationship_search.code}&type=1'
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
    				data = $.extend(data,{content:'请选择您要删除的记录！'})
    			}
    			else{
    				$.extend(data,{returnValue:'true'})
    				var faction = $("#actionForm").attr("action");
    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.res_grade_relationship_delete.code}");
    				$("#actionForm").submit();   
    			}
    		}
    	});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
   <tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;   background-repeat:repeat;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="SkyTableLine">
				<tr>
				<td align="right">
		       		名称：
						<input type="text" name="searchMap.grName" value="${paramMap.grName}" id="grName" style="width: 200px;" />
						&nbsp;&nbsp;
						<s:if test="pmsIndex.res_grade_relationship_search">
							<a href="javascript:void(0)" id="search_res"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="absmiddle" width="14" border="0" height="14">${pmsIndex.res_grade_relationship_search.name}</a>
						</s:if>
				</td>
				</tr>
		  	</table> 
		  </div>     
       </td>
   </tr>
   
   
    <tr>
        <td class="tableCcenter">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine">
                <tr>
                    <td valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid"></div>&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</HTML>
