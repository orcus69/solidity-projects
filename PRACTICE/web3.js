(async ()=> {
    await deposit(1);
})();

var eventCapture = contract.events.Deposit(function(error, result){
    if(!error){
        alert(
            "Deposit successfull! "+"\n\n"+
            "User Address: "+result.returnValues.user+"\n"+
            "Amount: "+result.returnValues.amount+"\n"
        )
    }
})