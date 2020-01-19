public abstract class Promise implements Queueable, Database.AllowsCallouts {
  public Promise[] promises = new Promise[]{};
  public Object passthrough;

  public Promise(){}

  abstract public void execute();

  public virtual void execute(QueueableContext context){
    execute();
    Finalizer chain = new Chain(this.promises, this.passthrough);
    System.attachFinalizer(chain);
  }
}