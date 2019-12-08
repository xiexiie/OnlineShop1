<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_gouwuche.css" type="text/css" />
 <script type="text/javascript" src="../resources/home/js/jquery.goodnums.js" ></script>
 <script type="text/javascript" src="../resources/home/js/shop_gouwuche.js" ></script>
 <style type="text/css">
    .shop_bd_shdz_title{width:1000px; margin-top: 10px; height:50px; line-height: 50px; overflow: hidden; background-color:#F8F8F8;}
    .shop_bd_shdz_title h3{width:120px; text-align: center; height:40px; line-height: 40px; font-size: 14px; font-weight: bold;  background:#FFF; border:1px solid #E8E8E8; border-radius:4px 4px 0 0; float: left;  position: relative; top:10px; left:10px; border-bottom: none;}
    .shop_bd_shdz_title p{float: right;}
    .shop_bd_shdz_title p a{margin:0 8px; color:#555555;}

	.shop_bd_shdz_lists{width:1000px;}
	.shop_bd_shdz_lists ul{width:1000px;}
	.shop_bd_shdz_lists ul li{width:980px; border-radius: 3px; margin:5px 0; padding-left:18px; line-height: 40px; height:40px; border:1px solid #FFE580; background-color:#FFF5CC;}
	.shop_bd_shdz_lists ul li label{color:#626A73; font-weight: bold;}
	.shop_bd_shdz_lists ul li label span{padding:10px;}
	.shop_bd_shdz_lists ul li em{margin:0 4px; color:#626A73;}

	.shop_bd_shdz{width:1000px; margin:10px auto 0;}
	.shop_bd_shdz_new{border:1px solid #ccc; width:998px;}
	.shop_bd_shdz_new div.title{width:990px; padding-left:8px; line-height:35px; height:35px; border-bottom:1px solid #ccc; background-color:#F2F2F2; font-color:#656565; font-weight: bold; font-size:14px;}
	.shdz_new_form{width:980px; padding:9px;}
	.shdz_new_form ul{width:100%;}
	.shdz_new_form ul li{clear:both; width:100%; padding:5px 0; height:25px; line-height: 25px;}
	.shdz_new_form ul li label{float:left;width:100px; text-align: right; padding-right: 10px;}
	.shdz_new_form ul li label span{color:#f00; font-weight: bold; font-size:14px; position: relative; left:-3px; top:2px;}
    .add_address_btn{
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
					<li class="step_a">确认购物清单</li>
					<li class="step_b hover_b">确认收货人资料及送货方式</li>
					<li class="step_c">购买完成</li>
				</ul>
			</div>
			<!-- 购物流程导航 End -->
<div class="clear"></div>
			<!-- 收货地址 title -->
			<div class="shop_bd_shdz_title">
				<h3>收货人地址</h3>
				<p><a href="javasrcipt:void(0);" id="new_add_shdz_btn">新增收货地址</a><a href="../address/list">管理收货地址</a></p>
			</div>
			<div class="clear"></div>
			<!-- 收货人地址 Title End -->
			<div class="shop_bd_shdz clearfix">
				<div class="shop_bd_shdz_lists clearfix">
					<ul>
						<c:forEach items="${addressList }" var="address">
						<li><label>寄送至：<span><input type="radio" name="address" value="${address.id }" /></span></label><em>${address.address }</em><em>${address.name }(收)</em><em>${address.phone }</em></li>
						</c:forEach>
					</ul>
				</div>
				<!-- 新增收货地址 -->
				<div id="new_add_shdz_contents" style="display:none;" class="shop_bd_shdz_new clearfix">
					<div class="title">新增收货地址</div>
					<div class="shdz_new_form">
						<form>
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
			</div>
			<div class="clear"></div>
			<div class="shop_bd_shdz_title">
				<h3>确认购物清单</h3>
			</div>
			<div class="clear"></div>
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
						<td colspan="6" style="text-align:left;">
							<textarea id="order-remark" style="width:1000px;height:50px;" placeholder="订单备注"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<div class="gwc_foot_zongjia">商品总价(不含运费)<span>￥<strong id="good_zongjia">0.00</strong></span></div>
							<div class="clear"></div>
							<div class="gwc_foot_links">
								<a href="../home/index" class="go">继续购物</a>
								<a href="javascript:void(0)" id="submit-order-btn" class="op">确认提交订单</a>
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
jQuery(function(){
	jQuery("#new_add_shdz_btn").toggle(function(){
		jQuery("#new_add_shdz_contents").show(500);
	},function(){
		jQuery("#new_add_shdz_contents").hide(500);
	});
});
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
		//提交订单
		$("#submit-order-btn").click(function(){
			var addressId = $("input[type='radio']:checked").val();
			if(addressId == '' || addressId == 'undefined' || addressId == null){
				alert('请选择收货地址');
				return;
			}
			$.ajax({
				url:'../order/add',
				type:'POST',
				data:{addressId:addressId,remark:$("#order-remark").val()},
				dataType:'json',
				async:false,
				success:function(data){
					if(data.type == 'success'){
						alert('下单成功!');
						window.location.href = '../order/order_success?orderId='+data.oid;
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