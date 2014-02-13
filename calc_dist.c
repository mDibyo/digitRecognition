/*
 * PROJ1-1: YOUR TASK A CODE HERE
 *
 * You MUST implement the calc_min_dist() function in this file.
 *
 * You do not need to implement/use the swap(), flip_horizontal(), transpose(), or rotate_ccw_90()
 * functions, but you may find them useful. Feel free to define additional helper functions.
 */

#include <stdlib.h>
#include <stdio.h>
#include "digit_rec.h"
#include "utils.h"
#include "limits.h"

/* Find the squared difference between two pixels */
unsigned int squared_distance(unsigned char d1, unsigned char d2) {
	unsigned int distance = d1 - d2;
	return (distance * distance);
}

/* Swaps the values pointed to by the pointers X and Y. */
void swap_char(unsigned char *x, unsigned char *y) {
    unsigned char temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

/* Swaps the values pointed to by the pointers X and Y. */
void swap_int(int *x, int *y) {
    int temp;
    temp = *x;
    *x = *y;
    *y = temp;
}



/* Flips the elements of a square array ARR across the y-axis. */
void flip_horizontal(unsigned char *arr, int *width, int *height) {
    unsigned char width_char = (unsigned char) *width;
    for (int i = 0; i < *height; i++) {
    	for (int j = 0; j < (*width / 2); j++) {
    		swap_char(arr + (*width)*i + j, arr + (*width)*i + (*width) - j - 1);
   			// swap(arr[i][j], arr[i][width - j - 1]);
   		}
    }
}

/* Transposes the square array ARR. */
unsigned char * transpose(unsigned char *arr, int *width, int *height) {
   unsigned char *result;
    result = (unsigned char*) malloc(sizeof(unsigned char) * *width * *height);
    // printf("%d %d %d \n", (int) sizeof(*arr), (int) sizeof(unsigned char), *width);
    // int height = sizeof(arr) / sizeof(char) / width;
    // printf("%d\n", *height);
    for (int i = 0; i < *height; i++) {
    	for (int j = 0; j < *width; j++) {
    		result[i + j * *height] = arr[i * *width + j];
    	}
    }
    swap_int(width, height);
    return result; 
}

/* Rotates the square array ARR by 90 degrees counterclockwise. */
void rotate_ccw_90(unsigned char *arr, int *width, int *height) {
    arr = transpose(arr, width, height);
    flip_horizontal(arr, width, height);
}

/* Find sum of squares pixel to pixel of two square images of the same size and
 * compare to existing sum.
 */
unsigned int least_sum_squares(unsigned char *i1, unsigned char *i2,
        int width, unsigned int *least_sum) {
    unsigned int sum = 0;
    for (int i; i < (width*width); i++) {
        sum += squared_distance(i1[i], i2[i]);
    }
    if (sum < *least_sum) {
        *least_sum = sum;
    }
}

/* Returns the squared Euclidean distance between TEMPLATE and IMAGE. The size of IMAGE
 * is I_WIDTH * I_HEIGHT, while TEMPLATE is square with side length T_WIDTH. The template
 * image should be flipped, rotated, and translated across IMAGE.
 */
unsigned int calc_min_dist(unsigned char *image, int i_width, int i_height, 
        unsigned char *template, int t_width) {
    unsigned int min_dist = UINT_MAX;
    // 0 degrees
    least_sum_squares(image, template, t_width, &min_dist);
    flip_horizontal(image, &i_width, &i_height);    
    least_sum_squares(image, template, t_width, &min_dist);
    // 90 degrees
    rotate_ccw_90(image, &i_width, &i_height);
    least_sum_squares(image, template, t_width, &min_dist);
    flip_horizontal(image, &i_width, &i_height);    
    least_sum_squares(image, template, t_width, &min_dist);
    // 180 degrees
    rotate_ccw_90(image, &i_width, &i_height);
    least_sum_squares(image, template, t_width, &min_dist);
    flip_horizontal(image, &i_width, &i_height);    
    least_sum_squares(image, template, t_width, &min_dist);
    // 270 degrees
    rotate_ccw_90(image, &i_width, &i_height);
    least_sum_squares(image, template, t_width, &min_dist);
    flip_horizontal(image, &i_width, &i_height);    
    least_sum_squares(image, template, t_width, &min_dist);
    return min_dist;
}

  
