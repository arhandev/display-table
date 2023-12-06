display_table_sources = [
  'main.vala',
  'window.vala',
  'application.vala',
  'Widgets/TableWidget.vala',
  'Utils/ioutil.vala',
  'Utils/util.vala',
  'Models/document.vala',
  'Models/metadata.vala',
  'Models/content.vala',
  'Models/any.vala',
  'Models/type.vala',
  'Utils/error.vala',
]

display_table_deps = [
  dependency('gtk4'),
  dependency('gee-0.8'),
]

gnome = import('gnome')

display_table_sources += gnome.compile_resources('display_table-resources',
  'display_table.gresource.xml',
  c_name: 'display_table'
)

executable('display-table', display_table_sources,
  vala_args: '--target-glib=2.50',  dependencies: display_table_deps,
  install: true,
)
