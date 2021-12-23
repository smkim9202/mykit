package logic;

import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class Item {
	private int itemid;
	@NotEmpty(message="상품명을 입력하세요")
	private String itemname;
	@Min(value=10, message="10원이상 가능합니다.")
	@Max(value=100000, message="10만원이하만 가능합니다.")
	private int price;
	private String description;
	private String itemimg;
	private Date itemdate;
	@NotEmpty(message="종류를 선택해주세요.")
	private String userpick; //당선품. 신상품
	@NotEmpty(message="카테고리를 선택해주세요.")
	private String itype; //전체, 한식, 일식, 중식, 양식
	private int stock;
	private String shortdes;
	private int rcnum;
	private MultipartFile pictureimg;
	private MultipartFile picturedes;
	public int getItemid() {
		return itemid;
	}
	public void setItemid(int itemid) {
		this.itemid = itemid;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getItemimg() {
		return itemimg;
	}
	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	public Date getItemdate() {
		return itemdate;
	}
	public void setItemdate(Date itemdate) {
		this.itemdate = itemdate;
	}
	public String getUserpick() {
		return userpick;
	}
	public void setUserpick(String userpick) {
		this.userpick = userpick;
	}
	public String getItype() {
		return itype;
	}
	public void setItype(String itype) {
		this.itype = itype;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getShortdes() {
		return shortdes;
	}
	public void setShortdes(String shortdes) {
		this.shortdes = shortdes;
	}
	public int getRcnum() {
		return rcnum;
	}
	public void setRcnum(int rcnum) {
		this.rcnum = rcnum;
	}
	public MultipartFile getPictureimg() {
		return pictureimg;
	}
	public void setPictureimg(MultipartFile pictureimg) {
		this.pictureimg = pictureimg;
	}
	public MultipartFile getPicturedes() {
		return picturedes;
	}
	public void setPicturedes(MultipartFile picturedes) {
		this.picturedes = picturedes;
	}
	@Override
	public String toString() {
		return "Item [itemid=" + itemid + ", itemname=" + itemname + ", price=" + price + ", description=" + description
				+ ", itemimg=" + itemimg + ", itemdate=" + itemdate + ", userpick=" + userpick + ", itype=" + itype
				+ ", stock=" + stock + ", shortdes=" + shortdes + ", rcnum=" + rcnum + "]";
	}
}
