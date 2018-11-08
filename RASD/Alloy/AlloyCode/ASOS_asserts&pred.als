    assert ambulanceRequestWhenBpmNotOutOfBound{
    	no request: AmbulanceRequest |
    		(request.valueOutOfRange.isTrue and !request.bpm.outOfRange)
    }
    
    assert noAmbulanceWhenBpmOutOfBound{
    	no request: AmbulanceRequest |
    		(!request.valueOutOfRange.isTrue and request.bpm.outOfRange)
    }
    
    pred outOfRange [bpm: Int]{
    	//The limit under the domain assumption are 130 and 40 but for semplifing the model we choose smaller value, 4 and 2
    	bpm > 4 or bpm < 2
    }
    
    //This pred return true if the user is old (We consider old people, who has an age greater or equal than 65,
    //but for semplification in the model we assume 5 as the limit of old people age
    pred elderUser [ u: User ] {
    	u.uData.age > 5
    }
    
    pred show{}