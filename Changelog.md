
v1.4.1 / 2017-10-29
===================

  * BPH-13 Tests fail on zsh 5.0.7 (var assignment bugs in ZUnit).
  * BPH-12 Fix encode/decode for zsh 5.3+.
  * BPH-11 Update README to revise Build Status to include bash/zsh versions.

v1.4.0 / 2017-10-22
===================

  * BPH-10 Update README to add zsh testing info.
  * BPH-9 Add zsh compatibility.

v1.3.0 / 2017-09-11
===================

  * Update README to remove hexdump dependency info.
  * Refactor __bphp_encode() to remove dependency on hexdump and improve
    performance.

v1.2.2 / 2017-09-10
===================

  * Fix valueForKeyFakeAssocArray() to return status 1 (value empty) or 2 (key
    not found).

v1.2.1 / 2017-09-10
===================

  * Fix valueForKeyFakeAssocArray() to return status 1 when key not found.

v1.2.0 / 2017-09-10
===================

  * Update README with RETVAL section.
  * Refactor to support RETVAL global var return value convention.

v1.1.1 / 2017-05-24
===================

  * Update README with Dependencies section.
  * Add __bph_version() function.

v1.1.0 / 2016-10-21
===================

  * Add prettyDumpFakeAssocArray() function.
  * Add keysForFakeAssocArray() function.
  * Add support for zsh.

v1.0.0 / 2016-09-20
===================

  * Add Changelog.


v0.9.0 / 2016-09-20
===================

  * First completed implementation.
  * Initial commit
