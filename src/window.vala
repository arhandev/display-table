/* window.vala
 *
 * Copyright 2023 Farhan Abdul Hamid
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name(s) of the above copyright
 * holders shall not be used in advertising or otherwise to promote the sale,
 * use or other dealings in this Software without prior written
 * authorization.
 */

namespace DisplayTable {
    [GtkTemplate (ui = "/org/example/App/window.ui")]
    public class Window : Gtk.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Box main_box;
        [GtkChild]
        private unowned Gtk.Button file_choose;
        [GtkChild]
        private unowned Gtk.Button delete_data;
        //  [GtkChild]
        public Gtk.Grid table;
        public Document doc;

        construct{
            file_choose.clicked.connect(openFileDialog);
            delete_data.clicked.connect(clearGrid);
        }
        public Window (Gtk.Application app) {
            Object (application: app);

            var css_provider = new Gtk.CssProvider ();
            string path = "/home/arhandev/Projects/display-table/src/style.css";
            css_provider.load_from_path (path);
            Gtk.StyleContext.add_provider_for_display (Gdk.Display.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
            //  TableWidget table = new TableWidget ();
            //  main_box.append(table);
            
        }

        public void openFileDialog(){
            message ("Pick File");
            Gtk.FileChooserDialog file_chooser = new Gtk.FileChooserDialog("Upload Data", this, Gtk.FileChooserAction.OPEN, "_Cancel", Gtk.ResponseType.CANCEL, "_Open", Gtk.ResponseType.ACCEPT);
            file_chooser.present ();
            file_chooser.response.connect((dialog, response)=>{
                if(response == Gtk.ResponseType.ACCEPT){
                    File selected = file_chooser.get_file();
                    this.buildTable(selected);
                    file_chooser.destroy();
                }
                if(response == Gtk.ResponseType.CANCEL){
                    file_chooser.destroy();
                }
                
            });
        }
            
        private void buildTable(File selected){
            if(doc != null){
                this.clearGrid();
            }
            doc = IOUtil.read_file (selected);
            table = new Gtk.Grid();
            table.set_column_homogeneous(true);
            int index = 0;
            foreach(var entry in doc.metadata.heading){
                var labelTitle = new Gtk.Label (entry.key);
                labelTitle.add_css_class ("border");
                labelTitle.add_css_class ("label_text");
                table.attach (labelTitle, index, 0);
                index +=1;
            }

            int firstIndex = 1;
            int secondIndex = 0;

            foreach(var entry in doc.getData()){
                foreach(var column in doc.metadata.heading){
                    DisplayTable.AttributeType type = doc.metadata.heading.get(column.key).type;
                    string text = "";
                    switch(type){
                        case AttributeType.NOMINAL:
                            text = entry.getStringEntry(column.key);
                            break;
                            case AttributeType.NUMERIC:
                            text = entry.getFloatEntry(column.key).to_string ();
                            break;
                            case AttributeType.REAL:
                            text = entry.getDoubleEntry(column.key).to_string ();
                            break;
                    }
                    var labelTitle = new Gtk.Label (text);
                    labelTitle.add_css_class ("border");
                    labelTitle.add_css_class ("label_text");
                    table.attach (labelTitle, secondIndex, firstIndex);
                    secondIndex+=1;
                }
                firstIndex += 1;
                secondIndex = 0;
            }

            main_box.append(table);
        }

        private void clearGrid(){
            if(doc == null){
                return;
            }
            doc = null;
            Gtk.Widget *lastChild = main_box.get_last_child();
            main_box.remove(lastChild);
        }
            
    }
}

