package data;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entities.Location;


@Transactional
@Repository
public class LocationDAOImpl implements LocationDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Location show(int id) {
		
		Location loc = (em.find(Location.class, id));
		
		return loc;
	}

	@Override
	public Location create(Location location) {
		
		em.persist(location);
		em.flush();
		
		return location;
	}

	@Override
	public Location update(int id, Location location) {
		Location loc = (em.find(Location.class, id));
		loc.setCity(location.getCity());
		loc.setState(location.getState());
		
		em.flush();
		
		return loc;
	}

	@Override
	public boolean destroy(int id) {
		Location loc = (em.find(Location.class, id));
		
		try{
			em.remove(loc);
			em.flush();
			return true;
		}
		catch(Exception e){
			return false;
			
		}
	}

	@Override
	public List<Location> index() {
		List<Location> results = null;
		try {
			String queryString = "SELECT l FROM Location l";
			results = em.createQuery(queryString, Location.class).getResultList();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return results;
		}
		return results;
	}

	@Override
	public List<Location> indexBy(Predicate<Location> filter) {
		List<Location> results = new ArrayList<>();
		for (Location location : index()) {
			if(filter.test(location)){
				results.add(location);
			}
		}
		return results;
	}

}
