package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template; //SqlSessionTemplate 객체 주입 DI
	private Map<String, Object> param = new HashMap<String, Object>();
	
	public void insert(User user) {
		template.getMapper(UserMapper.class).insert(user);
	}

	public String idcheck(String id) {
		return template.getMapper(UserMapper.class).idcheck(id);
	}

	public User selectOne(String userid) {
		return template.getMapper(UserMapper.class).selectOne(userid);
	}

	public String search(User user, String url) {
		param.clear();
		param.put("email", user.getEmail());
		param.put("phoneno", user.getPhoneno());
		if(url.equals("id")) {//idsearch인 경우
			param.put("col", "substr(userid, 1, length(userid)-2)||'**'");
		}else if(url.equals("pw")) {//pwsearch인 경우
			param.put("col", "'**'||substr(userpw, 3, length(userpw)-2)");
			param.put("userid", user.getUserid());
		}
		return template.getMapper(UserMapper.class).search(param);
	}

	public String find(User user, String url) {
		param.clear();
		param.put("email", user.getEmail());
		param.put("phoneno", user.getPhoneno());
		if(url.equals("id")) {
			param.put("col", "userid");
		}else if(url.equals("pw")) {
			param.put("col", "userpw");
			param.put("userid", user.getUserid());
		}
		return template.getMapper(UserMapper.class).find(param);
	}

	public void update(User user) {
		template.getMapper(UserMapper.class).update(user);
	}

	public void passwordupdate(String userid, String chgpass) {
		param.clear();
		param.put("userid", userid);
		param.put("userpw", chgpass);
		template.getMapper(UserMapper.class).passwordupdate(param);
	}

	public void delete(String userid) {
		template.getMapper(UserMapper.class).delete(userid);
	}

	public List<User> list() {
		return template.getMapper(UserMapper.class).select(null);
	}
	
	public List<User> list(String[] idchks) {
		param.clear();
		param.put("userids", idchks);
		return template.getMapper(UserMapper.class).select(param);
	}
}
