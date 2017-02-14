package data;

import static org.junit.Assert.*;

import java.util.List;
import java.util.stream.Collectors;

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

import entities.Location;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "../WEB-INF/Test-context.xml" })
@WebAppConfiguration
@Transactional
public class LocationDaoTest {

	@Autowired
	private WebApplicationContext wac;

	//@Autowired
	private LocationDAO dao = null;

	@PersistenceContext
	private EntityManager em;

	@Before
	public void setUp() {
		dao = (LocationDAO)wac.getBean("ldao");
	}

	@After
	public void tearDown() {
		dao = null;
		em = null;
		wac = null;
	}
	
	@Test
	public void test_show() {
		Location location = dao.show(22);
		assertNotNull(location);
		assertEquals("Denver", location.getCity());
		assertEquals("CO", location.getState());
		
		location = dao.show(999);
		assertNull(location);
	}
	
	@Test
	public void test_destroy() {
		Location location = dao.show(22);
		assertNotNull(location);
		assertEquals("Denver", location.getCity());
		assertEquals("CO", location.getState());
		
		dao.destroy(22);
		location = dao.show(22);
		assertNull(location);
	}

	@Test
	public void test_update() {
		Location location = dao.show(22);
		assertNotNull(location);
		assertEquals("Denver", location.getCity());

		location.setCity("Glendale");
		dao.update(location.getId(), location);
		
		location = null;
		
		location = dao.show(22);
		assertNotNull(location);
		assertEquals("Glendale", location.getCity());
	}
	
	@Test
	public void test_create() {
		Location newLocation = new Location();
		newLocation.setCity("Commerce City");
		newLocation.setState("CO");
		
		Location location = dao.create(newLocation);
		assertNotNull(location);
		assertTrue(location.getId() > 100);
		assertEquals("Commerce City", location.getCity());
		assertEquals("CO", location.getState());
	}
		
	 @Test
	 public void test_index() {
		 List<Location> locs = dao.index();
		 assertNotNull(locs);
		 assertEquals(100, locs.size());
	 }
	 
	@Test
	public void test_indexByPredicate() {
		List<Location> locs = dao.indexBy( x -> true );
		assertNotNull(locs);
		assertEquals(100, locs.size());
		
		locs = dao.indexBy( x -> false );
		assertNotNull(locs);
		assertEquals(0, locs.size());
		
		locs = dao.indexBy( x -> x.getState().equals("CO") );
		assertNotNull(locs);
		assertEquals(3, locs.size());
		
		String[] cities = locs.stream()
		                       .map(Location::getCity)
		                       .sorted()
		                       .collect(Collectors.toList())
		                       .toArray(new String[0]);
		
		assertArrayEquals(new String[]{"Aurora","Colorado Springs","Denver"}, cities);
	}

}
