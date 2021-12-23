package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Review;

public interface ReviewMapper {

	@Select("select nvl(max(renum), 0) from review")
	int maxnum();

	@Insert("insert into review "
			+ " (renum, userid, itemid, score, recontent, redate) "
			+ " values (#{renum}, #{userid}, #{itemid}, #{score}, #{recontent}, sysdate)")
	void insert(Review review);

	@Select("select * from review where userid=#{value} order by renum")
	List<Review> select(String id);

	@Update("update review set score=#{score}, recontent=#{recontent}, redate=sysdate "
			   + " where renum=#{renum}")
	void update(Review review);

	@Select("select * from review where renum=#{value}")
	Review selectOne(Integer num);

	@Delete("delete from review where renum=#{value}")
	void delete(int num);

	@Select("select * from review where itemid=#{value}")
	List<Review> reviewlist(String id);

	@Select("select nvl(round(avg(score),2), 0) from review where itemid=#{value}")
	double avgReview(String id);

}
