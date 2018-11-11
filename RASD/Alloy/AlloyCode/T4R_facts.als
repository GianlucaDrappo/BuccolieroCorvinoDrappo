    // All Runners are registered to Track4Run
    fact allRunnerRegisteredToT4R{
    	all r: Runner |
    		r in Track4Run.users
    }
    
    // All runners are different
    fact allRunnersAreDifferent{
    	all disj r1, r2: Runner |
    		r1 != r2
    }
    
    // Each runner can not partecipate to different races at the same time
    fact noRunnerAtDifferentRaceAtTheSameTime{
    	all disj rc1, rc2: Race | no rn : Runner |
    		rc1.date = rc2.date and rc1.time = rc2.time and (rn in rc1.participants) and (rn in rc2.participants)
    }
    
    //No time without race or postion
    fact noTimeWithoutPositionOrRace{
    	no t: Time | all p: Position, r: Race |
    		!(t in p.time) or !(t in r.time)
    }
    
    //All the date are related to a race
    fact noDateWithoutARace{
    	no d: Date | all r: Race|
    		!(d in r.date)
    }
    
    //All the race have an organizer
    fact allOrganizerAssociatedToAtMostOneRace{
    	no r: Race | all o: Organizer |
    		!(r in o.race)
    }
    
    // All the runners partecipate to a race
    fact noRunnersWithoutARace{
    	no r: Runner | all rc: Race | 
    		!(r in rc.participants)
    }
    
    // All the visitor watch a race
    fact noVIsitorWithoutARace{
    	no v: Visitor | all r: Race |
    		!(v.race in r)
    }
    
    // No location not related to any position
    fact noLocWithoutPositionOrRace{
    	no l: Location | all p: Position |
    		!(l in p.location)
    }
    
    //No position not related to any runner
    fact noPosWithoutRunner{
    	no p: Position | all r: Runner |
    		!(p in r.position)
    }
    
    //Position of different runners at different race can be the same
    fact noSamePositionInDifferentRaces{
    	no disj r1,r2: Runner |
    		r1.race != r2.race and ((r1.position in r2.position) or (r2.position in r1.position))
    }
    
    // All paths are related to one race
    fact noPathWithoutRace{
    	no p: Path | all r: Race |
    		!(p in r.path)
    }
    
    // Each race has a unique ID
    fact allRaceDifferentID{
    	all disj r1,r2: Race |
    		r1.id != r2.id
    }
    
    // All the race has one organizer
    fact allRaceOneOrganizer{
    	#Race = #Organizer
    }
    
    // A spectator can see the position of every partecipant
    fact aVisitorLookToEveryPartecipant{
    	all v: Visitor | 
    		#v.participants = #v.race.participants
    }   