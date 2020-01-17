public class DemoPromise extends Promise {

  public override void execute(QueueableContext context){
    Finalizer chain = new Chain(this.promises);
    System.attachFinalizer(chain);
    System.debug('Async Work Completed!');
  }

}
