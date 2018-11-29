    // This assertion check if a visitor looking to a race track only the partecipants to that race.
    assert noVisitorLookingToParticipantsOfDifferentRace{
    	no v:Visitor |
    		!(v.participants in v.race.participants)
    }
    
    // This predicates allow to visualize the model
    pred show{}