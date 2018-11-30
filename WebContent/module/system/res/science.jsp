<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<style type="text/css"> 
#sciencetb tr td { color:#ffffff; }
#sciencetb tr td span  {margin-left: 5px;}
#sciencetb ul { list-style-type: none; margin: 5px; } 
#sciencetb ul li span{margin-right: 5px;} 
#sciencetb tr td{border: none;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#science").change(function(){
		if($(this).val()!=""){ $(".s_1").show(); }else{ $(".s_1").hide(); }
	});
});
</script>
<span>科目：</span>
<select id="science" name="paramMap.science">
	<option value="">----请选择----</option>
	<s:iterator value="initMap.scienceList" id="scicate" status="ind">
		<option value="${scicate.sciID}">${scicate.sciName}</option>
	</s:iterator>
</select>
<span class="s_1" style="display:none;"><span>关键词：</span><input name="paramMap.scienceGuanJianCi" type="text"  id="scienceGuanJianCi" style="width: 150px;" /></span>
<span class="s_1" style="display:none;"><span>关联课时：</span><input name="paramMap.scienceKeShi" type="text"  id="scienceKeShi" style="width: 150px;" /></span>