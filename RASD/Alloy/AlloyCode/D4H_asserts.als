    // This assertion check if a single request returns data to the third party if and only if the user's answer is positive
    assert singleRequest {
    	no r: SingleReply | one u: User |
    		(!r.answer.isTrue) and  r.associatedRequest.fiscalCode = u.fiscalCode  and (u.hData in r.data)
    }
    
    // This assertion check if a multiple request returns data if and only if the number of user with a
    // specific requirement is grather than 1000 (in the model we used 2 to semplify the check)
    assert multipleRequest{
    	no r: MultipleReply | some u: User |
    		(u.hData in r.data and #r.data>0) and 
    			#usersWithCorrectFilters[r.associatedRequest.filterUserData, r.associatedRequest.filterAcquisitionData] =< 2
    }
    
    // This pred show the model
    pred show{}