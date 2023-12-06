/* application.vala
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
    public class Application : Gtk.Application {
        public Application () {
            Object (application_id: "org.example.App", flags: ApplicationFlags.FLAGS_NONE);
        }

        construct {
            ActionEntry[] action_entries = {
                { "pick-file", this.on_pick_file },
                { "about", this.on_about_action },
                { "preferences", this.on_preferences_action },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
            this.set_accels_for_action ("app.quit", {"<primary>q"});
        }

        public override void activate () {
            base.activate ();
            var win = this.active_window;
            if (win == null) {
                win = new DisplayTable.Window (this);
            }
            win.present ();
        }

        private void on_about_action () {
            string[] authors = { "Farhan Abdul Hamid" };
            Gtk.show_about_dialog (this.active_window,
                                   "program-name", "display-table",
                                   "authors", authors,
                                   "version", "0.1.0");
        }
        private void on_pick_file () {
            //  this.active_window().buildTable();
            //  Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog("Pilih File", this.active_window, Gtk.FileChooserAction.OPEN);

        }

        private void on_preferences_action () {
            message ("app.preferences action activated");
        }
    }
}
