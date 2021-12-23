package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sale {
	private int saleid;
	private String userid;
	private Date saledate;
	private int rpoint;
	private int usepoint;
	private int saleamount;
	private User user;
	private List<SaleItem> itemList = new ArrayList<SaleItem>();
	
	public long getTotal() {
		return itemList.stream().mapToInt(is->is.getItem().getPrice() * is.getQuantity()).sum() - usepoint;
	}

	public int getSaleid() {
		return saleid;
	}
	public void setSaleid(int saleid) {
		this.saleid = saleid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Date getSaledate() {
		return saledate;
	}
	public void setSaledate(Date saledate) {
		this.saledate = saledate;
	}
	public int getRpoint() {
		return rpoint;
	}
	public void setRpoint(int rpoint) {
		this.rpoint = rpoint;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getSaleamount() {
		return saleamount;
	}

	public void setSaleamount(int saleamount) {
		this.saleamount = saleamount;
	}
	
	public List<SaleItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<SaleItem> itemList) {
		this.itemList = itemList;
	}

	@Override
	public String toString() {
		return "Sale [saleid=" + saleid + ", userid=" + userid + ", saledate=" + saledate + ", rpoint=" + rpoint
				+ ", user=" + user + ", saleamount=" + saleamount + "]";
	}

	public int getUsepoint() {
		return usepoint;
	}

	public void setUsepoint(int usepoint) {
		this.usepoint = usepoint;
	}
}
