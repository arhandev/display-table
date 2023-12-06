namespace DisplayTable{
    public class TableWidget : Gtk.Widget{
        Gtk.Frame frame;
        Gtk.Grid grid;
        private string[] columns = {"No", "Nama", "NIM"};
        
        construct{
            set_layout_manager_type(typeof(Gtk.BinLayout));
        }
        
        public TableWidget(){
            var layout = new Gtk.BinLayout();
            this.set_layout_manager(layout);
            
            frame = new Gtk.Frame(null);
            
            grid = new Gtk.Grid();
            grid.set_column_homogeneous(true);
            int index = 0;
            foreach(string column in columns){
                    var labelTitle = new Gtk.Label (column);
                    grid.attach (labelTitle, index, 0);
                    index +=1;
                }
            frame.child = grid;
            frame.set_parent (this);
            
        }
         protected override void dispose(){
            base.dispose();
            frame.dispose();
        }
    }
}