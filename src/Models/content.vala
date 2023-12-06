using Gee;
using GLib;

public class DisplayTable.Content: GLib.Object {

    public int64 createdOn { get; set;}
    public int64 updatedOn { get; set;}
    //keys are column heading, while values are the data rows
    private Gee.Map<string, Any> map;

    //we need a reference to parent class
    private weak Document doc;

     /**
     * Default constructor instantiate the class
     * immediately set unique id to class
     * the class must be parameterized
     */
    public Content(Document doc) {
        map = new HashMap<string, Any>();
        this.createdOn = new GLib.DateTime.now_local().to_unix();
        this.doc = doc;

    }


    /*
     * Concatenate all char as string
     */

    public Any? getEntry(string attributeName){
        
        return map.get(attributeName);
    }

    public float getFloatEntry(string attributeName) throws TypeError{
        //get Metadata
        Metadata meta = this.doc.metadata;
        KeyMetadata keyMeta = meta.heading.get(attributeName);
        if(keyMeta.type == AttributeType.NUMERIC){
            Any<float?> any = this.getEntry(attributeName);
            return any.val;
        }
        throw new TypeError.NOT_FLOAT("The data wasn't a float");
    }

    public double getDoubleEntry(string attributeName) throws TypeError{
        Metadata meta = this.doc.metadata;
        KeyMetadata keyMeta = meta.heading.get(attributeName);
        if(keyMeta.type == AttributeType.REAL){
            Any<double?> any = this.getEntry(attributeName);
            return any.val;
        }
        throw new TypeError.NOT_DOUBLE("The data wasn't a double");
    }

    public string getStringEntry(string attributeName) throws TypeError{
        Metadata meta = this.doc.metadata;
        KeyMetadata keyMeta = meta.heading.get(attributeName);
        if(keyMeta.type == AttributeType.NOMINAL){
            Any<string> any = this.getEntry(attributeName);
            return any.val;
        }
        throw new TypeError.NOT_NOMINAL("The data wasn't a nominal");
    }

    public void setEntry(string attributeName, Any any){
        map.set(attributeName, any);
        this.updatedOn = new GLib.DateTime.now_local().to_unix();
        doc.updatedOn = this.updatedOn;
    }

}
