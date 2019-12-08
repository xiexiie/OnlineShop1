package com.xieyunjie.programmer.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xieyunjie.programmer.entity.common.Account;
import com.xieyunjie.programmer.page.admin.Page;
import com.xieyunjie.programmer.service.common.AccountService;

/**
 *  客户管理控制器
 * @author 17877
 *
 */
@RequestMapping("/admin/account")
@Controller
public class AccountController {
	
	@Autowired
	private AccountService accountService;
	
	
	/**
	 * 客户列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView model){
		model.setViewName("account/list");
		return model;
	}
	
	/**
	 * 查询客户列表
	 * @param name
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> list(@RequestParam(name="name",defaultValue="")String name,
			@RequestParam(name="sex",defaultValue="")Integer sex,
			@RequestParam(name="status",defaultValue="")Integer status,
				Page page
			){
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("name", name);
		if(sex != null){
			queryMap.put("sex", sex);
		}
		if(status != null){
			queryMap.put("status", status);
		}
		queryMap.put("offset", page.getOffset());
		queryMap.put("pageSize", page.getRows());
		ret.put("rows", accountService.findList(queryMap));
		ret.put("total", accountService.getTotal(queryMap));
		return ret;
	}
	
	
	/**
	 * 添加客户
	 * @param account
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(Account account){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(account == null){
			ret.put("type", "error");
			ret.put("msg", "请填写正确的客户信息");
			return ret;
		}
		if(StringUtils.isEmpty(account.getName())){
			ret.put("type", "error");
			ret.put("msg", "请填写客户名称");
			return ret;
		}
		if(StringUtils.isEmpty(account.getPassword())){
			ret.put("type", "error");
			ret.put("msg", "请填写客户登录密码!");
			return ret;
		}
		if(isExist(account.getName(), 0l)){
			ret.put("type", "error");
			ret.put("msg", "该用户名已存在!");
			return ret;
		}
		account.setCreateTime(new Date());
		if(accountService.add(account) <= 0){
			ret.put("type", "error");
			ret.put("msg", "添加失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "添加成功!");
		return ret;
	}
	
	/**
	 * 编辑客户
	 * @param account
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(Account account){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(account == null){
			ret.put("type", "error");
			ret.put("msg", "请填写正确的客户信息");
			return ret;
		}
		if(StringUtils.isEmpty(account.getName())){
			ret.put("type", "error");
			ret.put("msg", "请填写客户名称");
			return ret;
		}
		if(StringUtils.isEmpty(account.getPassword())){
			ret.put("type", "error");
			ret.put("msg", "请填写客户登录密码!");
			return ret;
		}
		if(isExist(account.getName(), account.getId())){
			ret.put("type", "error");
			ret.put("msg", "该用户名已存在!");
			return ret;
		}
		if(accountService.edit(account) <= 0){
			ret.put("type", "error");
			ret.put("msg", "添加失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "编辑成功!");
		return ret;
	}
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(Long id){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(id == null){
			ret.put("type", "error");
			ret.put("msg", "请选择要删除的客户");
			return ret;
		}
		
		try {
			if(accountService.delete(id) <= 0){
				ret.put("type", "error");
				ret.put("msg", "删除失败，请联系管理员!");
				return ret;
			}
		} catch (Exception e) {
			// TODO: handle exception
			ret.put("type", "error");
			ret.put("msg", "该客户下存在订单信息，不允许删除!");
			return ret;
		}
		
		ret.put("type", "success");
		ret.put("msg", "删除成功!");
		return ret;
	}
	
	/**
	 * 检查用户名是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	private boolean isExist(String name,Long id){
		Account account = accountService.findByName(name);
		if(account == null)return false;
		if(account.getId().longValue() == id.longValue())return false;
		return true;
	}
}
