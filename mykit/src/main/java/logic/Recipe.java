package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class Recipe {
	private int rcnum; // 레시피 번호
	private String userid; // 아이디(UserAccount-userid)
	@Size(min=1, max=28, message="제목은 1자 이상 28자 이하로 입력해주세요!")
	private String rctitle; // 레시피 제목
	@NotEmpty(message="내용을 입력하세요")
	private String rccontent; // 레시피 본문
	private MultipartFile rcimg; // 파일정보 저장 변수
	private String rcimgurl;
	private Date rcdate; // 작성 날짜
	private int rcreadcnt; //조회수
	private int heartcnt;// 좋아요수
	
	public int getRcnum() {
		return rcnum;
	}
	public void setRcnum(int rcnum) {
		this.rcnum = rcnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRctitle() {
		return rctitle;
	}
	public void setRctitle(String rctitle) {
		this.rctitle = rctitle;
	}
	public String getRccontent() {
		return rccontent;
	}
	public void setRccontent(String rccontent) {
		this.rccontent = rccontent;
	}
	public MultipartFile getRcimg() {
		return rcimg;
	}
	public void setRcimg(MultipartFile rcimg) {
		this.rcimg = rcimg;
	}
	public String getRcimgurl() {
		return rcimgurl;
	}
	public void setRcimgurl(String rcimgurl) {
		this.rcimgurl = rcimgurl;
	}
	public Date getRcdate() {
		return rcdate;
	}
	public void setRcdate(Date rcdate) {
		this.rcdate = rcdate;
	}
	public int getRcreadcnt() {
		return rcreadcnt;
	}
	public void setRcreadcnt(int rcreadcnt) {
		this.rcreadcnt = rcreadcnt;
	}
	public int getHeartcnt() {
		return heartcnt;
	}
	public void setHeartcnt(int heartcnt) {
		this.heartcnt = heartcnt;
	}
	@Override
	public String toString() {
		return "Recipe [rcnum=" + rcnum + ", userid=" + userid + ", rctitle=" + rctitle + ", rccontent=" + rccontent
				+ ", rcimg=" + rcimg + ", rcimgurl=" + rcimgurl + ", rcdate=" + rcdate + ", rcreadcnt=" + rcreadcnt
				+ ", heartcnt=" + heartcnt + "]";
	}


	
}
