package exception;
//RuntimeException : 예외처리 생략가능 
public class RecipeException extends RuntimeException {
	private String url;
	public RecipeException (String msg,String url) {  //생성자
		super(msg);
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}

