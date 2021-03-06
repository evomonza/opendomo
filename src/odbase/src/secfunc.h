/*****************************************************************************
 *  This file is part of the OpenDomo project.
 *  Copyright(C) 2011 OpenDomo Services SL
 *  
 *  Daniel Lerch Hostalot <dlerch@opendomo.com>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *****************************************************************************/



#ifndef __SECFUNC_H__
#define __SECFUNC_H__

#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

void sstrncpy(char *dst, const char *src, size_t size);
void sstrncat(char *dst, const char *src, size_t size);

int is_valid_utf8(const unsigned char *input);


typedef struct
{
   FILE *read_fd;
   FILE *write_fd;
   pid_t child_pid;
} 
spipe_t;

spipe_t *spopen(const char *path, char *const argv[], char *const envp[]);
int spclose(spipe_t *p);



#endif




