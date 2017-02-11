package data;

import java.util.List;
import java.util.function.Predicate;

import entities.Location;

public interface LocationDAO {
	public Location show(int id);
	public Location create(Location film);
	public Location update(int id, Location film);
	public boolean destroy(int id);

	public List<Location> index();
	public <T> List<Location> indexBy(Predicate<T> filter);
}
