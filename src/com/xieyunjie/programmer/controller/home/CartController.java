package com.xieyunjie.programmer.controller.home;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xieyunjie.programmer.entity.common.Account;
import com.xieyunjie.programmer.entity.common.Product;
import com.xieyunjie.programmer.entity.home.Cart;
import com.xieyunjie.programmer.service.common.AccountService;
import com.xieyunjie.programmer.service.common.ProductCategoryService;
import com.xieyunjie.programmer.service.common.ProductService;
import com.xieyunjie.programmer.service.home.AddressService;
import com.xieyunjie.programmer.service.home.CartService;
import com.xieyunjie.programmer.util.MenuUtil;

/**
 * 前台购物车控制器
 * @author Administrator
 *
 */
@RequestMapping("/cart")
@Controller
public class CartController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private CartService cartService;
	@Autowired
	private AddressService addressService;
	/**
	 * 购物车列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public ModelAndView list(ModelAndView model,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", onlineAccount.getId());
		model.addObject("cartList", cartService.findList(queryMap));
		model.addObject("currentCart", "current_");
		model.setViewName("home/cart/list");
		return model;
	}
	
	/**
	 * 提交订单第二步
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/list_2",method = RequestMethod.GET)
	public ModelAndView list2(ModelAndView model,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", onlineAccount.getId());
		model.addObject("cartList", cartService.findList(queryMap));
		model.addObject("currentCart", "current_");
		model.addObject("addressList", addressService.findList(queryMap));
		model.setViewName("home/cart/list_2");
		return model;
	}
	
	
	/**
	 * 添加购物车
	 * @param account
	 * @return
	 */
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> add(Cart cart,HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(cart == null){
			ret.put("msg", "请选择正确的商品信息");
			return ret;
		}
		if(cart.getProductId() == null){
			ret.put("msg", "请选择要添加的商品！");
			return ret;
		}
		if(cart.getNum() == 0){
			ret.put("msg", "请填写商品数量");
			return ret;
		}
		Product product = productService.findById(cart.getProductId());
		if(product == null){
			ret.put("msg", "商品不存在");
			return ret;
		}
		//根据商品和用户去查询该商品是否已被添加到购物车
		Map<String, Long> queryMap = new HashMap<String, Long>();
		queryMap.put("userId", onlineAccount.getId());
		queryMap.put("productId", product.getId());
		Cart existCart = cartService.findByIds(queryMap);
		if(existCart != null){
			//表示这个商品已经被添加到购物车，只需更新数量和金额即可
			existCart.setNum(existCart.getNum() + cart.getNum());
			existCart.setMoney(existCart.getNum() * existCart.getPrice());
			if(cartService.edit(existCart) <= 0){
				ret.put("msg", "商品已被添加到购物车，但更新数量出错!");
				return ret;
			}
			ret.put("type", "success");
			return ret;
		}
		cart.setImageUrl(product.getImageUrl());
		cart.setMoney(product.getPrice() * cart.getNum());
		cart.setName(product.getName());
		cart.setPrice(product.getPrice());
		cart.setUserId(onlineAccount.getId());
		cart.setCreateTime(new Date());
		if(cartService.add(cart) <= 0){
			ret.put("msg", "添加失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 更新购物车商品数量
	 * @param cartId
	 * @param num
	 * @return
	 */
	@RequestMapping(value = "/update_num",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateNum(Long cartId,Integer num){
		Map<String, String> ret = new HashMap<String, String>();
		ret.put("type", "error");
		Cart cart = cartService.findById(cartId);
		if(cart == null){
			ret.put("msg", "请选择正确的商品信息");
			return ret;
		}
		if(num == null){
			ret.put("msg", "请填写商品数量");
			return ret;
		}
		Product product = productService.findById(cart.getProductId());
		if(product == null){
			ret.put("msg", "购物车信息有误！");
			return ret;
		}
		if(cart.getNum() + num.intValue() > product.getStock()){
			ret.put("msg", "商品数量不能超过库存量！");
			return ret;
		}
		cart.setNum(cart.getNum() + num);
		cart.setMoney(cart.getNum() * cart.getPrice());
		if(cartService.edit(cart) <= 0){
			ret.put("msg", "商品已被添加到购物车，但更新数量出错!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 删除购物车商品
	 * @param cartId
	 * @return
	 */
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> delete(Long cartId){
		Map<String, String> ret = new HashMap<String, String>();
		ret.put("type", "error");
		if(cartId == null){
			ret.put("msg", "请选择要删除的商品");
			return ret;
		}
		if(cartService.delete(cartId) <= 0){
			ret.put("msg", "删除出错，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
}
