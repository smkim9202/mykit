package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReviewMapper;
import logic.Review;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate template;
	
	private int maxNum() {
		return template.getMapper(ReviewMapper.class).maxnum();
	}
	
	public void write(Review review) {
		int renum = maxNum() + 1;
		review.setRenum(renum);
		template.getMapper(ReviewMapper.class).insert(review);
	}

	public List<Review> list(String id) {
		return template.getMapper(ReviewMapper.class).select(id);
	}

	public void update(Review review) {
		template.getMapper(ReviewMapper.class).update(review);
	}

	public Review selectOne(Integer num) {
		return template.getMapper(ReviewMapper.class).selectOne(num);
	}

	public void delete(int num) {
		template.getMapper(ReviewMapper.class).delete(num);
	}

	public List<Review> reviewlist(String id) {
		return template.getMapper(ReviewMapper.class).reviewlist(id);
	}

	public double avgReview(String id) {
		return template.getMapper(ReviewMapper.class).avgReview(id);
	}

}
