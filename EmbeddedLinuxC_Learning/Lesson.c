#include <stdio.h>
#include <math.h>

typedef struct Point
{
	double x;
	double y;
}tPoint;

const double pi = 3.1416;

double getRadius(tPoint point1, tPoint point2)
{
	double radiusNum = 0;

	radiusNum = sqrt(pow((point2.x - point1.x), 2) + pow((point2.y - point1.y), 2));
	printf("radiusNum is %f\n", radiusNum);
	return radiusNum;
}

double getArea(double radiusNum)
{
	double areaNum = 0;

	areaNum = pi * pow(radiusNum, 2);
	printf("areaNum is %f\n", areaNum);
    return areaNum;
}

int Fibonacci(int n)
{
    int ret = 0;

	if (n < 0) {
		ret = -1;
	} else if (n == 0) {
		ret = 0;
	} else if (n == 1) {
		ret = 1;
	} else {
		ret = Fibonacci(n - 1) + Fibonacci(n - 2);
	}
	return ret;
}

int FibonacciLoop(int n)
{
    int ret = 0;
    int fn1 = 0, fn2 = 1;

    if (n < 2)
    	return n;
    else {
    	while (n >= 2) {
    		ret = fn1 + fn2;
    		fn1 = fn2;
    		fn2 = ret;
    		n--;
    	}
    	return ret;
    }
}

int main(int argc, char *argv[])
{
    float number = -112;
    float sqrtnum = 121;
    int printLen = 0;

    tPoint point1 = {1, 2};
    tPoint point2 = {4, 6};

	printLen = printf("Hello world!\n");
	printLen = printf("character: %c\ninteger: %d\nfloating point: %f, printLen = %d\n", '}', 34, 3.14, printLen);
	printLen = printf("sin(pi/2)=%f\nln1=%f, printLen = %d\n", sin(pi/2), log(1.0), printLen);

	printLen = printf("absolute of number is %f\n", fabs(number));
	printLen = printf("sqrt of number is %f\n", sqrt(sqrtnum));

	printLen = printf("Area of (1, 2) (4, 6) is %f\n", getArea(getRadius(point1, point2)));

	printLen = printf("Fibonacci of 10 is %d\n", Fibonacci(10));
	printLen = printf("FibonacciLoop of 10 is %d\n", FibonacciLoop(10));
	return 0;
}