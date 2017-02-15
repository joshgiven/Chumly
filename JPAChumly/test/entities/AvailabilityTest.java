package entities;

import static org.junit.Assert.assertEquals;
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

import entities.Availability.DayOfWeek;

public class AvailabilityTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Availability availability = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		availability = em.find(Availability.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		availability = null;
	}
	
	@Test
	public void test_availability_mapping() {
		Availability a = em.find(Availability.class, 1);
		
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.MONDAY, a.getDayOfWeek());
		assertEquals(true, a.isFreeAM());
		assertEquals(true, a.isFreePM());
	}
	
	@Test
	public void test_persist() {
		
		String s = 
				"SELECT a "+
				"FROM Availability a "+
				"WHERE a.dayOfWeek = :day "+
				"  AND a.freeAM = :am "+
				"  AND a.freePM = :pm "
				;
		
		List<Availability> avails = 
				em.createQuery(s, Availability.class)
				.setParameter("day", DayOfWeek.FRIDAY)
				.setParameter("am",  false)
				.setParameter("pm",  false)
				.getResultList();
		
		assertNotNull(avails);
		
		int count = avails.size();
		
		
		Availability a = new Availability();
		
		a.setDayOfWeek(DayOfWeek.FRIDAY);
		a.setFreeAM(false);
		a.setFreePM(false);
		
		em.persist(a);
		
		assertTrue(em.contains(a));

		avails = 
				em.createQuery(s, Availability.class)
				.setParameter("day", DayOfWeek.FRIDAY)
				.setParameter("am",  false)
				.setParameter("pm",  false)
				.getResultList();
		
		assertNotNull(avails);
		assertEquals(count+1, avails.size());
		
		
//		System.out.println(emf.getPersistenceUnitUtil().getIdentifier(a));
//		Integer id = (Integer)emf.getPersistenceUnitUtil().getIdentifier(a);
//		//Integer id = em.createQuery("SELECT LAST_INSERT_ID()", Integer.class).getSingleResult();
//		assertNotNull(id);
//
//		a = null;
//		
//		a = em.find(Availability.class, id);
//		assertNotNull(a);
//		assertEquals(Availability.DayOfWeek.FRIDAY, a.getDayOfWeek());
//		assertEquals(false, a.isFreeAM());
//		assertEquals(false, a.isFreePM());
	}

	@Test
	public void test_update() {
		Availability a = em.find(Availability.class, 1);
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.MONDAY, a.getDayOfWeek());

		a.setDayOfWeek(DayOfWeek.FRIDAY);
		a = null;
		
		a = em.find(Availability.class, 1);
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.FRIDAY, a.getDayOfWeek());
		assertEquals(true, a.isFreeAM());
		assertEquals(true, a.isFreePM());
	}
	
	@Test
	public void test_destroy() {
		Availability a = em.find(Availability.class, 1);
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.MONDAY, a.getDayOfWeek());
		assertEquals(true, a.isFreeAM());
		assertEquals(true, a.isFreePM());
		
		em.remove(a);
		
		a = null;
		a = em.find(Availability.class, 1);
		assertNull(a);
	}
	
}
