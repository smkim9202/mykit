package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;
import org.springframework.format.annotation.DateTimeFormat;

public class User {
	@Size(min=3, max=20, message="아이디는 3자 이상 20자 이하로 입력해주세요!")
	private String userid;
	@Size(min=3, max=20, message="비밀번호는 3자 이상 20자 이하로 입력해주세요!")
	private String userpw;
	private String pwcheck;
	@NotEmpty(message="사용자 이름은 필수로 입력해야합니다!")
	private String username;
	@NotEmpty(message="email은 필수로 입력해야합니다!")
	@Email(message="email 형식으로 입력하세요!")
	private String email;
	@NotEmpty(message="전화번호는 필수로 입력해야합니다!")
	private String phoneno;
	@NotEmpty(message="우편번호는 필수로 입력해야합니다!")
	private String zipcode;
	@NotEmpty(message="주소는 필수로 입력해야합니다!")
	private String address;
	@Past(message="생일은 과거 날짜만 가능합니다.")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneno() {
		return phoneno;
	}
	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	
	@Override
	public String toString() {
		return "User [userid=" + userid + ", userpw=" + userpw + ", username=" + username + ", email=" + email
				+ ", phoneno=" + phoneno + ", zipcode=" + zipcode + ", address=" + address + ", birth=" + birth + "]";
	}
	public String getPwcheck() {
		return pwcheck;
	}
	public void setPwcheck(String pwcheck) {
		this.pwcheck = pwcheck;
	}
}
