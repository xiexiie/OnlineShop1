package com.xieyunjie.programmer.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xieyunjie.programmer.entity.common.ProductCategory;
import com.xieyunjie.programmer.page.admin.Page;
import com.xieyunjie.programmer.service.common.ProductCategoryService;

/**
 * 商品分类管理控制器
 * @author 17877
 *
 */
@RequestMapping("/admin/product_category")
@Controller
public class ProductCategoryController {

	@Autowired
	private ProductCategoryService productCategoryService;
	
	/**
	 * 商品分类列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView model) {
		model.setViewName("product_category/list");
		return model;
	}
	
	/**
	 * 查询商品分类列表
	 * @param name
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> list(@RequestParam(name="name",defaultValue="")String name,
				Page page
			){
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("name", name);
		//queryMap.put("offset", page.getOffset());
		//queryMap.put("pageSize", page.getRows());
		ret.put("rows", productCategoryService.findList(queryMap));
		ret.put("total", productCategoryService.getTotal(queryMap));
		return ret;
	}
	
	/**
	 * 返回树形分类
	 * @return
	 */
	@RequestMapping(value="/tree_list",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> treeList(){
		Map<String, Object> queryMap = new HashMap<String, Object>();
		return getTreeCategory(productCategoryService.findList(queryMap));
	}
	
	/**
	 * 添加商品分类
	 * @param productCategory
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(ProductCategory productCategory){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(productCategory == null){
			ret.put("type", "error");
			ret.put("msg", "请填写正确的分类信息");
			return ret;
		}
		if(StringUtils.isEmpty(productCategory.getName())){
			ret.put("type", "error");
			ret.put("msg", "请填写分类名称");
			return ret;
		}
		if(productCategory.getParentId() != null){
			ProductCategory productCategoryParent = productCategoryService.findById(productCategory.getParentId());
			if(productCategoryParent != null){
				String tags = "";
				if(productCategoryParent.getTags() != null){
					tags += productCategoryParent.getTags() + ",";
				}
				productCategory.setTags(tags + productCategory.getParentId());
			}
		}
		if(productCategoryService.add(productCategory) <= 0){
			ret.put("type", "error");
			ret.put("msg", "添加失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "添加成功!");
		return ret;
	}
	
	/**
	 * 编辑商品分类
	 * @param productCategory
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(ProductCategory productCategory){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(productCategory == null){
			ret.put("type", "error");
			ret.put("msg", "请填写正确的分类信息");
			return ret;
		}
		if(StringUtils.isEmpty(productCategory.getName())){
			ret.put("type", "error");
			ret.put("msg", "请填写分类名称");
			return ret;
		}
		if(productCategory.getParentId() != null){
			ProductCategory productCategoryParent = productCategoryService.findById(productCategory.getParentId());
			if(productCategoryParent != null){
				String tags = "";
				if(productCategoryParent.getTags() != null){
					tags += productCategoryParent.getTags() + ",";
				}
				productCategory.setTags(tags + productCategory.getParentId());
			}
		}
		if(productCategoryService.edit(productCategory) <= 0){
			ret.put("type", "error");
			ret.put("msg", "编辑失败，请联系管理员!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "编辑成功!");
		return ret;
	}
	
	/**
	 * 删除商品的分类
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(Long id){
		Map<String, Object> ret = new HashMap<String, Object>();
		if(id == null){
			ret.put("type", "error");
			ret.put("msg", "请选择要删除的分类");
			return ret;
		}
		//数据库中的外键约束
		try {
			if(productCategoryService.delete(id) <= 0){
				ret.put("type", "error");
				ret.put("msg", "删除失败，请联系管理员!");
				return ret;
			}
		} catch (Exception e) {
			// TODO: handle exception
			ret.put("type", "error");
			ret.put("msg", "该分类下存在商品信息，不允许删除!");
			return ret;
		}
		
		ret.put("type", "success");
		ret.put("msg", "删除成功!");
		return ret;
	}
	
	/**
	 * 根据列表生成二级树形关系分类
	 * @param productCategorieList
	 * @return
	 */
	private List<Map<String, Object>> getTreeCategory(List<ProductCategory> productCategorieList){
		List<Map<String, Object>> ret = new ArrayList<Map<String,Object>>();
		//所有的父分类整理
		for(ProductCategory productCategory : productCategorieList){
			if(productCategory.getParentId() == null){//顶级分类
				Map<String, Object> top = new HashMap<String, Object>();
				top.put("id", productCategory.getId());
				top.put("text", productCategory.getName());
				top.put("children", new ArrayList<Map<String,Object>>());
				ret.add(top);
			}
		}
		//所有的子分类
		for(ProductCategory productCategory : productCategorieList){
			if(productCategory.getParentId() != null){
				for(Map<String, Object> map : ret){
					if(productCategory.getParentId().longValue() == Long.valueOf(map.get("id")+"")){
						List children = (List)map.get("children");
						Map<String, Object> child = new HashMap<String, Object>();
						child.put("id", productCategory.getId());
						child.put("text", productCategory.getName());
						children.add(child);
					}
				}
			}
		}
		return ret;
	}
}
