<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_manager.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_shdz_835.css" type="text/css" />
<style>
.add_address_btn {
    background: none repeat scroll 0 0 #FE8502;
    border: 1px solid #FF6633;
    border-radius: 5px 5px 5px 5px;
    color: #FFFFFF !important;
    display: inline-block;
    font-size: 14px;
    font-weight: 600;
    height: 24px;
    line-height: 24px;
    padding: 4px 12px;
}
</style>
<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<%@include file="../common/user_menu.jsp"%>
		
		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">
			
			<div class="shop_meber_bd_good_lists clearfix">
				<div class="title"><h3>管理收货地址<a style="float:right;" href="javasrcipt:void(0);" id="new_add_shdz_btn">新增收货地址</a></h3></div>
				<div class="clear"></div>
			<!-- 收货人地址 Title End -->
			<div class="shop_bd_shdz clearfix">
				<div class="shop_bd_shdz_lists clearfix">
					<ul>
						<c:forEach items="${addressList }" var="address">
						<li>
							<label><span><input type="radio" name="address" value="${address.id }" /></span></label>
							<em>${address.address }</em><em>${address.name }(收)</em><em>${address.phone }</em>
							<span class="admin_shdz_btn">
								<a href="javascript:void(0)" class="edit-btn" data-id="${address.id }" data-name="${address.name }" data-phone="${address.phone }" data-address="${address.address }">编辑</a>
								<a href="javascript:void(0)" class="del-btn" data-id="${address.id }">删除</a>
							</span>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- 新增收货地址 -->
				<div id="new_add_shdz_contents" style="display:none;" class="shop_bd_shdz_new clearfix">
					<div class="title">新增收货地址</div>
					<div class="shdz_new_form">
						<form>
							<input type="hidden" id="edit-id">
							<ul>
								<li><label for=""><span>*</span>收货人姓名：</label><input type="text" class="name" id="name" /></li>
								<li><label for=""><span>*</span>详细地址：</label><input type="text" class="xiangxi" id="address" /></li>
								<li><label for=""><span></span>手机号：</label><input type="text" class="shouji" id="phone" /></li>
								<li><label for="">&nbsp;</label><a href="javascript:void(0)" class="add_address_btn" id="add_address_btn">增加地址</a></li>
							</ul>
						</from>
					</div>
				</div>
				<!-- 新增收货地址 End -->
				<!-- 编辑收货地址 -->
				<div id="new_edit_shdz_contents" style="display:none;" class="shop_bd_shdz_new clearfix">
					<div class="title">新增收货地址</div>
					<div class="shdz_new_form">
						<form>
							<ul>
								<li><label for=""><span>*</span>收货人姓名：</label><input type="text" class="name" id="edit-name" /></li>
								<li><label for=""><span>*</span>详细地址：</label><input type="text" class="xiangxi" id="edit-address" /></li>
								<li><label for=""><span></span>手机号：</label><input type="text" class="shouji" id="edit-phone" /></li>
								<li><label for="">&nbsp;</label><a href="javascript:void(0)" class="add_address_btn" id="edit_address_btn">编辑地址</a></li>
							</ul>
						</from>
					</div>
				</div>
				<!-- 编辑收货地址 End -->
			</div>
			<div class="clear"></div>
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
jQuery(function(){
	jQuery("#new_add_shdz_btn").toggle(function(){
		jQuery("#new_add_shdz_contents").show(500);
	},function(){
		jQuery("#new_add_shdz_contents").hide(500);
	});
});
	$(document).ready(function(){
		$(".del-btn").click(function(){
			var $this = $(this);
			if(confirm("确定删除?")){
				$.ajax({
					url:'delete',
					type:'POST',
					data:{id:$this.attr('data-id')},
					dataType:'json',
					async:false,
					success:function(data){
						if(data.type == 'success'){
							window.location.reload();
						}else{
							alert(data.msg);
						}
					}
				});
			}
		});
		$(".edit-btn").click(function(){
			var $this = $(this);
			if($("#new_edit_shdz_contents").css('display') == 'none'){
				$("#edit-id").val($this.attr("data-id"));
				$("#edit-name").val($this.attr("data-name"));
				$("#edit-address").val($this.attr("data-address"));
				$("#edit-phone").val($this.attr("data-phone"));
				jQuery("#new_edit_shdz_contents").show(500);
			}else{
				jQuery("#new_edit_shdz_contents").hide(500);
			}
		})
		//新增收货地址
		$("#add_address_btn").click(function(){
			var name = $("#name").val();
			var address = $("#address").val();
			var phone = $("#phone").val();
			if(name == '' || address == '' || phone == ''){
				alert('请填写完整信息!');
				return;
			}
			$.ajax({
				url:'../address/add',
				type:'POST',
				data:{name:name,address:address,phone:phone},
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						alert('添加成功!');
						window.location.reload();
					}else{
						alert(data.msg);
					}
				}
			});
		});
		//编辑收货地址
		$("#edit_address_btn").click(function(){
			var id = $("#edit-id").val();
			var name = $("#edit-name").val();
			var address = $("#edit-address").val();
			var phone = $("#edit-phone").val();
			if(name == '' || address == '' || phone == ''){
				alert('请填写完整信息!');
				return;
			}
			$.ajax({
				url:'../address/edit',
				type:'POST',
				data:{id:id,name:name,address:address,phone:phone},
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						alert('编辑成功!');
						window.location.reload();
					}else{
						alert(data.msg);
					}
				}
			});
		});
	});
	
</script>
</html>