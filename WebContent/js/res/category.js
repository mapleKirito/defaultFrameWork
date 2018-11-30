var total;
var jie ;
var chor;
var gang;
var order ;
var category ;

function initCategory(resType, total_, jie_, chor_, gang_,order_,category_ ){
	total = total_;
	jie = jie_ ;
	chor = chor_;
	gang = gang_ ;
	order = order_ ;
	category = category_ ;
	changeTotal(resType,jie_) ;
}

function changeTotal(resType,defaultValue){	
	$("#"+resType+"Total").val($("#"+resType+"TotalID").find("option:selected").text()) ;
	$("#"+resType+"JieID").empty();
	$("#"+resType+"Jie").val("") ;
	$("#"+resType+"ChorID").empty();
	$("#"+resType+"Chor").val("") ;
	$("#"+resType+"GangID").empty();
	$("#"+resType+"Gang").val("") ;
	$("#"+resType+"OrderID").empty();
	$("#"+resType+"Order").val("") ;
	$("#"+resType+"Category").empty();
	$("#"+resType+"CategoryName").val("") ;
	
	$("#"+resType+"JieID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"ChorID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"GangID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"OrderID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"Category").append($("<option>").text("--请选择--").val("")) ;
	document.getElementById(""+resType+"JieID").disabled = true ;
	document.getElementById(""+resType+"ChorID").disabled = true ;
	document.getElementById(""+resType+"GangID").disabled = true ;
	document.getElementById(""+resType+"OrderID").disabled = true ;
	document.getElementById(""+resType+"Category").disabled = true ;
	loadChildCategory($("#"+resType+"TotalID").val(), defaultValue, ""+resType+"JieID", "jie", resType) ;
	document.getElementById(""+resType+"JieID").disabled = false ;
	
	if(defaultValue != "") {
		$("#"+resType+"JieID").val(defaultValue) ;
		$("#"+resType+"Jie").val($("#"+resType+"JieID").find("option:selected").text()) ;
	}
}

