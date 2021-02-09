package study.shop.cidermarket.interceptor;

import com.google.gson.annotations.SerializedName;

import lombok.Data;

public class model {

	@Data
	public class Simple {
	    @SerializedName("name")   private String name;
	    @SerializedName("type")   private String type;
	    @SerializedName("img")    private String img;
	}
	
	
	
}
