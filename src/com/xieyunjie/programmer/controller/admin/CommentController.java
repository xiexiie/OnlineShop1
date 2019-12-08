package com.xieyunjie.programmer.controller.admin;

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

import com.xieyunjie.programmer.entity.common.Comment;
import com.xieyunjie.programmer.page.admin.Page;
import com.xieyunjie.programmer.service.common.CommentService;

/**
 * 评论管理控制器
 * @author Administrator
 *
 */
@RequestMapping("/admin/comment")
@Controller
public class CommentController {
	
	
	@Autowired
	private CommentService commentService;
	
	
	/**
	 * 评论列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView model){
		model.setViewName("comment/list");
		return model;
	}
	
	/**
	 * 查询评论列表
	 * @param name
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> list(@RequestParam(name="productName",required=false)String productName,
			@RequestParam(name="username",required=false)String username,
			@RequestParam(name="type",required=false)Integer type,
				Page page
			){
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("productName", productName);
		queryMap.put("username", username);
		if(type != null){
			queryMap.put("type", type);
		}
		queryMap.put("offset", page.getOffset());
		queryMap.put("pageSize", page.getRows());
		ret.put("rows", commentService.findList(queryMap));
		ret.put("total", commentService.getTotal(queryMap));
		return ret;
	}
	
	
	
	/**
	 * 编辑评论
	 * @param comment
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(Comment comment){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(comment == null){
			ret.put("type", "error");
			ret.put("msg", "请填写正确的评论信息");
			return ret;
		}
		if(StringUtils.isEmpty(comment.getContent())){
			ret.put("type", "error");
			ret.put("msg", "请填写评论内容");
			return ret;
		}
		if(commentService.edit(comment) <= 0){
			ret.put("type", "error");
			ret.put("msg", "编辑失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "编辑成功!");
		return ret;
	}
	
	/**
	 * 删除评论
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(Long id){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(id == null){
			ret.put("type", "error");
			ret.put("msg", "请选择要删除的");
			return ret;
		}
		if(commentService.delete(id) <= 0){
			ret.put("type", "error");
			ret.put("msg", "删除失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "删除成功!");
		return ret;
	}
	
	
}
