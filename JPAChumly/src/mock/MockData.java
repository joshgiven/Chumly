package mock;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.Availability;
import entities.Location;
import entities.Message;
import entities.Profile;
import entities.User;
import entities.User.Role;

public class MockData {

	private List<User> mockUsers;
	private List<Location> mockLocations;
	private List<Message> mockMessages;
	 
	public MockData() { }
	
	public static void main(String[] args) {
		if(args.length == 0) {
			System.out.println("usage: ");
			return;
		}
		
		String userMockData     = args[0];
		String locationMockData = args[1];
		String messageMockData  = args[2];

		MockData mu = new MockData();
		
		System.out.println("reading location file...");
		mu.importLocationsFromFile(locationMockData);
		
		System.out.println("persisting locations...");
		mu.persistLocations();

		System.out.println("reading user file...");
		mu.importUsersFromFile(userMockData);
		
		System.out.println("persisting users...");
		mu.persistUsers();
		
		System.out.println("reading message file...");
		mu.importMessagesFromFile(messageMockData);
		
		System.out.println("persisting messages...");
		mu.persistMessages();
		
		System.out.println("bye.");
	}

	private void importUsersFromFile(String userMockData) {
		mockUsers = new ArrayList<>();
		
		Set<String> usernames = new HashSet<>();
		
		try(BufferedReader input = 
				new BufferedReader(new FileReader(userMockData)) ) {
			// first_name last_name domain username email description image_url
			String line = null;
			while((line = input.readLine()) != null) {
				String[] tokens = line.split("\t");
				
				if(tokens.length != 7)
					throw new IllegalArgumentException();
				
				if(tokens[0].equals("first_name"))
					continue;
				
				String firstName   = tokens[0];
				String lastName    = tokens[1];
				//String ignore    = tokens[2];
				String username    = tokens[3];
				String email       = tokens[4];
				String description = tokens[5];
				String imageURL    = tokens[6];
				
				while(usernames.contains(username)) {
					username += "x";
				}
				usernames.add(username);
				
				Profile profile = new Profile();
				profile.setFirstName(firstName);
				profile.setLastName(lastName);
				profile.setImageURL(imageURL);
				
				int limit = description.length();
				if(limit >= 250) limit = 250;
				profile.setDescription(description.substring(0, limit));
				
				User user = new User();
				user.setUsername(username);
				user.setPassword(username);
				user.setEmail(email);
				user.setRole(Role.USER);
				user.setAvailabilities(generateAvailabilities());
				user.setProfile(profile);
				
				mockUsers.add(user);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}

	private List<Availability> generateAvailabilities() {
		List<Availability> avails = new ArrayList<>();
		
		for(Availability.DayOfWeek day : Availability.DayOfWeek.values()) {
			Availability a = new Availability();
			
			a.setDayOfWeek(day);
			a.setFreeAM(Math.random() > 0.5);
			a.setFreePM(Math.random() > 0.5);
			
			avails.add(a);
		}
		
		return avails;
	}

	
	
	
	public <R> R persist(Function<EntityManager,R> func) {
		R retVal = null;
		EntityManagerFactory emf = null;
		EntityManager em = null;

		try {
			emf = Persistence.createEntityManagerFactory("JPAChumly");
			em = emf.createEntityManager();
			
			retVal = func.apply(em);
		}
		finally {
			if (em != null) {
				if(em.getTransaction().isActive())
					em.getTransaction().rollback();
				
				em.close();
			}
			
			if (em != null) {
				emf.close();
			}
		}
		
		return retVal;
	}


	
	public void persistUsers() {
		persist( (em) -> {
			for(User user : mockUsers) {
				em.getTransaction().begin();
				
				int locID = (int)(Math.random() * mockLocations.size()) + 1;
				user.getProfile().setLocation(em.find(Location.class, locID));
				
				em.persist(user);
				em.flush();
				em.getTransaction().commit();
			}
			return true;
		});	
	}

	private void importMessagesFromFile(String messageMockData) {
		mockMessages = new ArrayList<>();
		
		try(BufferedReader input = 
				new BufferedReader(new FileReader(messageMockData)) ) {

			String line = null;
			while((line = input.readLine()) != null) {
				String[] tokens = line.split("\t");
				
				//timestamp	message	sender_id	
				if(tokens.length < 2)
					throw new IllegalArgumentException(tokens.length + " < " + 2);
				
				if(tokens[0].equals("timestamp"))
					continue;
				
				String dateString = tokens[0].split(" ")[0];
				Date timeStamp = Date.valueOf(dateString);
				String text = tokens[1];
				if(text.length() > 250)
					text = text.substring(0, 250);
				
				Message message = new Message();
				message.setTimeStamp(timeStamp);
				message.setText(text);
				mockMessages.add(message);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}

	private void persistMessages() {
		persist( (em) -> {
			for(Message msg : mockMessages) {
				em.getTransaction().begin();
				
				User sender = em.find(User.class, (int)(Math.random()*mockUsers.size()) + 1);
				User recip  = em.find(User.class, (int)(Math.random()*mockUsers.size()) + 1);
				
				msg.setRecipients(Arrays.asList(recip));
				msg.setSender(sender);
				
				em.persist(msg);
				em.flush();
				em.getTransaction().commit();
			}
			return true;
		});	
	}

	private void importLocationsFromFile(String locationMockData) {
		mockLocations = new ArrayList<>();
		
		try(BufferedReader input = 
				new BufferedReader(new FileReader(locationMockData)) ) {

			String line = null;
			while((line = input.readLine()) != null) {
				String[] tokens = line.split(",");
				
				//1,New York,NY,8405837,4.8%
	
				if(tokens.length != 5)
					throw new IllegalArgumentException();
				
				String city = tokens[1];
				String state = tokens[2];
				
				Location location = new Location();
				location.setCity(city);
				location.setState(state);
				mockLocations.add(location);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}

	private void persistLocations() {
		persist( (em) -> {
			for(Location location : mockLocations) {
				em.getTransaction().begin();
				em.persist(location);
				em.flush();
				em.getTransaction().commit();
			}
			return true;
		});	
	}
	
}
