/*
 *  libfork, a base library for the Fork language
 *  Copyright (C) Marco Cilloni <marco.cilloni@yahoo.com> 2014, 2015
 *
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *  Exhibit B is not attached; this software is compatible with the
 *  licenses expressed under Section 1.12 of the MPL v2.
 *
 */

#undef _GNU_SOURCE

#include <cerrno>
#include <fcntl.h>
#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <unistd.h>
#include <dirent.h>

#include <sys/stat.h>

extern "C" {

auto open_readfile(char* filename, char* error, uintptr_t len) -> int64_t {
  int64_t fd = open(filename, O_RDONLY);

  if (fd < 0) {
    strerror_r(errno, error, len);
    return -1;
  }

  return fd;
}


auto open_writefile(char* filename, char* error, uintptr_t len) -> int64_t {
  int64_t fd = creat(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

  if (fd < 0) {
    strerror_r(errno, error, len);
    return -1;
  }

  return fd;
}

auto stream_closefileInternal(int64_t fd, char* error, uintptr_t len) -> uint8_t {
  int res = close(fd);

  if (res == -1) {
    strerror_r(errno, error, len);
    return 0;
  }

  return 1;
}

auto stream_readfileInternal(int64_t fd, void* data, intptr_t len, char* error, uintptr_t errl) -> intptr_t {
  intptr_t res = read(fd, data, len);

  if (res < 0) {
   strerror_r(errno, error, errl);
   return -1;
  }

  return res;
}

auto stream_writefileInternal(int64_t fd, void* data, intptr_t len, char* error, uintptr_t errl) -> intptr_t {
  intptr_t res = write(fd, data, len);

  if (res < 0) {
    strerror_r(errno, error, errl);
    return -1;
  }

  return res;
}

auto stream_closeFileInternal(int64_t fd) -> int8_t {
  return close(fd) == 0;
}


auto path_exists(char* filename) -> uintptr_t {
  struct stat st;

  if (!stat(filename, &st)) {
    if (S_ISDIR(st.st_mode)) {
      return 2U;
    }

    return 1U;
  }

  return 0U;
}


auto path_listAll(char* path, void* appendTo, void (*appender)(void* to, char* elem), char* error, uintptr_t errl) -> bool {
  auto dp = opendir(path);
  if (dp == nullptr) {
    strerror_r(errno, error, errl);
    return false;
  }

  extern char* strclone(char*);
  extern bool strequals(const char*,const char*);
  dirent *ep;

  while ((ep = readdir(dp))) {
    auto name = strclone(ep->d_name);

    if (!strequals(name, ".") && !strequals(name, "..")) {
      appender(appendTo, name);
    } else {
      free(name);
    }

  }

  closedir(dp);

  return true;
}

}
