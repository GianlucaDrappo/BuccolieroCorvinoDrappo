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
    sig UserData{}
    
    //The health parameters acquired
    sig HealthData{
    	bpm: Int,
    	dailySteps: Int,
    	acquisition: AcquisitionData
    } { bpm >= 0 and dailySteps >= 0 }
    
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
    
    //The Third Party that can be identified with a VAT number (in case of enterprise) or fiscal code (in case of individual).
    sig ThirdParty {}
    
    one sig Data4Help{
    	users: set User
    }
    
    sig SingleRequest{
    	thirdParty : ThirdParty,
    	fiscalCode: one FiscalCode
    }
    
    sig MultipleRequest{
    	thirdParty : ThirdParty,
    	filterUserData: set UserData,
    	filterAcquisitionData: set AcquisitionData
    }{ #filterUserData > 0 or #filterAcquisitionData > 0}
    
    //Each Reply is associated to one Request and can be positive or negative, and if positive it will return the data requested, otherwise the field data will be empty
    sig SingleReply{
    	associatedRequest: one SingleRequest,
    	answer: Bool,
     	data: lone HealthData
    }
    
    sig MultipleReply{
    	associatedRequest: one MultipleRequest,
    	data: set HealthData
    }