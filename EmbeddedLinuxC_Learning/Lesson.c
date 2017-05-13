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
	return 0;
}