    //Each fiscal code is related to one user
    fact noFiscalCodeWithoutUser{
    	no fc: FiscalCode | all u: User | !(fc in u.fiscalCode)
    }
    
    //Each UserData is related to one User
    fact noUserDataWithoutUser{
    	no ud: UserData | all u: User | !(ud in  u.uData)
    }
    
    // Each health data corresponds to one user
    fact noHealthDataWithoutAUser{
    	no hd : HealthData | all u: User |
    		!(hd in u.hData)		
    }
    
    //Each acquisition data corresponds to a health data
    fact noAcquisitionDataWithoutHealthData{
    	no aq : AcquisitionData | all hd: HealthData |
    		!(aq in hd.acquisition)		
    }
    
    fact noTimeWithoutAcquisition{
    	no t: Time | all aq: AcquisitionData | !(t in aq.time)
    }
    
    fact noDateWithoutAcquisition{
    	no d: Date | all aq: AcquisitionData | !(d in aq.date)
    }
    
    fact noLocationWithoudAcquisition{
    	no l: Location | all aq: AcquisitionData | !(l in aq.position)
    }
    
    //The fiscal code is unique
    fact uniqueUser{
    	all disj u1, u2: User | ( u1.fiscalCode != u2.fiscalCode)		
    }
    
    //No Health Data Acquire from the same User at the same time
    fact differentAcquisition{
    	no hd1, hd2: HealthData | one u: User |
    		(hd1 in u.hData) and (hd2 in u.hData) and hd1.acquisition = hd2.acquisition
    }
    
    
    //No request for the same event to the same user (This is a simplification for the model, because we do not have a time and a date as identifiers for a request). 
    fact allRequestAreUnique{
    	all disj r1, r2: AmbulanceRequest |
    		r1.valueOutOfRange != r2.valueOutOfRange or r1.bpm != r2.bpm or r1.fiscalCode != r2.fiscalCode or r1.position != r2.position	
    }
    
    
    // The bpm in the request refers to the bpm of a user registered to ASOS so with an age grather than 65 (6 in the model)
    fact requestHasTheBpmOfTheUser{
    	all r: AmbulanceRequest |
    		(r.bpm in AutomatedSOS.registeredUsers.hData.bpm) and (r.fiscalCode in AutomatedSOS.registeredUsers.fiscalCode)
    }
    
    // In the model all the elderly people considered are registered.
    fact allElderlyUserRegistered{
    	all u: User |
    		u.elderUser iff ( u in AutomatedSOS.registeredUsers)
    }
    
    //Ambulance request is attended only if the bpm is out of range
    fact ambulanceOnlyIfBpmOutOfRange{
    	all r: AmbulanceRequest |
    		r.valueOutOfRange.isTrue iff r.bpm.outOfRange 
    }
    
    fact userConnectedIfThereIsARequest{
    	all r :AmbulanceRequest |
    		r.valueOutOfRange.isTrue iff ((r.bpm in AutomatedSOS.registeredUsers.hData.bpm) and (r.fiscalCode in AutomatedSOS.registeredUsers.fiscalCode) )
    }
    
    // Location and fiscalCode of the old user are in the request only if his bpm are out of bound
    fact noLocAndFCWhenBpmOk{
    	all r: AmbulanceRequest |
    		(#r.position != 0 and #r.fiscalCode != 0) iff r.valueOutOfRange.isTrue
    }
    
    fact allUserWithBpmOutOfRangeHasARequest{
    	all u: User, r :AmbulanceRequest |
    		u.hData.bpm.outOfRange implies (u.fiscalCode in r.fiscalCode)
    }