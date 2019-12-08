<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<title>梦翔社团商城-${title}</title>
	<link rel="stylesheet" href="../resources/home/css/base.css" type="text/css" />
	<link rel="stylesheet" href="../resources/home/css/shop_common.css" type="text/css" />
	<link rel="stylesheet" href="../resources/home/css/shop_header.css" type="text/css" />
        <link rel="stylesheet" href="../resources/home/css/shop_home.css" type="text/css" />
        <script type="text/javascript" src="../resources/home/js/jquery.js" ></script>
        <script type="text/javascript" src="../resources/home/js/topNav.js" ></script>
        <script type="text/javascript" src="../resources/home/js/focus.js" ></script>
</head>
<body>
	<!-- Header  -wll-2013/03/24 -->
	<div class="shop_hd">
		<!-- Header TopNav -->
		<div class="shop_hd_topNav">
			<div class="shop_hd_topNav_all">
				<!-- Header TopNav Left -->
				<div class="shop_hd_topNav_all_left">
					<p>您好，欢迎来到<b><a href="/OnlineShop">梦翔社团商城</a></b>
						<c:if test="${account == null }">
						[<a href="../home/login">登录</a>][<a href="../home/register">注册</a>]
						</c:if>
						<c:if test="${account != null }">
						[${account.name }]
						</c:if>
					</p>
				</div>
				<!-- Header TopNav Left End -->

				<!-- Header TopNav Right -->
				<div class="shop_hd_topNav_all_right">
					<ul class="topNav_quick_menu">

						<li>
							<div class="topNav_menu">
								<a href="#" class="topNavHover">我的商城<i></i></a>
								<div class="topNav_menu_bd" style="display:none;" >
						            <ul>
						              <li><a title="已买到的商品"href="../order/list">已买到的商品</a></li>
						              <li><a title="个人主页" href="../user/info">个人主页</a></li>
						            </ul>
						        </div>
							</div>
						</li>
						<li>
							<div class="topNav_menu">
								<a href="../cart/list" class="topNavHover">购物车</a>
							</div>
						</li>

						<li>
							<div class="topNav_menu">
								<a href="../favorite/list" class="topNavHover">我的收藏<i></i></a>
								<div class="topNav_menu_bd" style="display:none;">
						            <ul>
						              <li><a title="收藏的商品" target="_top" href="../favorite/list">收藏的商品</a></li>
						            </ul>
						        </div>
							</div>
						</li>

					</ul>
				</div>
				<!-- Header TopNav Right End -->
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<!-- Header TopNav End -->

		<!-- TopHeader Center -->
		<div class="shop_hd_header">
			<div class="shop_hd_header_logo"><h1 class="logo"><a href="/OnlineShop"><img src="../resources/home/images/logo.png" alt="ShopCZ" /></a><span>梦翔社团</span></h1></div>
			<div class="shop_hd_header_search">
                            <ul class="shop_hd_header_search_tab">
			        <li id="search" class="current">商品</li>
			       
			    </ul>
                            <div class="clear"></div>
			    <div class="search_form">
			    	<form method="post" action="../product/search">
			    		<div class="search_formstyle">
			    			<input type="text" class="search_form_text" name="search_content" placeholder="搜索其实很简单！" value="${search_content }" />
			    			<input type="submit" class="search_form_sub" name="secrch_submit" value="" title="搜索" />
			    		</div>
			    	</form>
			    </div>
                            <div class="clear"></div>
			    

			</div>
		</div>
		<div class="clear"></div>
		<!-- TopHeader Center End -->

		<!-- Header Menu -->
		<div class="shop_hd_menu">
			<!-- 所有商品菜单 -->
                        
			<div class="shop_hd_menu_all_category ${allCategoryClass }" id="${allCategoryId }"><!-- 首页去掉 id="shop_hd_menu_all_category" 加上clsss shop_hd_menu_hover -->
				<div class="shop_hd_menu_all_category_title"><h2 title="所有商品分类"><a href="javascript:void(0);">所有商品分类</a></h2><i></i></div>
				<div id="shop_hd_menu_all_category_hd" class="shop_hd_menu_all_category_hd">
					<ul class="shop_hd_menu_all_category_hd_menu clearfix">
						<!-- 单个菜单项 -->
						<c:forEach items="${productCategoryList }" var="productCategory">
						<li id="cat_${productCategory.id }" class="">
							<h3><a href="../product/product_category_list?cid=${productCategory.id }" title="${productCategory.text }">${productCategory.text }</a></h3>
							<div id="cat_${productCategory.id }_menu" class="cat_menu clearfix" style="">
								<c:forEach items="${productCategory.children }" var="child">
								<dl class="clearfix">
									<dt><a href="../product/product_category_list?cid=${child.id }" href="">${child.text }</a></dt>
									<dd>
									<c:forEach items="${child.children }" var="grandson">
										<a href="../product/product_category_list?cid=${grandson.id }">${grandson.text }</a>
									</c:forEach>
									</dd>
								</dl>
                                </c:forEach>                            
							</div>
						</li>
						</c:forEach>
						<!-- 单个菜单项 End -->
					</ul>
				</div>
			</div>
			<!-- 所有商品菜单 END -->

			<!-- 普通导航菜单 -->
			<ul class="shop_hd_menu_nav">
				<li class="${currentHome }link"><a href="/OnlineShop1"><span>首页</span></a></li>
				<li class="${currentCart }link"><a href="../cart/list"><span>购物车</span></a></li>
				<li class="${currentUser }link"><a href="../user/info"><span>个人中心</span></a></li>
			</ul>
			<!-- 普通导航菜单 End -->
		</div>
		<!-- Header Menu End -->



	</div>
	<div class="clear"></div>
	<!-- Header End -->