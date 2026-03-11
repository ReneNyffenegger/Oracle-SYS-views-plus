# Oracle SYS Views Plus

Helper SQL views and scripts that make Oracle data dictionary and dynamic performance views easier to use.

## _defines.sql

`_defines.sql` is used to set SQL*Plus/SQLcl/SQL Developer `define` variables in order to customize some aspects of the generated code in `_install.sql`.
- `pfx`: Prefix for generated object names. I obviously like `tq84_`. Needs to be set to `""` if no prefix is desired.
- `low`: Can be set to `lower(` to make selected object names, owner etc. lowercase.
- `wol`: Needs to be set to `)` if `low` uses `lower(`).
- `ci`: optional ` collate binary_ci` suffix for case-insensitive comparisons (default `""`). Can only be set if [`max_string_size`](https://renenyffenegger.ch/notes/development/databases/Oracle/adminstration/init-parameters/max/string_size) is set to `extended`.
