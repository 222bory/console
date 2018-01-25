package com.sicc.admin.demo;

import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import org.springframework.boot.ApplicationHome;
import org.springframework.boot.ApplicationPid;
import org.springframework.boot.ApplicationTemp;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

//import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

@SpringBootApplication
//@EnableEncryptableProperties
public class AdminApplication {

	public static void main(String[] args) {
		System.out.println("sicc admin application start");
		ApplicationHome ah = new ApplicationHome();
	
		System.out.println("ah :::" + ah.getDir() );
		System.out.println("ah :::" + ah.getSource() ); 
		
		ApplicationPid ap = new ApplicationPid();
		System.out.println("ap ::: "+ ap.toString());
		
		ApplicationTemp at = new ApplicationTemp(AdminApplication.class);
		System.out.println("at ::: "+ at.getDir()); 
		
		System.out.println("dir ::: "+System.getProperty("user.dir"));
		System.out.println("home ::: "+System.getProperty("java.home"));
		System.out.println("class.path ::: "+System.getProperty("java.class.path"));
		System.out.println("command ::: "+System.getProperty("sun.java.command"));
		System.out.println("boot.class.path ::: "+System.getProperty("sun.boot.class.path"));
		
		Properties p = System.getProperties();
		Set<Object> s = p.keySet();
		Iterator<Object> it = s.iterator();
		
		while(it.hasNext()) {
			String key = it.next().toString();
			System.out.println("key ::: "+key);
			System.out.println("value ::: "+ p.getProperty(key));
		}
		
		
		SpringApplication.run(AdminApplication.class, args);
	} 
}
