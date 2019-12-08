package com.xieyunjie.programmer.controller.home;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xieyunjie.programmer.entity.common.Account;
import com.xieyunjie.programmer.service.common.AccountService;
import com.xieyunjie.programmer.service.common.OrderService;
import com.xieyunjie.programmer.service.common.ProductCategoryService;
import com.xieyunjie.programmer.service.common.ProductService;
import com.xieyunjie.programmer.service.home.AddressService;
import com.xieyunjie.programmer.service.home.CartService;
import com.xieyunjie.programmer.util.MenuUtil;

/**
 * 前台用户中心控制器
 * @author Administrator
 *
 */
@RequestMapping("/user")
@Controller
public class HomeUserController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private CartService cartService;
	@Autowired
	private AddressService addressService;
	/**
	 * 用户中心页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info",method = RequestMethod.GET)
	public ModelAndView info(ModelAndView model,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		model.addObject("user", onlineAccount);
		model.addObject("currentUser", "current_");
		model.setViewName("home/user/info");
		return model;
	}
	
	/**
	 * 修改密码页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update_pwd",method = RequestMethod.GET)
	public ModelAndView updatePwd(ModelAndView model){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		model.addObject("currentUser", "current_");
		model.setViewName("home/user/update_pwd");
		return model;
	}
	
	/**
	 * 修改密码提交
	 * @param password
	 * @param newPassword
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/update_pwd",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updatePassword(String password,String newPassword,
			HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(StringUtils.isEmpty(password)){
			ret.put("msg", "旧密码不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(newPassword)){
			ret.put("msg", "新密码不能为空！");
			return ret;
		}
		if(!onlineAccount.getPassword().equals(password)){
			ret.put("msg", "旧密码错误！");
			return ret;
		}
		onlineAccount.setPassword(newPassword);
		if(accountService.edit(onlineAccount) <= 0){
			ret.put("msg", "修改失败，请联系管理员！");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 更新资料
	 * @param account
	 * @return
	 */
	@RequestMapping(value = "/update_info",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateInfo(Account account,
			HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(account == null){
			ret.put("msg", "请填写正确的信息");
			return ret;
		}
		if(StringUtils.isEmpty(account.getEmail())){
			ret.put("msg", "邮箱地址不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(account.getTrueName())){
			ret.put("msg", "真实姓名不能为空！");
			return ret;
		}
		onlineAccount.setEmail(account.getEmail());
		onlineAccount.setTrueName(account.getTrueName());
		onlineAccount.setSex(account.getSex());
		if(accountService.edit(onlineAccount) <= 0){
			ret.put("msg", "修改失败，请联系管理员！");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 下单成功展示页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/order_success",method = RequestMethod.GET)
	public ModelAndView orderSuccess(ModelAndView model,Long orderId,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		model.addObject("currentCart", "current_");
		model.addObject("order", orderService.findById(orderId));
		model.setViewName("home/cart/order_success");
		return model;
	}
	
	
}
