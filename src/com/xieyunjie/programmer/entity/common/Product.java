package com.xieyunjie.programmer.entity.common;

import java.util.Date;

import org.springframework.stereotype.Component;

/**
 * 商品实体
 * @author Administrator
 *
 */
@Component
public class Product {
	
	private Long id;//商品分类id
	
	private Long productCategoryId;//分类id
	
	private String name;//商品名称
	
	private String tags;//分类标签，用来按照商品分类搜索
	
	private String imageUrl;//商品主图
	
	private Double price;//商品价格
	
	private int stock;//商品库存
	
	private int sellNum;//销量
	
	private int viewNum;//浏览量
	
	private int commentNum;//评论数
	
	private String content;//商品详情描述
	
	private Date createTime;//添加时间

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getProductCategoryId() {
		return productCategoryId;
	}

	public void setProductCategoryId(Long productCategoryId) {
		this.productCategoryId = productCategoryId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getSellNum() {
		return sellNum;
	}

	public void setSellNum(int sellNum) {
		this.sellNum = sellNum;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	
	
	
	
}
