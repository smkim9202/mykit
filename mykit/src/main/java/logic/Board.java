package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;
public class Board {
	private int num; // 게시글 번호
	private String userid; // 아이디(UserAccount-userid)
	private int btype; // 게시글타입(0:QA / 1:공지이벤)
	@Size(min=1, max=28, message="제목은 1자 이상 28자 이하로 입력해주세요!")
	private String title; // 게시글 제목
	@NotEmpty(message="내용을 입력하세요")
	private String content; // 게시글 본문
	private Date regdate; // 작성 날짜
	private MultipartFile myfile; // 파일정보 저장 변수
	private String fileurl;
	private String boardlock; //check(boardlock IN('bdunlock','bdlock') 공개/비공개
	private int grpnum; //답글 그룹화
	
	//setter, getter , toString
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getBtype() {
		return btype;
	}
	public void setBtype(int btype) {
		this.btype = btype;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public MultipartFile getMyfile() {
		return myfile;
	}
	public void setMyfile(MultipartFile myfile) {
		this.myfile = myfile;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	public String getBoardlock() {
		return boardlock;
	}
	public void setBoardlock(String boardlock) {
		this.boardlock = boardlock;
	}
	public int getGrpnum() {
		return grpnum;
	}
	public void setGrpnum(int grpnum) {
		this.grpnum = grpnum;
	}
	@Override
	public String toString() {
		return "Board [num=" + num + ", userid=" + userid + ", btype=" + btype + ", title=" + title + ", content="
				+ content + ", regdate=" + regdate + ", myfile=" + myfile + ", fileurl=" + fileurl + ", boardlock="
				+ boardlock + ", grpnum=" + grpnum + "]";
	}

	
	
	
	
	
}
