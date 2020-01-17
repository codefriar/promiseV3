public virtual class Promise implements Queueable, Database.AllowsCallouts {
  public Promise[] promises = new Promise[]{};

  public Promise(){
  }

  public Promise(Promise[] promises){
    this.promises = promises;
  } 

  // This must be overridden by the implementing class
  public virtual void execute(QueueableContext context){}

}
