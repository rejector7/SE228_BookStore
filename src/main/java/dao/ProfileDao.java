package dao;

import dao.*;
import entity.*;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;
import com.mongodb.client.gridfs.model.GridFSUploadOptions;
import com.mongodb.gridfs.GridFS;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.*;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import com.mongodb.client.model.Filters;

public class ProfileDao {
	private MongoDatabase mgdb;
	private MongoCollection<Document> profiles;
	
	public MongoDatabase getMongoDatabase() {
		return mgdb;
	}
	public void setMongoDatabase(MongoDatabase mgdb) {
		this.mgdb=mgdb;
	}
	public MongoCollection<Document> getProfiles() {
		return profiles;
	}
	public void setProfiles(MongoCollection<Document> profiles) {
		this.profiles = profiles;
	}
	public ProfileDao() {
		this.setMongoDatabase(MongoDBUtil.getInstance());
		this.setProfiles(mgdb.getCollection("profiles"));
	}
	
	public void insert(Profile item) {
		Document doc=new Document("userid",item.getUserid())
				.append("richText", item.getRichText());
		profiles.insertOne(doc);
	}
	
	public void update(Profile item) {
		profiles.updateOne(Filters.eq("userid",item.getUserid()), 
				new Document("$set",new Document("richText", item.getRichText())
				)
		);
	}
	
	public void delete(int userid) {
        profiles.deleteOne(Filters.eq("userid", userid));
    }
	
	 public void deleteByUser(User user) {
	    profiles.deleteOne(Filters.eq("userid", user.getUserid()));
	 }
	 private Profile mapToProfile(Document doc) {
		    Profile profile = new Profile();
		    profile.setUserid(doc.getInteger("userid"));
		    profile.setRichText(doc.getString("richText"));
		    return profile;
		 }
	 public Profile getByUserid(int userid) {
		 Document doc = profiles.find(Filters.eq("userid",userid)).first();
		 
		 return mapToProfile(doc);
	 }
	 
	 public boolean profileExist(int userid) {
		 FindIterable<Document> findIterable = profiles.find(Filters.eq("userid",userid));  
         MongoCursor<Document> mongoCursor = findIterable.iterator();  
         List<Document> docs=new ArrayList<Document>();
         
         while(mongoCursor.hasNext()) {
        	 docs.add(mongoCursor.next());
         }
         if(docs!=null&&docs.size()>0) {
        	 return true;
         }
         else {
        	 return false;
         }
	 }
	 
	 public boolean profileExistByUser(User user) {
		 Document doc = profiles.find(Filters.eq("userid",user.getUserid())).first();  
         
         if(doc!=null) {
        	 return true;
         }
         else {
        	 return false;
         }
	 }
	 /*
	 
	 
	 public Profile find(long id) {
	    MongoCollection<Document> collection = mgdb.getCollection("profiles");
	    Document doc = collection.find(eq("id", id)).first();

	    return mapToObject(doc);
	 }
	 
	 public List<Profile> findAllByUser(User user){
		 MongoCollection<Document> collection=mgdb.getCollection("profiles");
		 MongoCursor<Document> cursor = collection.find(eq("userid", user.getUserid()))
	                .sort(Filters.eq("id", -1))
	                .iterator();
	        List<Profile> list = new ArrayList<Profile>();
	        while (cursor.hasNext()) {
	            list.add(mapToObject(cursor.next()));
	        }
	        return list;
	 }
	 public String uploadFile(InputStream file,String filename) {
		 GridFSBucket gridFSBucket = GridFSBuckets.create(mgdb);
		 
		 ObjectId fileid=gridFSBucket.uploadFromStream(filename, file);
		 return fileid.toHexString();
	 }
	 
	 public void deleteFile(String resourceName) {
		 GridFSBucket gridFSBucket = GridFSBuckets.create(mgdb);

	     gridFSBucket.delete(new ObjectId(resourceName));
	 }
	 
	 public GridFSFile getFile(String resource) {
		 GridFSBucket gridFSBucket = GridFSBuckets.create(mgdb);
	     return gridFSBucket.find(Filters.eq("_id", new ObjectId(resource))).first();
	 }
	 
	 public InputStream downloadFile(String resource) {
	     GridFSBucket gridFSBucket = GridFSBuckets.create(mgdb);
	     return gridFSBucket.openDownloadStream(new ObjectId(resource));
	 }
	 */
}
