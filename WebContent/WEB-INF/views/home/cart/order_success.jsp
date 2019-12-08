<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_gouwuche.css" type="text/css" />
 <script type="text/javascript" src="../resources/home/js/jquery.goodnums.js" ></script>
 <script type="text/javascript" src="../resources/home/js/shop_gouwuche.js" ></script>
<style type="text/css">
		.shop_bd_error{width:1000px; height:50px; padding:100px 0; margin:10px auto 0; border:1px solid #ccc;}
		.shop_bd_error p{height:45px; line-height:45px; width:980px; text-align: center; font-size:14px; font-weight: bold; color:#55556F;}
		.shop_bd_error p span{display:inline-block;width:48px; height:48px; line-height:45px; overflow:hidden; text-indent: 99em; vertical-align:top; padding-right:10px; background:url('../resources/home/images/right.png') no-repeat left top;}
</style>
<div class="shop_gwc_bd clearfix">
		<div class="shop_gwc_bd_contents clearfix">
			<div class="shop_gwc_bd_contents_lc clearfix">
				<ul>
					<li class="step_a ">确认购物清单</li>
					<li class="step_b">确认收货人资料及送货方式</li>
					<li class="step_c hover_c">购买完成</li>
				</ul>
			</div>	
			<div class="shop_bd_error">
					<p><span></span>下单成功！订单编号：${order.sn }，总价：${order.money }</p>
			</div>
		</div>
	</div>
	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
<script>
	$(document).ready(function(){
		//减少商品数量按钮
		$(".good_num_jian").click(function(){
			var num = parseInt($(this).next('input').val());
			num = num -1;
			if(num < 1){
				return;
			}
			if(!updateNum($(this).attr('cid'),-1))return;
			$(this).next('input').val(num);
			var money = parseFloat($(this).attr('price') * num);
			$(this).closest(".gwc_list_shuliang").next(".gwc_list_xiaoji").find(".good_xiaojis").text(money);
			calTotalMoney();
		});
		//添加商品数量按钮
		$(".good_num_jia").click(function(){
			var num = parseInt($(this).prev('input').val());
			num = num + 1;
			if(!updateNum($(this).attr('cid'),1))return;
			$(this).prev('input').val(num);
			var money = parseFloat($(this).attr('price') * num);
			$(this).closest(".gwc_list_shuliang").next(".gwc_list_xiaoji").find(".good_xiaojis").text(money);
			calTotalMoney();
		});
		//删除商品
		$(".cart_delete_btn").click(function(){
			var cid = $(this).attr('cid');
			var $this = $(this);
			if(confirm('确认删除该商品吗？')){
				$.ajax({
					url:'delete',
					type:'POST',
					data:{cartId:cid},
					dataType:'json',
					success:function(data){
						if(data.type == 'success'){
							//alert('添加成功!');
							//window.location.href = 'index';
							$this.closest('tr').hide('1000').remove();
							calTotalMoney();
						}else{
							alert(data.msg);
						}
					}
				});
			}
		});
		//收藏商品
		$(".product_favorite").click(function(){
			var pid = $(this).attr('pid');
			var $this = $(this);
			$.ajax({
				url:'../favorite/add',
				type:'POST',
				data:{productId:pid},
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						alert('收藏成功!');
						//window.location.href = 'index';
					}else{
						alert(data.msg);
					}
				}
			});
		});
		
		calTotalMoney();
	});
	function calTotalMoney(){
		var totalMoney = 0;
		$(".good_xiaojis").each(function(){
			var money = parseFloat($(this).text());
			totalMoney += money;
		});
		$("#good_zongjia").text(totalMoney);
	}
	function updateNum(cartId,num){
		var ret = false;
		$.ajax({
			url:'update_num',
			type:'POST',
			data:{num:num,cartId:cartId},
			dataType:'json',
			async:false,
			success:function(data){
				if(data.type == 'success'){
					//alert('添加成功!');
					//window.location.href = 'index';
					ret = true;
				}else{
					alert(data.msg);
				}
			}
		});
		return ret;
	}
</script>
</html>