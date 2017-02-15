package entities;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class UserTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private User user = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		user = em.find(User.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		user = null;
	}
	
	@Test
	public void test_user_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		
		assertNotNull(user);
		assertEquals(1, user.getId());
		assertEquals(User.Role.USER, user.getRole());
		assertEquals("Geoff", user.getUsername());
		assertEquals("Geoff", user.getPassword());
		assertEquals("ggg@Gmail.com", user.getEmail());
		
		Profile p = user.getProfile();
		assertNotNull(p);
		assertNotNull("Geoff", p.getFirstName());

	}

	@Test
	public void test_interests_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		assertNotNull(user);

		List<Interest> interests = user.getInterests();
		assertNotNull(interests);
		assertEquals(2, interests.size());
		
		Interest i = interests.get(0);
		assertNotNull(i);
		assertEquals("Quidditch", i.getName());

	}
	
	@Test
	public void test_availabilities_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		assertNotNull(user);

		List<Availability> avails = user.getAvailabilities();
		assertNotNull(avails);
		assertEquals(7, avails.size());
		
		Availability a = avails.get(0);
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.MONDAY, a.getDayOfWeek());
	}
	
	@Test
	public void test_connections_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		assertNotNull(user);

		List<User> chums = user.getConnections();
		assertNotNull(chums);
		assertEquals(2, chums.size());
		
		User chum = chums.get(0);
		assertNotNull(chum);
		assertEquals("Matt", chum.getUsername());
	}
	
	@Test
	public void test_groups_mapping() {
		//fail();
	}
	
	@Test
	public void test_destroy_cascade_profile() {
		int uid = 1;
		User user = em.find(User.class, uid);
		assertNotNull(user);
		assertEquals("Geoff", user.getUsername());
		
		Profile profile = user.getProfile();
		assertEquals("Geoff", profile.getFirstName());
		
		int pid = profile.getId();
		
		em.remove(user);
		assertFalse(em.contains(user));
		assertFalse(em.contains(profile));
		
		user = null;
		profile = null;
		
		user = em.find(User.class, uid);
		assertNull(user);
		
		profile = em.find(Profile.class, pid);
		assertNull(profile);
	}

	@Test
	public void test_destroy_cascade_connection() {
		test_destroy_cascade_oneToMany(User.class, 
		                               User::getConnections, 
		                               User::getId);
	}
	
	@Test
	public void test_destroy_cascade_interest() {
		test_destroy_cascade_oneToMany(Interest.class, 
		                               User::getInterests,
		                               Interest::getId);
	}
	
	@Test
	public void test_destroy_cascade_availability() {
		test_destroy_cascade_oneToMany(Availability.class,
		                               User::getAvailabilities,
		                               Availability::getId);
	}
	
	public <T> void test_destroy_cascade_oneToMany(
			Class<T> clazz,
			java.util.function.Function<User,List<T>> listMeth,
			java.util.function.Function<T,Integer> idMeth
			) {
		int uid = 1;
		User user = em.find(User.class, uid);
		assertNotNull(user);
		assertEquals("Geoff", user.getUsername());
		
		List<T> items = listMeth.apply(user);
		assertNotNull(items);
		assertTrue(items.size() > 0 );
		//int iCount = interests.size();
		T item = items.get(0);
		assertNotNull(item);
		assertTrue(em.contains(item));
		//int iid = item.getId();
		//int iid = (Integer)emf.getPersistenceUnitUtil().getIdentifier(item);
		int iid = idMeth.apply(item);
		
		em.remove(user);
		assertFalse(em.contains(user));
		assertFalse(em.contains(item));
		
		user = null;
		item = null;
		
		user = em.find(User.class, uid);
		assertNull(user);
		
		
		item = em.find(clazz, iid);
		assertNull(item);
	}
	
	// connections
	// interests
	// availability
	// (messages)
	
	@Test
	public void test_destroy_cascade_message_sender() {
		int mid = 1;
		Message message = em.find(Message.class, mid);
		assertNotNull(message);

		User sender = message.getSender();
		assertNotNull(sender);
		assertTrue(em.contains(sender));
		
		int uid = sender.getId();
		
		em.remove(sender);
		assertFalse(em.contains(sender));
		assertFalse(em.contains(message));
		
		sender = null;
		message = null;
		
		sender = em.find(User.class, uid);
		assertNull(user);
		
		message = em.find(Message.class, mid);
		assertNull(message);
		
	}
	

	
}
