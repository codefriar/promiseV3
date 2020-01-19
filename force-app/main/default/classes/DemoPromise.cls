public with sharing class DemoPromise extends Promise {

  public class DemoPromiseException extends exception {}

  Id accountId;

  public DemoPromise(Id accountId){
    this.accountId = accountId;
  }

  public DemoPromise(Id accountId, Promise[] promises){
    this.accountId = accountId;
    this.promises = promises;
  }

  public override void execute(){
    Account acct = [SELECT name, shippingStreet FROM Account WHERE id = :this.accountId];
    Integer x = Integer.valueOf(acct.shippingStreet);
    acct.shippingStreet = String.valueOf(x+1);
    if(this.passthrough != null){
      this.passthrough = 1 + (Integer) this.passthrough;
      acct.billingStreet = String.valueOf(this.passthrough);
    }
    update acct;
    System.debug('Async Work Completed!');
  }

}
