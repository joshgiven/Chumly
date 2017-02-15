package data;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import entities.Availability;
import entities.Interest;
import entities.InterestCategory;
import entities.Location;
import entities.Message;
import entities.Profile;
import entities.User;
import entities.User.Role;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "../WEB-INF/Test-context.xml" })
@WebAppConfiguration
@Transactional
public class UserDaoTest {

	@Autowired
	private WebApplicationContext wac;

	//@Autowired
	private UserDAO dao = null;

	@PersistenceContext
	private EntityManager em;

	@Before
	public void setUp() {
		//dao = wac.getBean(UserDAOImpl.class);
		dao = (UserDAO)wac.getBean("udao");
	}

	@After
	public void tearDown() {
		dao = null;
		em = null;
		wac = null;
	}
	
	/*
	 * public User show(int id);
	 * public User create(User user);
	 * public User updateUser(int id, User user);
	 * public User updateUserProfile(int id, User user);
	 * public User getUserByUsername(String username);
	 * public boolean destroy(int id);
	 */
	
	@Test
	public void test_show() {
		User user = dao.show(2);
		assertNotNull(user);
		assertEquals("wryan", user.getUsername());
		
		Profile profile = user.getProfile();
		assertNotNull(profile);
		assertEquals("William", profile.getFirstName());
	}
	
	@Test
	public void test_destroy() {
		User user = dao.show(2);
		assertNotNull(user);
		assertEquals("wryan", user.getUsername());
		
		dao.destroy(2);
		user = dao.show(2);
		assertNull(user);
	}
	
	@Test
	public void test_destroy_cascade() {
		User user = dao.show(2);
		assertNotNull(user);
		//assertEquals("wryan", user.getUsername());
		
		Profile profile = user.getProfile();
		List<Availability> availabilities = user.getAvailabilities();
		List<User>         connections    = user.getConnections();
		List<Interest>     interests      = user.getInterests();
		List<Message>      messages       = user.getMessages();

		int profileID = profile.getId();
		int availID   = availabilities.get(0).getId();
		int intID     = interests.get(0).getId();
		int msgID     = messages.get(0).getId();
		//int connID    = connections.get(0).getId();

		dao.destroy(2);
		user = dao.show(2);
		assertNull(user);
		
		assertNull(em.find(Profile.class,      profileID));
		assertNull(em.find(Message.class,      msgID));
		assertNull(em.find(Interest.class,     intID));
		assertNull(em.find(Availability.class, availID));
		//assertNull(em.find(User.class,         connID));
	}

	@Test
	public void test_create() {
		Profile newProfile = new Profile();
		newProfile.setFirstName("Spork");
		newProfile.setLastName("Foon");
		newProfile.setDescription("derp derp derp");
		newProfile.setImageURL("spork.jpg");

		User newUser = new User();
		newUser.setUsername("sporkette");
		newUser.setPassword("sporkette");
		newUser.setEmail("spork@spork.com");
		newUser.setRole(Role.USER);
		
		//newUser.setInterests(interests);
		//newUser.setAvailabilities(availabilities);
		newUser.setProfile(newProfile);
		
		User user = dao.create(newUser);
		assertNotNull(user);
		//assertNotEquals(user, newUser);
		assertEquals("sporkette", user.getUsername());
		
		Profile profile = user.getProfile();
		assertNotNull(profile);
		assertEquals("Spork", profile.getFirstName());
		
		int id = user.getId();
		user = null;
		user = dao.show(id);
		assertNotNull(user);
		//assertNotEquals(user, newUser);
		assertEquals("sporkette", user.getUsername());
		
		profile = user.getProfile();
		assertNotNull(profile);
		assertEquals("Spork", profile.getFirstName());
		
	}
	
	@Test
	public void test_updateUser() {
		User user = dao.show(2);
		assertNotNull(user);
		assertEquals("wryan", user.getUsername());

		user.setEmail("bart@clownpenis.fart");
		dao.updateUser(user.getId(), user);
		
		user = null;
		
		user = dao.show(2);
		assertNotNull(user);
		assertEquals("bart@clownpenis.fart", user.getEmail());

	}

