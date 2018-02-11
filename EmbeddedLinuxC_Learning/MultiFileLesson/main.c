/* main.c */
#include <stdio.h>

extern void push(char c);
extern char pop(void);
extern int is_empty(void);
extern int top;

int a,b = 1;

int main(void)
{
	push('a');
	push('b');
	push('c');

	while (!is_empty()) {
		putchar(pop());
	}
	putchar('\n');

	printf("Top is %d\n", top);

	return 0;
}