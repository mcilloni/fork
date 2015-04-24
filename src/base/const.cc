/*
 *  Second Step - Experimental Fork Compiler
 *  Copyright (C) Marco Cilloni <marco.cilloni@yahoo.com> 2014, 2015
 *
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *  Exhibit B is not attached; this software is compatible with the
 *  licenses expressed under Section 1.12 of the MPL v2.
 *
 */

#include <cinttypes>
#include <cstdio>

extern "C" {

auto stderr_file(void) -> FILE* {
  return stderr;
}

auto stdin_file(void) -> FILE* {
  return stdin;
}

auto stdout_file(void) -> FILE* {
  return stdout;
}

auto outint(uint64_t n) -> void {
  printf("%" PRIu64, n);
}

}
