<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_gouwuche.css" type="text/css" />
 <script type="text/javascript" src="../resources/home/js/jquery.goodnums.js" ></script>
 <script type="text/javascript" src="../resources/home/js/shop_gouwuche.js" ></script>
<div class="shop_gwc_bd clearfix">
		<!-- 在具体实现的时候，根据情况选择其中一种情况 -->
		<!-- 购物车为空 -->
			<c:if test="${empty cartList }">
			<div class="empty_cart mb10">
				<div class="message">
					<p>购物车内暂时没有商品，您可以<a href="../home/index">去首页</a>挑选喜欢的商品</p>
				</div>
			</div>
			</c:if>
		<!-- 购物车为空 end-->
		<c:if test="${not empty cartList }">
		<!-- 购物车有商品 -->
		<div class="shop_gwc_bd_contents clearfix">
			<!-- 购物流程导航 -->
			<div class="shop_gwc_bd_contents_lc clearfix">
				<ul>
					<li class="step_a hover_a">确认购物清单</li>
					<li class="step_b">确认收货人资料及送货方式</li>
					<li class="step_c">购买完成</li>
				</ul>
			</div>
			<!-- 购物流程导航 End -->

			<!-- 购物车列表 -->
			<table style="font-size:12px;">
				<thead>
					<tr>
						<th colspan="2"><span>商品</span></th>
						<th><span>单价(元)</span></th>
						<th><span>数量</span></th>
						<th><span>小计</span></th>
						<th><span>操作</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cartList }" var="cart">
					<tr>
						<td class="gwc_list_pic"><a href="../product/detail?id=${cart.productId }"><img src="${cart.imageUrl }" width="60px" /></a></td>
						<td class="gwc_list_title"><a href="../product/detail?id=${cart.productId }">${cart.name } </a></td>
						<td class="gwc_list_danjia"><span>￥<strong id="danjia_001">${cart.price }</strong></span></td>
						<td class="gwc_list_shuliang">
							<span>
								<a class="good_num_jian" cid="${cart.id }" price="${cart.price }" ty="-" valId="goods_${cart.productId }" href="javascript:void(0);">-</a>
								<input style="width:30px;text-align:center" readonly="readonly" type="text" value="${cart.num }" id="goods_${cart.productId }" class="good_nums" />
								<a href="javascript:void(0);" cid="${cart.id }" price="${cart.price }" ty="+" class="good_num_jia" valId="goods_${cart.productId }">+</a>
							</span>
						</td>
						<td class="gwc_list_xiaoji"><span>￥<strong class="good_xiaojis">${cart.money }</strong></span></td>
						<td class="gwc_list_caozuo"><a href="javascript:void(0);" class="product_favorite" pid="${cart.productId }">收藏</a><a href="javascript:void(0);" class="cart_delete_btn" cid="${cart.id }">删除</a></td>
					</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
							<div class="gwc_foot_zongjia">商品总价(不含运费)<span>￥<strong id="good_zongjia">0.00</strong></span></div>
							<div class="clear"></div>
							<div class="gwc_foot_links">
								<a href="../home/index" class="go">继续购物</a>
								<a href="list_2" class="op">确认并填写订单</a>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
			<!-- 购物车列表 End -->
		</div>
		<!-- 购物车有商品 end -->
		</c:if>
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