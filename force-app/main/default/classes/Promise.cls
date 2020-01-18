public abstract class Promise implements Queueable, Database.AllowsCallouts {
  public Promise[] promises = new Promise[]{};

  public Promise(){
  }

  public Promise(Promise[] promises){
    this.promises = promises;
  } 

  // This must be overridden by the implementing class
  public virtual void execute(){}

  public virtual void execute(QueueableContext context){
    System.debug('Does this run?');
    Finalizer chain = new Chain(this.promises);
    System.attachFinalizer(chain);
    execute();
  }

}
