@isTest
public with sharing class DemoPromiseTests {
  
  @TestSetup
  static void makeData(){
      Account account = new Account(
      name = 'TestAccount',
      ShippingStreet = '0'
    );

    insert account;
  }

  @isTest
  private static void basicE2ETest(){
    Account account = [SELECT Id FROM Account WHERE name = 'TestAccount' LIMIT 1];
    Test.startTest();
    DemoPromise dp = new DemoPromise(account.id);
    dp.promises = new List<Promise>{new DemoPromise(account.id), new DemoPromise(account.id)};
    System.enqueueJob(dp);
    Test.stopTest();

    Account checkAccount = [SELECT ShippingStreet FROM Account WHERE id = :account.id LIMIT 1];
    System.assertEquals(3, Integer.valueOf(checkAccount.shippingStreet), 
      'Expected 3 instances of the queuable to have been run, each incrementing by 1');
  }

  @isTest
  private static void promiseListConstructor(){
    Account account = [SELECT Id FROM Account WHERE name = 'TestAccount' LIMIT 1];
    Test.startTest();
    DemoPromise dp = new DemoPromise(account.id, new List<Promise>{new DemoPromise(account.id), new DemoPromise(account.id)});
    System.enqueueJob(dp);
    Test.stopTest();

    Account checkAccount = [SELECT ShippingStreet FROM Account WHERE id = :account.id LIMIT 1];
    System.assertEquals(3, Integer.valueOf(checkAccount.shippingStreet), 
      'Expected 3 instances of the queuable to have been run, each incrementing by 1');
  }
}