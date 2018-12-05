    // This assert verify the absence of request with bpm not out of bound
    assert ambulanceRequestWhenBpmNotOutOfBound{
    	no request: AmbulanceRequest |
    		(request.valueOutOfRange.isTrue and !request.bpm.outOfRange)
    }
    
    // This assert verify that when the bpm of a user are out of bound there is an ambulance request
    assert noAmbulanceWhenBpmOutOfBound{
    	no request: AmbulanceRequest |
    		(!request.valueOutOfRange.isTrue and request.bpm.outOfRange)
    }
    
    pred outOfRange [bpm: Int]{
    	//The limit under the domain assumption are 130 and 40 but for simplifying the model we choose smaller values, 4 and 2
    	bpm > 4 or bpm < 2
    }
    
    //This pred returns true if the user is old (We consider old people, who have an age greater or equal than 65,
    //but for simplification in the model we assume 5 as the limit of old people age
    pred elderUser [ u: User ] {
    	u.uData.age > 5
    }
    
    pred show{}