function changeJie(resType,defaultValue){
	
	$("#"+resType+"Jie").val($("#"+resType+"JieID").find("option:selected").text()) ;
	$("#"+resType+"ChorID").empty();
	$("#"+resType+"Chor").val("") ;
	$("#"+resType+"GangID").empty();
	$("#"+resType+"Gang").val("") ;
	$("#"+resType+"OrderID").empty();
	$("#"+resType+"Order").val("") ;
	$("#"+resType+"Category").empty();
	$("#"+resType+"CategoryName").val("") ;
	
	$("#"+resType+"ChorID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"GangID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"OrderID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"Category").append($("<option>").text("--请选择--").val("")) ;
	
	document.getElementById(""+resType+"ChorID").disabled = true ;
	document.getElementById(""+resType+"GangID").disabled = true ;
	document.getElementById(""+resType+"OrderID").disabled = true ;
	document.getElementById(""+resType+"Category").disabled = true ;
	if($(""+resType+"ChorIDAddcateConcule").length>0){
		document.getElementById(""+resType+"ChorIDAddcateConcule").style.display="none" ;	
	}	
	
	loadChildCategory($("#"+resType+"JieID").val(), defaultValue, ""+resType+"ChorID", "chor", resType) ;
	document.getElementById(""+resType+"ChorID").disabled = false ;
	
	if(defaultValue != "") {
		$("#"+resType+"ChorID").val(defaultValue) ;
		$("#"+resType+"Chor").val($("#"+resType+"ChorID").find("option:selected").text()) ;
		if($("#"+resType+"ChorID").find("option:selected").text()=="--请选择--"){
			$("#"+resType+"Chor").val("");
		}
	}
}

function changeChor(resType,defaultValue){
	
	$("#"+resType+"Chor").val($("#"+resType+"ChorID").find("option:selected").text()) ;
	if($("#"+resType+"ChorID").find("option:selected").text()=="--请选择--"){
		$("#"+resType+"Chor").val("");
	}
	$("#"+resType+"GangID").empty();
	$("#"+resType+"Gang").val("") ;
	$("#"+resType+"OrderID").empty();
	$("#"+resType+"Order").val("") ;
	$("#"+resType+"Category").empty();
	$("#"+resType+"CategoryName").val("") ;
	
	$("#"+resType+"GangID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"OrderID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"Category").append($("<option>").text("--请选择--").val("")) ;

	document.getElementById(""+resType+"GangID").disabled = true ;
	document.getElementById(""+resType+"OrderID").disabled = true ;
	document.getElementById(""+resType+"Category").disabled = true ;

	loadChildCategory($("#"+resType+"ChorID").val(), defaultValue, ""+resType+"GangID", "gang", resType) ;
	document.getElementById(""+resType+"GangID").disabled = false ;
	
	//maple
	/*if($("#"+resType+"ChorIDAddcateConcule").length>0){
		document.getElementById(""+resType+"ChorIDAddcateConcule").style.display="none" ;
		document.getElementById(""+resType+"GangIDAddcateConcule").style.display="none" ;
	}*/
	
	if(defaultValue != "") {
		$("#"+resType+"GangID").val(defaultValue) ;
		$("#"+resType+"Gang").val($("#"+resType+"GangID").find("option:selected").text()) ;
		if($("#"+resType+"GangID").find("option:selected").text()=="--请选择--"){
			$("#"+resType+"Gang").val("");
		}
	}
}


function changeGang(resType,defaultValue){
	$("#"+resType+"Gang").val($("#"+resType+"GangID").find("option:selected").text()) ;
	if($("#"+resType+"GangID").find("option:selected").text()=="--请选择--"){
		$("#"+resType+"Gang").val("");
	}
	$("#"+resType+"OrderID").empty();
	$("#"+resType+"Order").val("") ;
	$("#"+resType+"Category").empty();
	$("#"+resType+"CategoryName").val("") ;

	
	$("#"+resType+"OrderID").append($("<option>").text("--请选择--").val("")) ;
	$("#"+resType+"Category").append($("<option>").text("--请选择--").val("")) ;

	document.getElementById(""+resType+"OrderID").disabled = true ;
	document.getElementById(""+resType+"Category").disabled = true ;

	loadChildCategory($("#"+resType+"GangID").val(), defaultValue, ""+resType+"OrderID", "order", resType) ;

	document.getElementById(""+resType+"OrderID").disabled = false ;
	
	if(defaultValue != "") {
		$("#"+resType+"OrderID").val(defaultValue) ;
		$("#"+resType+"Order").val($("#"+resType+"OrderID").find("option:selected").text()) ;
		if($("#"+resType+"OrderID").find("option:selected").text()=="--请选择--"){
			$("#"+resType+"Order").val("");
		}
	}
}

function changeOrder(resType,defaultValue){
	$("#"+resType+"Order").val($("#"+resType+"OrderID").find("option:selected").text()) ;
	if($("#"+resType+"OrderID").find("option:selected").text()=="--请选择--"){
		$("#"+resType+"Order").val("");
	}
	$("#"+resType+"Category").empty();
	$("#"+resType+"CategoryName").val("") ;
	
	$("#"+resType+"Category").append($("<option>").text("--请选择--").val("")) ;

	document.getElementById(""+resType+"Category").disabled = true ;
	loadChildCategory($("#"+resType+"OrderID").val(), defaultValue, ""+resType+"Category", "category", resType) ;		
	document.getElementById(""+resType+"Category").disabled = false ;
	
	if(defaultValue != "") {
		$("#"+resType+"Category").val(defaultValue) ;
		$("#"+resType+"CategoryName").val($("#"+resType+"Category").find("option:selected").text()) ;
		if($("#"+resType+"Category").find("option:selected").text()=="--请选择--"){
			$("#"+resType+"CategoryName").val("");
		}
	}
}

function changeCategory(resType){
	$("#"+resType+"CategoryName").val($("#"+resType+"Category").find("option:selected").text()) ;
	loadChildCategory($("#"+resType+"Category").val(), "", "") ;
}
function loadChildCategory(pID, defaultID, fieldName, nextRes, resType){
	if(pID != "") {
		$.ajax({
			url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + pID,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				var cateList = new Array();
				if (textStatus == "success"){
					if (jsonData.data){
						jrinitData = jsonData.data;
						for (var i=0; i<jsonData.data.length;i++){
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							var option = $("<option>").text(cateName).val(cateID).attr("catepath",catePath).attr("catelevel",cateLevel);
							$("#" + fieldName).append(option);
						}
	
						if(defaultID != ""){
							$("#" + fieldName).val(defaultID) ;
							
							if(nextRes == "jie") {
								$("#"+resType+"Jie").val($("#"+resType+"JieID").find("option:selected").text()) ;
								changeJie(resType,chor) ;
							}else if(nextRes == "chor") {
								$("#"+resType+"Chor").val($("#"+resType+"ChorID").find("option:selected").text()) ;
								changeChor(resType,gang) ;
		
							}else if(nextRes == "gang") {
								$("#"+resType+"Gang").val($("#"+resType+"GangID").find("option:selected").text()) ;
								changeGang(resType,order) ;
								
							}else if(nextRes == "order") {
								$("#"+resType+"Order").val($("#"+resType+"OrderID").find("option:selected").text()) ;
								changeOrder(resType,category) ;
							}else if(nextRes == "category") {
								$("#"+resType+"CategoryName").val($("#"+resType+"Category").find("option:selected").text()) ;
							}
						}
					} 
				}
			},
			
			error:function(request,textStatus,error){}
		});
	}
}


function prochangeJie(resType,defaultValue){
	
	$("#"+resType+"CategoryName").val($("#"+resType+"Category").find("option:selected").text()) ;
	$("#"+resType+"JieProID").empty();
	$("#"+resType+"JieProName").val("") ;

	$("#"+resType+"JieProID").append($("<option>").text("--请选择--").val("")) ;
	
	document.getElementById(""+resType+"JieProID").disabled = true ;
	loadChildCategory($("#"+resType+"Category").val(), defaultValue, ""+resType+"JieProID", "JieProID", resType) ;
	document.getElementById(""+resType+"JieProID").disabled = false ;
	
	if(defaultValue != "") {
		$("#"+resType+"JieProID").val(defaultValue) ;
		$("#"+resType+"JieProName").val($("#"+resType+"JieProID").find("option:selected").text()) ;
	}
}

function prochangeGang(resType){
	$("#"+resType+"JieProName").val($("#"+resType+"JieProID").find("option:selected").text()) ;
	loadChildCategory($("#"+resType+"JieProID").val(), "", "") ;
}
