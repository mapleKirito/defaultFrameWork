// JavaScript Document
// @Author Zcool xuwei0930
(function($){
 var em = [
	{'id':1,'phrase':'[微笑]','url':'1.gif'},
	{'id':2,'phrase':'[撇嘴]','url':'2.gif'},
	{'id':3,'phrase':'[色]','url':'3.gif'},
	{'id':4,'phrase':'[发呆]','url':'4.gif'},
	{'id':5,'phrase':'[得意]','url':'5.gif'},
	{'id':6,'phrase':'[流泪]','url':'6.gif'},
	{'id':7,'phrase':'[害羞]','url':'7.gif'},
	{'id':8,'phrase':'[闭嘴]','url':'8.gif'},
	{'id':9,'phrase':'[睡]','url':'9.gif'},
	{'id':10,'phrase':'[大哭]','url':'10.gif'},
	{'id':11,'phrase':'[尴尬]','url':'11.gif'},
	{'id':12,'phrase':'[发怒]','url':'12.gif'},
	{'id':13,'phrase':'[调皮]','url':'13.gif'},
	{'id':14,'phrase':'[呲牙]','url':'14.gif'},
	{'id':15,'phrase':'[惊讶]','url':'15.gif'},
	{'id':16,'phrase':'[难过]','url':'16.gif'},
	{'id':17,'phrase':'[酷]','url':'17.gif'},
	{'id':18,'phrase':'[冷汗]','url':'18.gif'},
	{'id':19,'phrase':'[抓狂]','url':'19.gif'},
	{'id':20,'phrase':'[吐]','url':'20.gif'},
	{'id':21,'phrase':'[偷笑]','url':'21.gif'},
	{'id':22,'phrase':'[可爱]','url':'22.gif'},
	{'id':23,'phrase':'[白眼]','url':'23.gif'},
	{'id':24,'phrase':'[傲慢]','url':'24.gif'},
	{'id':25,'phrase':'[饥饿]','url':'25.gif'},
	{'id':26,'phrase':'[困]','url':'26.gif'},
	{'id':27,'phrase':'[惊恐]','url':'27.gif'},
	{'id':28,'phrase':'[流汗]','url':'28.gif'},
	{'id':29,'phrase':'[憨笑]','url':'29.gif'},
	{'id':30,'phrase':'[大兵]','url':'30.gif'},
	{'id':31,'phrase':'[奋斗]','url':'31.gif'},
	{'id':32,'phrase':'[咒骂]','url':'32.gif'},
	{'id':33,'phrase':'[疑问]','url':'33.gif'},
	{'id':34,'phrase':'[嘘]','url':'34.gif'},
	{'id':35,'phrase':'[晕]','url':'35.gif'},
	{'id':36,'phrase':'[折磨]','url':'36.gif'},
	{'id':37,'phrase':'[衰]','url':'37.gif'},
	{'id':38,'phrase':'[骷髅]','url':'38.gif'},
	{'id':39,'phrase':'[敲打]','url':'39.gif'},
	{'id':40,'phrase':'[再见]','url':'40.gif'},
	{'id':41,'phrase':'[擦汗]','url':'41.gif'},
	{'id':42,'phrase':'[抠鼻]','url':'42.gif'},
	{'id':43,'phrase':'[鼓掌]','url':'43.gif'},
	{'id':44,'phrase':'[糗大了]','url':'44.gif'},
	{'id':45,'phrase':'[坏笑]','url':'45.gif'},
	{'id':46,'phrase':'[左哼哼]','url':'46.gif'},
	{'id':47,'phrase':'[右哼哼]','url':'47.gif'},
	{'id':48,'phrase':'[哈欠]','url':'48.gif'},
	{'id':49,'phrase':'[鄙视]','url':'49.gif'},
	{'id':50,'phrase':'[委屈]','url':'50.gif'},
	{'id':51,'phrase':'[快哭了]','url':'51.gif'},
	{'id':52,'phrase':'[阴险]','url':'52.gif'},
	{'id':53,'phrase':'[亲亲]','url':'53.gif'},
	{'id':54,'phrase':'[吓]','url':'54.gif'},
	{'id':55,'phrase':'[可怜]','url':'55.gif'},
	{'id':56,'phrase':'[菜刀]','url':'56.gif'},
	{'id':57,'phrase':'[西瓜]','url':'57.gif'},
	{'id':58,'phrase':'[啤酒]','url':'58.gif'},
	{'id':59,'phrase':'[篮球]','url':'59.gif'},
	{'id':60,'phrase':'[乒乓]','url':'60.gif'},
	{'id':61,'phrase':'[咖啡]','url':'61.gif'},
	{'id':62,'phrase':'[饭]','url':'62.gif'},
	{'id':63,'phrase':'[猪头]','url':'63.gif'},
	{'id':64,'phrase':'[玫瑰]','url':'64.gif'},
	{'id':65,'phrase':'[凋谢]','url':'65.gif'},
	{'id':66,'phrase':'[示爱]','url':'66.gif'},
	{'id':67,'phrase':'[爱心]','url':'67.gif'},
	{'id':68,'phrase':'[心碎]','url':'68.gif'},
	{'id':69,'phrase':'[蛋糕]','url':'69.gif'},
	{'id':70,'phrase':'[闪电]','url':'70.gif'},
	{'id':71,'phrase':'[炸弹]','url':'71.gif'},
	{'id':72,'phrase':'[刀]','url':'72.gif'},
	{'id':73,'phrase':'[足球]','url':'73.gif'},
	{'id':74,'phrase':'[瓢虫]','url':'74.gif'},
	{'id':75,'phrase':'[便便]','url':'75.gif'}
];
//显示 文本区域模块
	function ShowText(e){//显示文本框函数
		if($(e).attr('ut')!="3"){
			if($(e).attr('class')=="isay"){                                                                                   //显示表情0
				$(e).hide();
				var isaycontent='<div class="isay_content" type="Say">'
				isaycontent+='<textarea name="" class="isay_textarea" type="Say">我也说一句</textarea><span class="isay_num">0/125</span>'
				isaycontent+='<div><input name="" type="button" value="提交" class="FB_content"/></div>'
				isaycontent+='</div>'
				$(e).after(isaycontent);
			}else if($(e).attr('curkey')=="FirstReply"){                                                                      //显示表情1
				$(e).parents('.User_info').find(".isay").hide();
				var First='<div class="isay_content" type="FirstReply">'
					First+='<textarea name="" class="isay_textarea" type="FirstReply">我也说一句</textarea><span class="isay_num">0/125</span>'
					First+='<div><input name="" type="button" value="提交" class="FB_content"/></div>'
					First+='</div>'
				$(e).parents('.FirstReplyDiv').append(First)
			}else{                                                                                                             //显示表情2
				$(e).parents('.User_info').find(".isay").hide();
				var Second='<div class="isay_content" type="SecondReply">'           
					Second+='<textarea name="" class="isay_textarea" type="SecondReply">我也说一句</textarea><span class="isay_num">0/125</span>'
					Second+='<div><input name="" type="button" value="提交" class="FB_content"/></div>'
					Second+='</div>'
				$(e).parents('.comments_list').append(Second)
			}
		}
		$('.isay_textarea').css("border-color","#235660");
		$('.isay_textarea').focus();
		$('.isay_textarea').val("");
		if($(e).attr('curkey')=="SecondReply"){
			var User=$(e).parents('.SecondReply_list').find("a:first").text()
			$('.isay_textarea').val("@"+User+" ");
		}
		//文字输入提示功能
		 $('.isay_textarea').bind('focus keyup input paste',function(){  //采用几个事件来触发（已增加鼠标粘贴事件）
		 	if($(this).attr("value").length<=125)
			$('.isay_num').html($(this).attr("value").length+"/125")  //获取评论框字符长度并添加到ID="num"元素上 
			else{
			$('.isay_num').html("<font color='#FF0000'>"+ $(this).attr("value").length+"/125</font>")  //获取评论框字符长度并添加到ID="num"元素
			}
		 }); 
		$(".showface").click(function(){
			X=$(this).offset().top;//X坐标
		 	Y=$(this).offset().left-95;//Y坐标
		 	var sw=document.documentElement.clientWidth;
		 	if(sw<Y+390){
		 		Y=sw-390-20;
		 	}
		 	var emotions= em//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
				var imageurl= "/dm/images/review/face/"//表情 路径
				//var facehtml= '<div class="faceDiv" style="left:'+Y+'px;top:'+(X+20)+'px;"><i class="law"></i><ul>'
				var facehtml= '<div class="faceDiv" style="left:'+Y+'px;min-right:10px;top:'+(X+20)+'px;"><i class="law"></i><ul>'
				var txtAreaObj= $('.isay_textarea')//获取TextArea对象
				for(i=0;i<emotions.length;i++) {
					facehtml +='<li text='+emotions[i].phrase+'><img src="'+imageurl+emotions[i].url+'" title="'+emotions[i].phrase+'"/></li>'
				}
					facehtml +="</ul></div>"
				$(".faceDiv").remove();//防止页面出现多个表情插件
				$(document.body).append(facehtml)
				
		})
		$(document).click(function(e){
			var e=e?e:window.event; 
			var tar = e.srcElement||e.target;
			if($(tar).attr('class')=="showface"){                          //点击表情框
				return false;
			}else if($(tar).attr('class')=="faceDiv"){                          //点击表情框
				return false;
			}else if($(tar).parent().parent().attr('class')=="faceDiv"){                          //点击表情框
				return false;
			}else if($(tar).parent().parent().parent().attr('class')=="faceDiv"){
				return false;
			}else{
				$('.faceDiv').remove();
			}
		})
	}
	$(document).click(function (e) {
		var e=e?e:window.event; 
		var tar = e.srcElement||e.target;
		if($(tar).attr('class')=="isay" || $(tar).attr('curkey')=="FirstReply" || $(tar).attr('curkey')=="SecondReply"){//当点击（我也说一句）  或者   点击一级回复   或者  点击 二级回复
			if($('.isay_content').length>0){                          //当文本框已存在
				if($('.isay_textarea').val()==""){
				$('.isay').show();
				$('.faceDiv').remove();           //移除表情
				$('.isay_content').remove();
					ShowText(tar);
				}
				/*else{
					if(window.confirm('你确定要放弃正在编辑的评论吗?')){
					$('.isay').show();
					$('.faceDiv').remove();      //移除表情
					$('.isay_content').remove();
					ShowText(tar);
					}
				}*/
			}else{                                                    //当文本框不存在
				ShowText(tar);
				//控制滚动条保持在最下面
				var scrollTop = $("#revL")[0].scrollHeight;
				$("#revL").animate({scrollTop:scrollTop},1000);
			}
		}else if($(tar).parent().attr('class')=="isay_content"){ //当点击文本框
			$('.isay_textarea').css("border-color","#235660");
			//$('.isay_textarea').focus();
		}else if($(tar).parent().parent().attr('class')=="isay_content" && $(tar).attr('class')!="FB_content"){//当点击div内的内容(条件判断且不等于提交按钮防止冲突)
			$('.isay_textarea').css("border-color","#235660");
		}else if($(tar).parent().parent().parent().attr('class')=="faceDiv"){ //点击表情框
			$('.isay_textarea').css("border-color","#235660");
			var txtAreaObj= $('.isay_textarea')
			var txt = $(tar).parent().attr("text");
			var faceText = txt;
				//txtAreaObj.val(txtAreaObj.val() + faceText);//旧版本添加表情（无用）
				txtAreaObj.setCaret();     
       			txtAreaObj.insertAtCaret(faceText);
				txtAreaObj.focus();                     //文本框获取焦点
				$(".faceDiv").remove();
		}else if($(tar).attr('class')=="FB_content"){                         //点击提交
			var ptype=$("#ptype").val();
			var pid=$("#pid").val();
			var userType=$("#userType").val();
			var replyID=0;
			var txtAreaObj= $(".isay_textarea").val();
			if (txtAreaObj.length>125){                              //判断是否文字超出限制
				cq=txtAreaObj.length-125;
				alert("超出了"+cq+"个字，请删减后重新发表");
			}else if(userType==3||userType==5){
				alert("管理员不可以参与评论");
				$(".isay_textarea").val("");
				$(".isay_content").remove();
				$('.isay').show();
			}
			else{
				
				
				if($(tar).parents('.isay_content').attr('Type')=="Say"){                            //我也说一句 提交                ┐
					var content=$(tar).parents(".User_info").children(".ReviewList");                     //                                  ├   提交按钮触发事件
				}else if($(tar).parents('.isay_content').attr('Type')=="FirstReply"){               //一级回复 提交                ┘
					replyID=$(tar).parents('.FirstReplyDiv').attr("review-ID");
					if($(tar).parents('.FirstReplyDiv').find('.comments_list').length>0){ //                                           |
						var content=$(tar).parents(".FirstReplyDiv").find('.comments_list').find('ul'); //                   |
					}else{                                                 			 //                                                      |
						var content=$(tar).parents(".FirstReplyDiv");          //                                                      |
					}                                                                                      //                                                   |
				}else{                                                                                                    //二级回复 提交                 ┘
					replyID=$(tar).parents('.FirstReplyDiv').attr("review-ID");
					var content=$(tar).parents(".FirstReplyDiv").children('.comments_list').find('ul');
				}
				var regx=/(\[[\u4e00-\u9fa5]*\w*\])/g;//正则查找"[]"格式
				var rs=txtAreaObj.match(regx)
				if(rs!=null){
				for( i = 0; i < rs.length; i++) {
					for( n=0; n< em.length; n++ ){
						if(em[n].phrase == rs[i]){
							var t = "<img src='/dm/images/review/face/"+em[n].url+"' />";
								txtAreaObj = txtAreaObj.replace(rs[i],t);
								break;
							}
						}
					}
				}
				/*//js静态添加
				var now=new Date()
				if($(tar).parents('.isay_content').attr('Type')=="Say"){                         //点击我也说一句
					DH="<li><div class='FirstReplyDiv'><div class='ui_avatar'><a href='javascript:;'><img src='/dm/images/review/50.jpg' width='30'></a></div><div class='FirstReply_list'><a href='javascript:void(0)'>;-，-朦゛</a>："+txtAreaObj+"<div class='comments_op'>"+(now.getMonth()+1)+"月"+(now.getDate()+1)+"日"+now.getHours()+":"+now.getMinutes()+"<a href='javascript:;' curkey='FirstReply'>回复</a></div></div></div></li>"     
				}else if($(tar).parents('.isay_content').attr('Type')=="FirstReply"){           //点击一级回复
					if($(tar).parents('.FirstReplyDiv').find('.comments_list').length>0){                                        //当ul已存在
						DH=""
					}else{
						DH="<div class='comments_list'><ul>"	
					}
					DH+="<li><div class='SecondReplyDiv'><div class='ui_avatar'><a href='javascript:;'><img src='/dm/images/review/50.jpg' width='30'></a></div><div class='SecondReply_list'><a href='javascript:void(0)'>;-，-許゛</a>："+txtAreaObj+"<div class='comments_op'>"+(now.getMonth()+1)+"月"+(now.getDate()+1)+"日"+now.getHours()+":"+now.getMinutes()+"<a href='javascript:;' curkey='SecondReply'>回复</a></div></div></div></li>"
					if($(tar).parents('.comments_list').length>0){                                        //当ul已存在
						DH+=""
					}else{
						DH+="</ul></div>"	
					}
				}else{
					DH="<li><div class='SecondReplyDiv'><div class='ui_avatar'><a href='javascript:;'><img src='/dm/images/review/50.jpg' width='30'></a></div><div class='SecondReply_list'><a href='javascript:void(0)'>;-，-发゛</a>："+txtAreaObj+"<div class='comments_op'>"+(now.getMonth()+1)+"月"+(now.getDate()+1)+"日"+now.getHours()+":"+now.getMinutes()+"<a href='javascript:;' curkey='SecondReply'>回复</a></div></div></div></li>"
						
				}
				content.append(DH);
				//js静态添加
*/				
				var upinfo="userid="+$("#srUserID").val()+"\n"
				+"content="+txtAreaObj+"\n"
				+"replyid="+replyID+"\n"
				+"ptype="+ptype+"\n"
				+"pid="+pid+"\n";
				//alert(txtAreaObj);
				if(txtAreaObj!=""){
					var data = txtAreaObj;
					data = encodeURI(encodeURI(data)); 
					$.ajax({
						url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-600601&paramMap.srUserID=' + $("#srUserID").val()
								+'&paramMap.srContent=' +data
								+'&paramMap.srReplyID=' +replyID
								+'&paramMap.srPtype=' +ptype
								+'&paramMap.srCheck=1'
								+'&paramMap.resURL='+$("#resURL").val()
								+'&paramMap.srPID=' +pid,
						type:	    'post',
						timeout:	'60000',
						data:	Array(),
						dataType:	'json',
						beforeSend:function(request){},
						complete:function(request,textStatus){},
						success:function(jsonData,textStatus){
							if (textStatus == "success"){
								getReviewLast();
							}
						},
						
						error:function(request,textStatus,error){}
					});
					$('.ReviewList').css('height',82*($('.ReviewList .r_c').length));
					//发送完毕关闭文本框
					$(".isay_textarea").val("");
					$(".isay_content").remove();
					$('.isay').show();
				}else{
					alert("不能发送空评论");
				}
			}
		}else{                                                        //当点击外部
			if($('.isay_textarea').val()==""){                       //当没输入内容时
				$('.isay').show();
				$('.faceDiv').remove();              //移除表情
				$('.isay_content').remove();
			}else{
				$('.isay_textarea').removeAttr("style");
			}
		}
    });


 
})($); 