/*
 *  libfork, a base library for the Fork language
 *  Copyright (C) Marco Cilloni <marco.cilloni@yahoo.com> 2015, 2016
 *
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *  Exhibit B is not attached; this software is compatible with the
 *  licenses expressed under Section 1.12 of the MPL v2.
 *
 */


#include <dlfcn.h>

#include <stdbool.h>
#include <stdint.h>
#include <string.h>


void* load_lib(uint8_t *name, uint8_t* err, uintptr_t len) {
  void* handl = dlopen((char*) name, RTLD_LAZY); //improve this

  if (handl == NULL) {
    strncpy((char*) err, dlerror(), len);
    err[len - 1] = '\0';

    return NULL;
  }

  return handl;
}


void* load_sym(void* handl, uint8_t* name, uint8_t* err, uintptr_t len) {
  dlerror(); //discard old errors

  void* sym = dlsym(handl, (char*) name);

  char* dlErr = dlerror();

  if (dlErr != NULL) {
    strncpy((char*) err, dlErr, len);
    err[len - 1] = '\0';

    return NULL;
  }

  return sym;
}


bool free_lib(void* handl, uint8_t* err, uintptr_t len) {
  if (dlclose(handl) != 0) {
    strncpy((char*) err, dlerror(), len);
    err[len - 1] = '\0';

    return false;
  }

  return true;
}
