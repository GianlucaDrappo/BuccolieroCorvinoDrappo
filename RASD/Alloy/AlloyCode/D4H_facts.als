    //Each fiscal code is related to only one user
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
    
    //We assume that all the users considered are registered
    fact allUsersRegistered {
    	all u: User |
    		u in Data4Help.users
    }
    
    //The fiscal code is unique
    fact uniqueUser{
    	all disj u1, u2: User | ( u1.fiscalCode != u2.fiscalCode)		
    }
    
    // The third party's ID is unique
    fact uniqueThirdParty{
    	all disj tp1, tp2 : ThirdParty | tp1 != tp2
    }
    
    //No Health Data acquired from the same User at the same time
    fact differentAcquisition{
    	no hd1, hd2: HealthData | one u: User |
    		(hd1 in u.hData) and (hd2 in u.hData) and hd1.acquisition = hd2.acquisition
    }
    
    
    // SINGLE REQUESTS
    
    fact allSingleReqHasAReply{
    	#SingleRequest = #SingleReply
    }
    
    fact uniqueSingleRequest{
    	all disj r1, r2: SingleRequest | r1 != r2
    }
    
    //Each single request has a single reply
    fact singleReplyUnique{
    	all disj srp1,srp2 : SingleReply |
    		srp1.associatedRequest != srp2.associatedRequest
    }
    
    // A third party can not request the same fiscal code in different request
    fact noMultipleSingleRequestFromTheSameThirdPartyToASingleUser{
    	no disj srq1, srq2: SingleRequest |
    		srq1.thirdParty = srq2.thirdParty and srq1.fiscalCode = srq2.fiscalCode
    }
    
    
    //This fact certificates that a reply has data of the requested user if the answer of the user is positive.
    fact singleRequestAccepted {
    	all srp: SingleReply |  one u: User |
    		u.fiscalCode = srp.associatedRequest.fiscalCode and (#srp.data > 0 iff srp.answer.isTrue) and(srp.answer.isTrue iff (u.hData in srp.data ))			
    }

    
    // MULTIPLE REQUESTS
    
    fact allMulReqHasAReply{
    	#MultipleRequest = #MultipleReply
    }
    
    //All the requests are different
    fact uniqueMultipleRequest {
    	all disj r1, r2: MultipleRequest | r1 != r2
    }
    
    //Each multiple request has a multiple reply
    fact multipleReplyUnique{
    	all disj mrp1,mrp2 : MultipleReply |
    		mrp1.associatedRequest != mrp2.associatedRequest 
    }
    
    
    //The fact certificates that a reply for a multiple request contains data just if the number of users with that filter is grater than 1000 (to verify the assertion we use 2 instead 1000).
    fact multipleRequestAccepted {
    	all mrp : MultipleReply | all u: User |
    		( (u.hData in mrp.data and #mrp.data > 0 ) iff 
    			#usersWithCorrectFilters[mrp.associatedRequest.filterUserData, mrp.associatedRequest.filterAcquisitionData] > 2)
    }
    
    //This function gives the subset of user of Data4Help with the data requested. 
    fun usersWithCorrectFilters [ userFilter: UserData, acqFilter: AcquisitionData ] : set User {
    	{u : Data4Help.users | (u.uData = userFilter) or (u.hData.acquisition = acqFilter)}
    }