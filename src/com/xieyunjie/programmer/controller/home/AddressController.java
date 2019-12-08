package com.xieyunjie.programmer.controller.home;

import java.util.Date;
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
import com.xieyunjie.programmer.entity.home.Address;
import com.xieyunjie.programmer.service.common.AccountService;
import com.xieyunjie.programmer.service.common.ProductCategoryService;
import com.xieyunjie.programmer.service.common.ProductService;
import com.xieyunjie.programmer.service.home.AddressService;
import com.xieyunjie.programmer.util.MenuUtil;

/**
 * 前台收货地址控制器
 * @author Administrator
 *
 */
@RequestMapping("/address")
@Controller
public class AddressController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private AddressService addressService;
	/**
	 * 收货地址列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public ModelAndView index(ModelAndView model,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", onlineAccount.getId());
		model.addObject("addressList", addressService.findList(queryMap));
		model.addObject("currentUser", "current_");
		model.setViewName("home/address/list");
		return model;
	}
	
	
	/**
	 * 添加收货地址
	 * @param account
	 * @return
	 */
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> add(Address address,HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(address == null){
			ret.put("msg", "请选择正确的收货信息");
			return ret;
		}
		if(StringUtils.isEmpty(address.getName())){
			ret.put("msg", "请填写收货人！");
			return ret;
		}
		if(StringUtils.isEmpty(address.getAddress())){
			ret.put("msg", "请填写收货地址！");
			return ret;
		}
		if(StringUtils.isEmpty(address.getPhone())){
			ret.put("msg", "请填写手机号！");
			return ret;
		}
		address.setUserId(onlineAccount.getId());
		address.setCreateTime(new Date());
		if(addressService.add(address) <= 0){
			ret.put("msg", "添加失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	@RequestMapping(value = "/edit",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> edit(Address address,HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(address == null){
			ret.put("msg", "请选择正确的收货信息");
			return ret;
		}
		Address existAddress = addressService.findById(address.getId());
		if(existAddress == null){
			ret.put("msg", "不存在该地址！");
			return ret;
		}
		if(StringUtils.isEmpty(address.getName())){
			ret.put("msg", "请填写收货人！");
			return ret;
		}
		if(StringUtils.isEmpty(address.getAddress())){
			ret.put("msg", "请填写收货地址！");
			return ret;
		}
		if(StringUtils.isEmpty(address.getPhone())){
			ret.put("msg", "请填写手机号！");
			return ret;
		}
		address.setUserId(onlineAccount.getId());
		if(addressService.edit(address) <= 0){
			ret.put("msg", "编辑失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 删除收货地址
	 * @param favoriteId
	 * @return
	 */
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> delete(Long id){
		Map<String, String> ret = new HashMap<String, String>();
		ret.put("type", "error");
		if(id == null){
			ret.put("msg", "请选择要删除的地址");
			return ret;
		}
		if(addressService.delete(id) <= 0){
			ret.put("msg", "删除出错，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		return ret;
	}
	
}
