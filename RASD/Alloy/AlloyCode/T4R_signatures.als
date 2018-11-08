    // This service is under Data4Help so all the Track4Run users are user also of Data4Help
    one sig Track4Run{
    	users: some Runner
    }
    
    sig Runner{
    	id: Int,
    	// For semplification we consider just the partecipation to one race
    	race: Int,
    	position: some Position
    }
    
    sig Visitor{
    	// The followed race (we assume for the model that a visitor can follow just a race
    	race: Race,
    	participants: some Runner
    } {
    	race.id = participants.race
    }
    
    sig Organizer{
    	// We assume that an organizer could organize just one race, to semplify the model.
    	race: Race
    }
    
    sig Race{
    	id: Int,
    	path: Path,
    	date: Date,
    	time: Time,
    	place: Place,
    	participants: some Runner
    }{
    	participants.race = id and #participants > 1
    }
    
    sig Position{
    	location: Location,
    	time: Time
    }
    
    // A path of a race
    sig Path{}
    
    //The date of the race
    sig Date{}
    
    //The time of the race
    sig Time{}
    
    //The place of the race
    sig Place{}
    
    // The location of a partecipant
    sig Location{}
