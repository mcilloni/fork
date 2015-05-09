/*
 *  libfork, a base library for the Fork language
 *  Copyright (C) Marco Cilloni <marco.cilloni@yahoo.com> 2015
 *
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *  Exhibit B is not attached; this software is compatible with the
 *  licenses expressed under Section 1.12 of the MPL v2.
 *
 */


#include <dlfcn.h>

#include <cstdint>
#include <cstring>


extern "C" {


auto load_lib(uint8_t *name, uint8_t* err, uintptr_t len) -> void* {
  auto handl = dlopen(reinterpret_cast<char*>(name), RTLD_LAZY); //improve this

  if (handl == nullptr) {
    std::strncpy(reinterpret_cast<char*>(err), dlerror(), len);
    err[len - 1] = '\0';

    return nullptr;
  }

  return handl;
}


auto load_sym(void* handl, uint8_t* name, uint8_t* err, uintptr_t len) -> void* {
  dlerror(); //discard old errors

  auto sym = dlsym(handl, reinterpret_cast<char*>(name));

  auto dlErr = dlerror();

  if (dlErr != nullptr) {
    std::strncpy(reinterpret_cast<char*>(err), dlErr, len);
    err[len - 1] = '\0';

    return nullptr;
  }

  return sym;
}


auto free_lib(void* handl, uint8_t* err, uintptr_t len) -> bool {
  if (dlclose(handl) != 0) {
    std::strncpy(reinterpret_cast<char*>(err), dlerror(), len);
    err[len - 1] = '\0';

    return false;
  }

  return true;
}


}
