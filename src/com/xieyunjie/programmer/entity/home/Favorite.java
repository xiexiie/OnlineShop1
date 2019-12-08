package com.xieyunjie.programmer.entity.home;

import java.util.Date;

import org.springframework.stereotype.Component;

/**
 * 收藏实体
 * @author Administrator
 *
 */
@Component
public class Favorite {
	
	private Long id;//id
	
	private Long productId;//商品id
	
	private Long userId;//用户id
	
	private String name;//商品名称
	
	private String imageUrl;//商品主图
	
	private Double price;//商品价格
	
	private Date createTime;//添加时间

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

}
