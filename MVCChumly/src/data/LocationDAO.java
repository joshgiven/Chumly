package data;

import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

import entities.Location;

public interface LocationDAO {
	public Location show(int id);
	public Location create(Location location);
	public Location update(int id, Location location);
	public boolean destroy(int id);

	public List<Location> index();
	public List<Location> indexBy(Predicate<Location> filter);
	
	public Map<String, List<Location>> mapByState();
}