	@Test
	public void test_updateUserProfile() {
		User user = dao.show(2);
		assertNotNull(user);
		assertEquals("wryan", user.getUsername());

		Profile profile = user.getProfile();
		assertNotNull(profile);
		assertEquals("William", profile.getFirstName());
		
		profile.setFirstName("Wallace");
		dao.updateUserProfile(user.getId(), user);
		
		user = null;
		profile = null;
		
		user = dao.show(2);
		assertNotNull(user);
		profile = user.getProfile();
		assertNotNull(profile);
		assertEquals("Wallace", profile.getFirstName());

	}
	
	@Test
	public void test_getUserByUsername() {
		User user = dao.show(2);
		assertNotNull(user);
		assertEquals("wryan", user.getUsername());

		User userByUN = dao.getUserByUsername("wryan");
		assertNotNull(userByUN);
		
		assertEquals(user, userByUN);
	}

	
	
	/*
	 * public List<User> index();
	 * public List<User> indexByRole(Role role);
	 * public List<User> indexByLocation(Location location);
	 * public List<User> indexByConnection(User connection);
	 * public List<User> indexByInterest(String interestName);
	 * public List<User> indexByInterestCategory(InterestCategory category);
	 * public List<User> indexByAvailability(Availability availability);
	 * public List<User> indexBy(Predicate<User> filter);
	 */

	@Test
	public void test_index() {
		List<User> users = dao.index();
		assertNotNull(users);
		assertEquals(1001, users.size());
		
		User user = users.get(0);
		assertNotNull(user);
		assertEquals(1, user.getId());
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	public void test_indexByRole() {
		List<User> users = dao.indexByRole(Role.ADMIN);
		assertNotNull(users);
		assertEquals(1, users.size());
		
		User user = users.get(0);
		assertNotNull(user);
		assertEquals(1, user.getId());
		assertEquals("admin", user.getUsername());
		
		users = dao.indexByRole(Role.USER);
		assertNotNull(users);
		assertEquals(1000, users.size());
		assertTrue(users.stream().allMatch( (u) -> u.getRole() == Role.USER ));
		
	}
	
	@Test
	public void test_indexByLocation() {
		Location location = new Location();
		location.setCity("Denver");
		location.setState("CO");
		
		List<User> users = dao.indexByLocation(location);
		assertNotNull(users);
		assertEquals(11, users.size());
		assertTrue(
			users.stream()
		         .allMatch( (u) -> u.getProfile().getLocation().getCity().equals("Denver") ));
		
	}
	
	@Test
	public void test_indexByConnection() {
		//public List<User> indexByConnection(User connection);
	}
	
	@Test
	public void test_indexByInterest() {
		
		List<User> users = dao.indexByInterest("COFFEE ROASTING");
		assertNotNull(users);
		assertEquals(15, users.size());
		assertTrue(
			users.stream()
		         .allMatch( 
		        		 (u) -> u.getInterests()
		        		         .stream().anyMatch(
		        		        		 (i) -> i.getName().equals("COFFEE ROASTING") )));

	}
	
	@Test
	public void test_indexByInterestCategory() {
		
		String category = "COMPETITION (OUTDOORS)"; //451

		InterestCategory ic = em.find(InterestCategory.class, 6);
		assertNotNull(ic);
		assertEquals(category, ic.getName());
		
		List<User> users = dao.indexByInterestCategory(ic);
		assertNotNull(users);
		assertEquals(451, users.size());
		assertTrue(
			users.stream()
		         .allMatch( 
		        		 (u) -> u.getInterests()
		        		         .stream().anyMatch(
		        		        		 (i) -> i.getCategory().getName().equals(category) )));

	}
	
//	@Test
//	public void test_indexByAvailability() {
//		//* public List<User> indexByAvailability(Availability availability);
//		fail("Not yet implemented");
//	}
	
	@Test
	public void test_indexByPredicate() {
		List<User> users = dao.indexBy( u -> false );
		assertNotNull(users);
		assertEquals(0, users.size());
		
		users = dao.indexBy( u -> true );
		assertNotNull(users);
		assertEquals(1001, users.size());
		
		String fname = "William";
		users = dao.indexBy( u -> u.getProfile().getFirstName().equals(fname) );
		assertNotNull(users);
		assertEquals(8, users.size());
		assertTrue(
				users.stream()
			         .allMatch( 
			        		 (u) -> u.getProfile().getFirstName().equals(fname) ));

		//"WILLIAM" : 8
	}

}
