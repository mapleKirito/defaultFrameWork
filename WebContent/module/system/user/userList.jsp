<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
            String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.dynamic.grid.tree.js" type="text/javascript"></script>
<script type="text/javascript">
var gridtb;
$(document).ready(function(){	
	   
	var ujdata = {
			//表单ID
			formID:'actionForm',
		    globalParam:$("#actionForm").formSerialize(),
		    //type ：first,last
		    //order ：a(升序),d(降序)
	    	//serialno:{name:'编号',type:'first',width:'10%',order:'a'},			    
		    //first,last
	    	checkbox:{name:'',type:'first',width:'5%'},
	    	shortcut:{
	    		name:'操作',
		    	url:'decorateForwardAction.action',
		    	width:'35%',
		    	event:[
	    			{operate:'modify',name:'${pmsIndex.sys_user_modify.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_user_modify}',param:'code=${pmsIndex.sys_user_modify.code}'},
       				{operate:'del',name:'${pmsIndex.sys_user_delete.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_user_delete}',param:'code=${pmsIndex.sys_user_delete.code}'},
       				{operate:'detail',name:'${pmsIndex.sys_user_detail.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_user_detail}',param:'code=${pmsIndex.sys_user_detail.code}'},
       				{operate:'password',name:'${pmsIndex.sys_user_modify_pwd.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_user_modify_pwd}',param:'code=${pmsIndex.sys_user_modify_pwd.code}'},
       				{operate:'bind',name:'${pmsIndex.sys_user_bind.name}',disabled:'false',isvalid:'${!empty pmsIndex.sys_user_bind}',param:'code=${pmsIndex.sys_user_bind.code}'}
		        ]
		    },
	    	columnDesc:{
		    	//列表要显示的列（在json中对应的key）
				showColumn: ['userName','userAccount','userType','urmUserID'],
				//列表头显示名称
				columnName:   ['用户姓名','用户账号','用户类型','角色绑定'],
				//列表头宽度
				columnWidth:   ['15%','20%','15%','10%'],
				//可以作为主键的类，在页面传送的过程中为paramMap.orgID=value的形式
				//多个主键的时候为["orgID","orgCode"]:paramMap.orgID=value&paramMap.orgCode=value
				primkeyColumn:["userID","userType"],
				//要增加链接的列，可以为多个
				linkColumn:[{name:'',url:'',param:''}]
	    	},		
	    	ajax:{
	        	url:'ajaxAction.action',
	        	data:'code=${code}'
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
				if(col == 'userGender')
				{
					if (val == '1')
						val = "男";
					else if (val == '0')
						val =  "女";
				}
				if(col == 'userType')
				{
					if (val == '2')
						val = "学生";
					else if (val == '1')
						val =  "教师";
				}	
				
				
				if(col == 'urmUserID')
				{
					if (val==' -- '||val==' 无 ')
						val = "<font color='red'>未绑定角色</font>";
					else
						val = "<font color='green'>已绑定角色</font>";
				}	
				
				return val;
			},
			extendDrawShortcut:function(key){
				return '';
			}
		};
	    $('#grid').gridTB(ujdata,ujoption);
        $("#search_user").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.sys_user_search.code}&type=1'
                 }
            });
        	$('#grid').gridTB(ujdata,ujoption);
         });

        $("#userType").click(function(){
        	ujdata = $.extend(ujdata,{globalParam:$("#actionForm").formSerialize(),
            ajax:{
                url:'ajaxAction.action',
                data:'code=${pmsIndex.sys_user_search.code}&type=1'
                 }
            });
        	$('#grid').gridTB(ujdata,ujoption);
         });
        
        $('#delete_user').screenTB({
        	windowDocument:window.parent.document,
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
	    				data = $.extend(data,{content:'请选择您要删除的用户！'});
	    			}
	    			else{
	    				$.extend(data,{returnValue:'true'})
	    				var faction = $("#actionForm").attr("action");
	    				$("#actionForm").attr("action",faction +"?code=${pmsIndex.sys_user_delete.code}");
	    				$("#actionForm").submit();		    			
	    			}
    			}
    		});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list-table" >
	<tr>
        <td class="tableCcenter">
        <div style="background:#E8E8E8;    background-repeat:repeat;">
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="SkyTableLine">
				<tr>
				<td>
					<div class="lt-title">${pmsIndex.sys_user_mgr.name}</div>
					<div class="lt-command">
	 					<s:if test="pmsIndex.sys_user_create">
	 						<a href="decorateForwardAction.action?code=${pmsIndex.sys_user_create.code}" class="fade-button" data-old-bg="rgb(124, 109, 91)" style="background-color: rgb(124, 109, 91);">
							 	${pmsIndex.sys_user_create.name}+
						 	</a>
					 	</s:if>
					 	<div style="float: right;margin-right: 15px;">
					 		<span>用户姓名：</span>
							<input type="text" name="searchMap.name" value="${paramMap.name}" id="name" style="width: 150px;" />
							<s:if test="pmsIndex.sys_user_search">
								<a href="javascript:void(0)" id="search_user"><span>${pmsIndex.sys_user_search.name}</span></a>
							</s:if>
					 	</div>
					 	<div style="float: right;margin-right: 15px;">
					 		<span>用户账号：</span>
							<input type="text" name="searchMap.userAccount" value="${paramMap.userAccount}" id="userAccount" style="width: 150px;" />
					 	</div>
					 	<div style="float: right;margin-right: 15px;">
					 		<span>用户类型</span>：
				 			<select name="searchMap.userType" id="userType">
								<option value="">-----用户类型-----</option>
								<option value="3" ${paramMap.userType eq '3' ? 'selected':'' }>管理员</option>
								<option value="1" ${paramMap.userType eq '1' ? 'selected':'' }>老师</option>
								<option value="2" ${paramMap.userType eq '2' ? 'selected':'' }>学生</option>
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
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="SkyTDLine" style="border-collapse: collapse;border: 1px solid #dfdfdf;">
                <tr>
                     <td  valign="top" colspan="6" id="paginationList" class="MeNewTDLine"><div id="grid">  </div></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
</body>
</html>