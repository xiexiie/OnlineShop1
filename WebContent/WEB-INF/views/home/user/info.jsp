<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_manager.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_form.css" type="text/css" />
<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<%@include file="../common/user_menu.jsp"%>
		
		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">
			
			<div class="shop_meber_bd_good_lists clearfix">
				<div class="title"><h3>基本信息</h3></div>
				<div class="clear"></div>
				<dic class="shop_home_form">
					<form athion="" name="" class="shop_form" method="post">
						<ul>
							<li><label>用户名称：</label>${user.name }</li>
							<li><label>电子邮件：</label><input type="text" id="email" class="email form-text" value="${user.email }" /></li>
							<li><label>真实姓名：</label><input type="text" id="true-name" class="truename form-text" value="${user.trueName }" /></li>
							<li><label>性别:</label>
								<input type="radio" class="mr5" name="sex" value="0" <c:if test="${user.sex == 0 }">checked</c:if> />保密
								<input type="radio" class="ml10 mr5" name="sex" value="1" <c:if test="${user.sex == 1 }">checked</c:if> />男
								<input type="radio" class="ml10 mr5" name="sex" value="2" <c:if test="${user.sex == 2 }">checked</c:if> />女
							</li>
							<li class="bn"><label>&nbsp;</label><input type="button" onClick="editInfo()" class="form-submit" value="保存修改" /></li>
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
	function editInfo(){
		var email = $("#email").val();
		var trueName = $("#true-name").val();
		var sex = $("input[type='radio']:checked").val();
		if(email == ''){
			alert('请填写邮箱!');
			return;
		}
		if(trueName == ''){
			alert('请填写真实姓名!');
			return;
		}
		if(sex == '' || sex == null || sex == 'undefined'){
			alert('请选择性别!');
			return;
		}
		$.ajax({
			url:'update_info',
			type:'POST',
			data:{email:email,trueName:trueName,sex:sex},
			dataType:'json',
			async:false,
			success:function(data){
				if(data.type == 'success'){
					alert('更新成功!');
					//window.location.href = 'index';
				}else{
					alert(data.msg);
				}
			}
		});
	}
</script>
</html>