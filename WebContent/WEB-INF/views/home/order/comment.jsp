<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_manager.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_form.css" type="text/css" />
<style>
	span.pingjia_type {
	    width: 24px;
	    height: 24px;
	    display: block;
	    margin: 0 auto;
	    background: url(../resources/home/images/credit_smile.png) no-repeat scroll 0 0 transparent;
	    float:left;
	}
	span.pingjia_type_2 {
    	background-position: 0 -30px;
	}
	span.pingjia_type_3 {
	    background-position: 0 -60px;
	}
</style>
<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<%@include file="../common/user_menu.jsp"%>
		
		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">
			
			<div class="shop_meber_bd_good_lists clearfix">
				<div class="title"><h3>商品评价</h3></div>
				<div class="clear"></div>
				<dic class="shop_home_form">
					<form athion="" name="" class="shop_form" method="post">
						<ul>
							<li><label>商品名称：</label>${product.name }</li>
							<li><label>商品价格：</label>${product.price }</li>
							<li><label>评价类型:</label>
								<span class="pingjia_type pingjia_type_1"></span>
								<input style="float:left;margin-top:5px;" type="radio" class="mr5" name="type" value="1" />
								<span style="float:left;margin-right:18px;">好评</span>
								<span class="pingjia_type pingjia_type_2"></span>
								<input style="float:left;margin-top:5px;" type="radio" class="mr5" name="type" value="2" />
								<span style="float:left;margin-right:18px;">中评</span>
								<span class="pingjia_type pingjia_type_3"></span>
								<input style="float:left;margin-top:5px;" type="radio" class="mr5" name="type" value="0" />差评
							</li>
							<li style="height:100px;">
								<label>评价内容：</label>
								<textarea id="content" style="width:300px;height:100px;"></textarea>
							</li>
							<li class="bn"><label>&nbsp;</label><input type="button" onClick="submitComment()" class="form-submit" value="提交评价" /></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
		<!-- 右边购物列表 End -->

	</div>
	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
<script>
	$(document).ready(function(){
		
	});
	function submitComment(){
		var content = $("#content").val();
		var type = $("input[type='radio']:checked").val();
		if(content == ''){
			alert('请填评价内容!');
			return;
		}
		if(type == '' || type == null || type == 'undefined'){
			alert('请选择评价类型!');
			return;
		}
		$.ajax({
			url:'../comment/add',
			type:'POST',
			data:{productId:'${product.id}',content:content,type:type},
			dataType:'json',
			async:false,
			success:function(data){
				if(data.type == 'success'){
					alert('评价成功!');
					window.history.go(-1);
				}else{
					alert(data.msg);
				}
			}
		});
	}
</script>
</html>