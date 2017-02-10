package entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Availability {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String dayOfWeek;
	
	private boolean freeAM;
	
	private boolean freePM;

	
	
	public Availability() { }
}
