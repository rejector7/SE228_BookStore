package dao;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class MongoDBUtil {
	private static MongoDatabase mgdb=null;
	public static MongoDatabase getInstance() {
		if(mgdb==null) {
			try {
				MongoClient mongoClient=new MongoClient("localhost",27017);
				MongoDatabase mgdb=mongoClient.getDatabase("bookstore");
				System.out.println(mgdb.getName());
				return mgdb;
			}catch(Exception e) {
				System.err.println(e.getClass().getName()+": "+e.getMessage());
			}
		}
		return null;
	}
}
