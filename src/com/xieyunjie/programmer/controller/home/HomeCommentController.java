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
import com.xieyunjie.programmer.entity.common.Comment;
import com.xieyunjie.programmer.entity.common.Product;
import com.xieyunjie.programmer.service.common.AccountService;
import com.xieyunjie.programmer.service.common.CommentService;
import com.xieyunjie.programmer.service.common.ProductCategoryService;
import com.xieyunjie.programmer.service.common.ProductService;
import com.xieyunjie.programmer.util.MenuUtil;

/**
 * 前台评价控制器
 * @author Administrator
 *
 */
@RequestMapping("/comment")
@Controller
public class HomeCommentController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private CommentService commentService;
	/**
	 * 评价列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public ModelAndView index(ModelAndView model,Integer page,HttpServletRequest request){
		model.addObject("productCategoryList", MenuUtil.getTreeCategory(productCategoryService.findList(new HashMap<String, Object>())));
		model.addObject("allCategoryId","shop_hd_menu_all_category");
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if(page == null || page.intValue() <= 0){
			page = 1;
		}
		queryMap.put("offset", (page -1) * 10);
		queryMap.put("pageSize", 10);
		queryMap.put("userId", onlineAccount.getId());
		queryMap.put("orderBy", "createTime");
		model.addObject("commentList", commentService.findList(queryMap));
		model.addObject("currentUser", "current_");
		model.addObject("page", page);
		model.setViewName("home/comment/list");
		return model;
	}
	
	
	/**
	 * 添加评价
	 * @param account
	 * @return
	 */
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> add(Comment comment,HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		Account onlineAccount = (Account)request.getSession().getAttribute("account");
		ret.put("type", "error");
		if(comment == null){
			ret.put("msg", "请填写正确的评论信息");
			return ret;
		}
		if(StringUtils.isEmpty(comment.getContent())){
			ret.put("msg", "请填写评价内容！");
			return ret;
		}
		comment.setCreateTime(new Date());
		comment.setUserId(onlineAccount.getId());
		if(commentService.add(comment) <= 0){
			ret.put("msg", "评论失败，请联系管理员!");
			return ret;
		}
		//更新商品评论数量
		Product product = productService.findById(comment.getProductId());
		product.setCommentNum(product.getCommentNum()+1);
		productService.updateNum(product);
		ret.put("type", "success");
		return ret;
	}
	
	/**
	 * 删除评论
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> delete(Long id){
		Map<String, String> ret = new HashMap<String, String>();
		ret.put("type", "error");
		if(id == null){
			ret.put("msg", "请选择要删除的评论");
			return ret;
		}
		Comment comment = commentService.findById(id);
		if(comment == null){
			ret.put("msg", "评论不存在!");
			return ret;
		}
		if(commentService.delete(id) <= 0){
			ret.put("msg", "删除出错，请联系管理员!");
			return ret;
		}
		//更新商品评论数量
		Product product = productService.findById(comment.getProductId());
		product.setCommentNum(product.getCommentNum()-1);
		productService.updateNum(product);
		ret.put("type", "success");
		return ret;
	}
}
