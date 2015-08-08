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

#include <errno.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>

#include <sys/stat.h>


int64_t open_readfile(char* filename, char* error, uintptr_t len) {
  int64_t fd = open(filename, O_RDONLY);

  if (fd < 0) {
    strerror_r(errno, error, len);
    return -1;
  }

  return fd;
}


int64_t open_writefile(char* filename, char* error, uintptr_t len) {
  int64_t fd = creat(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

  if (fd < 0) {
    strerror_r(errno, error, len);
    return -1;
  }

  return fd;
}


uint8_t stream_closefileInternal(int64_t fd, char* error, uintptr_t len) {
  int res = close(fd);

  if (res == -1) {
    strerror_r(errno, error, len);
    return 0;
  }

  return 1;
}


intptr_t stream_readfileInternal(int64_t fd, void* data, intptr_t len, char* error, uintptr_t errl) {
  intptr_t res = read(fd, data, len);

  if (res < 0) {
   strerror_r(errno, error, errl);
   return -1;
  }

  return res;
}


intptr_t stream_writefileInternal(int64_t fd, void* data, intptr_t len, char* error, uintptr_t errl) {
  intptr_t res = write(fd, data, len);

  if (res < 0) {
    strerror_r(errno, error, errl);
    return -1;
  }

  return res;
}


int8_t stream_closeFileInternal(int64_t fd) {
  return close(fd) == 0;
}


uintptr_t path_exists(char* filename) {
  struct stat st;

  if (!stat(filename, &st)) {
    if (S_ISDIR(st.st_mode)) {
      return 2U;
    }

    return 1U;
  }

  return 0U;
}


bool path_listAll(char* path, void* appendTo, void (*appender)(void* to, char* elem), char* error, uintptr_t errl) {
  DIR* dp = opendir(path);
  if (dp == NULL) {
    strerror_r(errno, error, errl);
    return false;
  }

  extern char* txt$strclone(char*);
  extern bool txt$strequals(const char*,const char*);
  struct dirent *ep;

  while ((ep = readdir(dp))) {
    char* name = txt$strclone(ep->d_name);

    if (!txt$strequals(name, ".") && !txt$strequals(name, "..")) {
      appender(appendTo, name);
    } else {
      free(name);
    }

  }

  closedir(dp);

  return true;
}
