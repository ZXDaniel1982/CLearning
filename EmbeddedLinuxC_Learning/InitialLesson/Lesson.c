#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>

#include "Lesson.h"

#define N 20

typedef struct Point {
    double x;
    double y;
} tPoint;

const double pi = 3.1416;

double getRadius(tPoint point1, tPoint point2)
{
    double radiusNum = 0;

    radiusNum =
        sqrt(pow((point2.x - point1.x), 2) +
             pow((point2.y - point1.y), 2));
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

int *printRandom(int upperBand)
{
    int *a;

    a = malloc(N * sizeof(int));

    for (int i = 0; i < N; i++) {
        *(a + i) = rand() % upperBand;
    }

    return a;
}

void GestureGame(int man)
{
    static const char gesture[3][10] = {
        "scissor", "stone", "cloth"
    };
    int computer = 0, ran = 0, diff = 0;

    printf("\n");
    if ((man < 0) || (man > 2)) {
        printf("Invalid input gesture\n");
        return;
    } else {
        printf("Input gesture is %s\n", gesture[man]);
    }
    // Generate new random values every time
    srand((unsigned) time(NULL));
    for (int i = 0; i < 5; i++) {
        printf("Random number is %d\n", ran = rand());
        computer = ran % 3;
        if (man == computer) {
            printf("Equal man=%s computer=%s\n", gesture[man],
                   gesture[computer]);
        } else {
            diff = (man - computer + 2) % 3;
            if (diff == 0)
                printf("Win man=%s computer=%s\n",
                       gesture[man], gesture[computer]);
            else
                printf("Loss man=%s computer=%s\n",
                       gesture[man], gesture[computer]);
        }
    }
    return;
}

void LowToHighInsert()
{
    int a[10];
    int b[10];
    int cost = 0, key;

    memset(b, 11, sizeof(int) * 10);

    printf("Generateing random array ...\n");
    for (int i = 0; i < 10; i++) {
        a[i] = rand() % 10 + 1;
        printf("%d ", a[i]);
    }
    printf("\n");

    for (int i = 0; i < 10; i++) {
        for (int j = i; j >= 0; j--) {
            if (a[i] < b[j]) {
                cost++;
                if (i < 9)
                    b[j + 1] = b[j];
                b[j] = a[i];
            } else {
                break;
            }
        }
    }

    printf("The result array ...\n");
    for (int i = 0; i < 10; i++) {
        printf("%d ", b[i]);
    }
    printf("\n");
    printf("The total cost is %d\n\n", cost);

    cost = 0;
    for (int i = 1; i < 10; i++) {
        int j;
        key = a[i];
        j = i - 1;
        while (j >= 0 && a[j] > key) {
            a[j + 1] = a[j];
            j--;
            cost++;
        }
        a[j + 1] = key;
    }

    printf("The result array ...\n");
    for (int i = 0; i < 10; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
    printf("The total cost is %d\n", cost);
}

#define LOWERTOHIGH_MERGE_LEN 8

/*
void LowToHighMerge(void)
{
    int a[10];
    int mid, end;

    end = 10;
    mid = end/10;

    printf("Generateing random array ...\n");
    printf("sort (0 ~ %d, %d ~ %d)\n", mid, mid + 1, end);
    for (int i = 0; i < 10; i++) {
        a[i] = rand() % 10 + 1;
        print("%d ", a[i]);
    }
    printf("\n");

} */

void Algorithm(void)
{
    LowToHighInsert();
    // LowToHighMerge();
}

bool isEmpty(int count)
{
    if(count == 0) {
        return true;
    } else {
        return false;
    }            
}

void StackSim(void)
{
    char stack[128];
    int count = 0;

    PushSim('a', count, stack);
    PushSim('b', count, stack);
    PushSim('c', count, stack);

    while (!isEmpty(count)) {
        PopSim(count, stack);
    }
}

void TypeConversion()
{
    unsigned char c1 = 255, c2 = 2;
    unsigned char cOverflow;
    int cConvert;

    unsigned int i1 = 5;
    int i2 = -3;

    cOverflow = c1 + c2;
    cConvert = c1 + c2;

    printf("char overflow is %d convert is %d\n", cOverflow, cConvert);

    
    printf("int convert is %d\n", i1 + i2);
}

int main(int argc, char *argv[])
{
    float number = -112;
    float sqrtnum = 121;
    int printLen = 0;
    int *randomNum;

    tPoint point1 = { 1, 2 };
    tPoint point2 = { 4, 6 };

    printLen = printf("Hello world!\n");
    printLen =
        printf
        ("character: %c\ninteger: %d\nfloating point: %f, printLen = %d\n",
         '}', 34, 3.14, printLen);
    printLen =
        printf("sin(pi/2)=%f\nln1=%f, printLen = %d\n", sin(pi / 2),
               log(1.0), printLen);

    printLen = printf("absolute of number is %f\n", fabs(number));
    printLen = printf("sqrt of number is %f\n", sqrt(sqrtnum));

    printLen =
        printf("Area of (1, 2) (4, 6) is %f\n",
               getArea(getRadius(point1, point2)));

    printLen = printf("Fibonacci of 10 is %d\n", Fibonacci(10));
    printLen = printf("FibonacciLoop of 10 is %d\n", FibonacciLoop(10));

    randomNum = printRandom(10);
    printf("Generateing 20 random number :");
    for (int i = 0; i < N; i++) {
        printf(" %d", *(randomNum + i));
    }
    printf("\n");
    free(randomNum);

    GestureGame(1);

    Algorithm();

    StackSim();

    TypeConversion();
    return 0;
}
