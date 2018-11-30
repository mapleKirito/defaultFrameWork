<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
            String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <title></title>
    <head>
	<script type="text/javascript">
	var counter=0;
	var jdata = {
		
		url:'ajaxAction.action',
		
		type:'post',
		
		timeout:'60000',
		
		data:'',
		
		dataType:'json',
		
		complete:function(request,textStatus){},
		
		success:function(jsonData,textStatus){
		}
	};
	$(document).ready(function(){
		$('#paramTable .opt_delete').each(function(){
			$(this).bind("click",clearTDContent);
		});
		$('#paramTable .opt_create').each(function(i){
			$(this).bind("click",addTDContent);
		});		
		var index = 1;
		var html = $("#globalParamHTML").clone(false).html();
		$("#globalParamHTML a").bind("click",function(){
			var $jhtml = $("<div>"+html+"</div>");
			$("table",$jhtml).each(function(){
				$(this).attr("id","table_"+ index);
			});		
			$("img",$jhtml).each(function(){
				var isrc = $(this).attr("src");
				$(this).attr("src","images/common/109.gif");
			});		
			$("span",$jhtml).each(function(){
				var iptid = $(this).attr("id");
				iptid = iptid.replace("Tip","_"+index+"Tip");
				$(this).attr("id",iptid);
			});
			$("input",$jhtml).each(function(){
				var iptid = $(this).attr("id");
				$(this).attr("id",iptid +"_"+index);
			});	
			$("select",$jhtml).each(function(){
				var iptid = $(this).attr("id");
				$(this).attr("id",iptid +"_"+index);
			});				
			$("a",$jhtml).each(function(){
				$(this).attr("id","_"+index);
				$(this).click(function(){
					var aid = $(this).attr("id");
					$("#table"+aid).remove();
				})
			});			
			$("#globalParamHTML").prepend($jhtml);
			$("input","#globalParamHTML").each(function(){
				var iptid = $(this).attr("id");
				if (iptid.indexOf("_") > -1 && iptid.indexOf("paraName") > -1){
					$("#"+iptid).formValidator({onshow:"请输入参数名称",onfocus:"请选择频道状态",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"频道状态不能为空,请确认"});
				}
				if (iptid.indexOf("_") > -1 && iptid.indexOf("parValue") > -1){
					$("#"+iptid).formValidator({onshow:"请输入参数值",onfocus:"请输入频道名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"频道名称不能为空,请确认"});
				}					
			});					
			index++;
		});	
			
		$("a","#setGlobalParamHTML").each(function(){
			$(this).click(function(){
				var did = $(this).attr("id");
				$("#paramTable_"+did).remove();
			});
		});

		$("#actionForm").bind("submit",function(){
			var paramName = $("input[id^=paraName]");
			var paramValue = $("input[id^=parValue]");
			var paramDesc = $("input[id^=parDesc]");
			var $tempParamArr=",";
			for ( var i = 0; i < paramName.size()-1; i++) {
				//参数名称和数值不能为空
				var pName = $.trim(paramName[i].value);
				var pValue = $.trim(paramValue[i].value);
				if(pName== ""){
					alert("请填写参数名称!");
					return false;
				}
				if(pValue== ""){
					alert("请填写参数值!");
					return false;
				}
				//参数名称不能为空
				if($tempParamArr.split(","+pName+",").length <= 1){
					$tempParamArr += pName+",";
				}else{
					alert("参数名称不能相同!");
					return false;
				}
			}
			return true;
		});
	});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" >
<input type="hidden" name="code" id="code" value="${pmsIndex.config_global_param_create.code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.config_global_param.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
<tr>
<td class="tableCcenter">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
        <tr>
            <td class="SkyTDLine">
                <table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="95%" border="0" align="center">
                    <tr class="MeNewTDLine" align="center">
                        <td align="center">
                            <table class="Ntable" id="paramTable" cellSpacing="1" cellPadding="0" width="100%" border="0">
                                <tr class="MeNewTDLine">
                                    <td align="center" class="SkyTDLine" width="30%"><b>参数名称</b></td>
                                    <td align="center" class="SkyTDLine" width="30%"><b>参数值</b></td>
									<td align="center" class="SkyTDLine" width="30%"><b>参数描述</b></td>
									<td align="center" class="SkyTDLine" width="10%"><b>操作</b></td>
                                </tr>
                              </table> 
                            <div id="setGlobalParamHTML">
							<s:iterator value="initMap.paramInfo" id="paramList" status="ind">
								<table class="Ntable" id="paramTable_${paramList.parID}" cellSpacing="1" cellPadding="0" width="100%" border="0">  
									<tr class="MeNewTDLine">
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text" name="paramMap.parName" id="paraName" value="${paramList.parName}" style="width:250">
										</td>
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text"  name="paramMap.parValue" id="parValue" value="${paramList.parValue}" style="width:250">
										</td>
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text" name="paramMap.parDesc" id="parDesc" class='descClass' value="${paramList.parDesc}" style="width:250">
										</td>
										<td class="SkyTDLine" width="10%" align="center">
											<a href="javascript:void(0)" id="${paramList.parID}"><img src="images/common/109.gif" width="16" border="0" height="16"></img></a>
										</td>
									</tr>
								</table>
						     </s:iterator>
							</div>
							<div id="globalParamHTML">
								<table class="Ntable" id="paramTable" cellSpacing="1" cellPadding="0" width="100%" border="0">
									<tr class="MeNewTDLine">
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text" name="paramMap.parName" id="paraName" style="width:250">
										</td>
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text" name="paramMap.parValue" id="parValue" style="width:250">
										</td>
										<td class="SkyTDLine" width="30%" align="center">
											<input type="text" name="paramMap.parDesc" id="parDesc" style="width:250">
										</td>
										<td class="SkyTDLine" width="10%" align="center">
										 <a href="javascript:void(0)"><img src="images/common/004.gif" border="0" height="16" width="16"/></a>
										</td>
									</tr>	
					              </table>
							</div>
                          </td>
                      </tr>
					<tr class="MeNewTDLine" align="center">
						<td colSpan="2" class="SkyTDLine" height="20">
					      <input type="submit" name="BtnOk" value="保存" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="dis();" />
						</td>
					</tr>
                  </table>
              </td>
          </tr>
      </table>
  </td>
</tr>
</table>
</form>
</body>
</html>
