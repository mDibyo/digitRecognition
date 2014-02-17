/*
 * PROJ1-1: YOUR TASK B CODE HERE
 * 
 * Feel free to define additional helper functions.
 */

#include <stdlib.h>
#include <stdio.h>
#include "sparsify.h"
#include "utils.h"

/* Returns a NULL-terminated list of Row structs, each containing a NULL-terminated list of Elem structs.
 * See sparsify.h for descriptions of the Row/Elem structs.
 * Each Elem corresponds to an entry in dense_matrix whose value is not 255 (white).
 * This function can return NULL if the dense_matrix is entirely white.
 */

Row *create_row(int y, Elem *elems) {
	Row *new = malloc(sizeof(Row));
  if(!new) allocation_failed();
	new->y = y;
	new->elems = elems;
	new->next = NULL;
	return new;
}

Elem *create_elem(int x, unsigned char value) {
	Elem *new = malloc(sizeof(Elem));
  if(!new) allocation_failed();
	new->x = x;
	new->value = value;
	new->next = NULL;
	return new;
}

Row *dense_to_sparse(unsigned char *dense_matrix, int width, int height) {
  Row *rows = NULL, *row_pointer;
  Elem *elems, *elems_pointer;
  for (int y = 0; y < height; y++) {
  	elems = NULL;
  	for (int x = 0; x < width; x++) {
  		if (dense_matrix[x + y*width] != 255) {
  			if (elems == NULL) {
  			  elems_pointer = create_elem(x, dense_matrix[x + y*width]);
  				elems = elems_pointer;
  			} else {
  				elems_pointer->next = create_elem(x, dense_matrix[x + y*width]);
  				elems_pointer = elems_pointer->next;
  			}
  		}
  	}
  	if (elems != NULL) {
  		if (rows == NULL) {
  			row_pointer = create_row(y, elems);
  			rows = row_pointer;
  		} else {
  			row_pointer->next = create_row(y, elems);
  			row_pointer = row_pointer->next;
  		}
  	}
  }
  return rows;

  return NULL;
}

/* Frees all memory associated with SPARSE. SPARSE may be NULL. */
void free_sparse(Row *sparse) {
	Row *row;
	Elem *elems;
  Row *row_pointer = sparse;
  while (row_pointer != NULL) {
  	Elem *elems_pointer = row_pointer->elems;
  	while (elems_pointer != NULL) {
  		elems = elems_pointer;
  		elems_pointer = elems_pointer->next;
  		free(elems);
  	}
  	row = row_pointer;
  	row_pointer = row_pointer->next;
  	free(row);
  }
}

