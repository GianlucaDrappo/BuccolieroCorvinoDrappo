open util/boolean
    
    sig User {
    	fiscalCode: one FiscalCode,
    	uData: one UserData,
    	hData: some HealthData
    }{
    	no disj hd1, hd2: HealthData |
    		hd1.acquisition = hd2.acquisition
    }
    
    sig FiscalCode{}
    
    // Gender and age.
    sig UserData{
    	age : Int
    } {
    	age > 0
    }
    
    //The health parameters acquired
    sig HealthData{
    	bpm: Int,
    	dailySteps: Int,
    	acquisition: AcquisitionData
    } { bpm > 0 and dailySteps > 0 }
    
    //The information of the acquisition
    sig AcquisitionData{
    	position: Location,
    	time: Time,
    	date: Date
    }
    
    //The location of gathering
    sig Location{}
    
    //The date of gathering
    sig Date{}
    
    //The time of sampling
    sig Time{}
    
    one sig AutomatedSOS{
    	registeredUsers : set User
    } { 
    	//All the users registered to AutomatedSOS are elderly people
    	//(Therefore as it is expressed in the domain assumption, with an age grather than 65 years but for model semplification we use 5 as limit)
    	registeredUsers.elderUser
    }
    
    sig AmbulanceRequest{
    	valueOutOfRange: Bool,	
    	bpm : Int,
    	fiscalCode: lone FiscalCode,
    	position: lone Location
    }
    
    check ambulanceRequestWhenBpmNotOutOfBound for 5
    check noAmbulanceWhenBpmOutOfBound for 5
    run show for 5
    
    
