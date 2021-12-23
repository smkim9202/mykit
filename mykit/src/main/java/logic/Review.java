package logic;

import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

public class Review {
	private int renum;
	private String userid;
	private int itemid;
	@Max(value=5, message="최대 5점입니다.")
	@Min(value=0, message="최소 0점입니다.")
	private int score;
	@NotEmpty(message="내용을 입력하세요")
	private String recontent;
	private Date redate;
	
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getItemid() {
		return itemid;
	}
	public void setItemid(int itemid) {
		this.itemid = itemid;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getRecontent() {
		return recontent;
	}
	public void setRecontent(String recontent) {
		this.recontent = recontent;
	}
	public Date getRedate() {
		return redate;
	}
	public void setRedate(Date redate) {
		this.redate = redate;
	}
	
	@Override
	public String toString() {
		return "Review [renum=" + renum + ", userid=" + userid + ", itemid=" + itemid + ", score=" + score
				+ ", recontent=" + recontent + ", redate=" + redate + "]";
	}
}
